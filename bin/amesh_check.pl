#!perl

use strict;
use warnings;
use utf8;

use FindBin;
use File::Temp 'tempfile';
use LWP::UserAgent;
use Digest::SHA1 'sha1_hex';
use Encode 'encode_utf8';
use Time::Piece;
use 5.014;

my $t = localtime;

# cronの設定は
# 1,6,11,16,21,26,31,36,41,46,51,56 7-23 * * * /path/to/amesh_check.pl > /tmp/amesh_check.log 2>&1
my $timecode = $t->ymd('') . sprintf('%02d%02d', $t->hour, $t->min - 1);

say "[debug] timecode: ${timecode}";

my $ua = LWP::UserAgent->new;
my $rain_file;

do {
    # http://tokyo-ame.jwa.or.jp/mesh/100/201307201605.gif
    my $res = $ua->get("http://tokyo-ame.jwa.or.jp/mesh/100/${timecode}.gif");
    my $fh;
    ($fh, $rain_file) = tempfile(SUFFIX => '.gif');
    print $fh $res->content;
    close $fh;
};

# im.kayac.com送信用。Config::Pit等で隠しておく
my $conf = {
    user => 'ikeikeikeike',
    secret_key => 'tatsuo4179',
};

my $found_percent = 0;
for my $percent (map { $_ * 10 } reverse (1 .. 10)) {
    my $ref_file = "$FindBin::Bin/rain_${percent}.png";
    # ↓気づいたらこんなことになっててちょっと泣きたい
    my ($fh, $tmpfile, $trimmed_file);
    ($fh, $tmpfile) = tempfile(SUFFIX => '.png');
    close $fh;
    ($fh, $trimmed_file) = tempfile(SUFFIX => '.png');
    close $fh;
    system("convert $rain_file $ref_file -alpha Set -compose Dst_In -composite $tmpfile");
    system("convert -fuzz 50% -trim $tmpfile $trimmed_file");
    my $res = `identify -format "%wx%h" $trimmed_file`;
    chomp $res;
    if ($res ne '1x1') {
        $found_percent = $percent;
        last;
    }
}

my $previous = previous_amedas();

# 前回より上がってる時は常に通知
if ($found_percent > $previous || 1) {
    my $fmt = "[アメッシュ] 自宅付近の降水確率は%d%%です";
    send_imkayac(sprintf $fmt, $found_percent);
}
# 0％になった時も安心するために通知しよう
elsif ($previous > $found_percent && $found_percent == 0) {
    send_imkayac("[アメッシュ] 自宅付近の降水確率が0%になりました");
}

previous_amedas($found_percent);

say "result: ${found_percent} %";

# 以下、util的な関数

sub previous_amedas {
    my $op = @_ ? '>' : '<';
    return 0 if $op eq '<' && !-f "$FindBin::Bin/previous_amedas";
    open my $fh, $op, "$FindBin::Bin/previous_amedas";
    my $content = $op eq '<' ? do { local $/; <$fh> } : $_[0];
    print $fh $content if $op eq '>';
    close $fh;
    return $content;
}

sub send_imkayac {
    my $message = shift;

    $message = encode_utf8 $message;

    $ua->post('http://im.kayac.com/api/post/' . $conf->{user}, [
        message => $message
        # sig => sha1_hex($message.$conf->{secret_key})
    ]);
}
