#!/usr/bin/env perl
# flycheck_haskell.pl

use strict;

### Please rewrite the following 3 variables 
### ($ghc, @ghc_options and @ghc_packages)

my $ghc = 'ghc'; # where is ghc
my @ghc_options  = ('-Wall');   # e.g. ('-fglasgow-exts')
my @ghc_packages = ();          # e.g. ('QuickCheck')

### the following should not been edited ###

my ($source, $base_dir) = @ARGV;

my @command = ($ghc,
            '--make',
            '-fno-code',
            "-i$base_dir",
            $source);

while(@ghc_options) {
    push(@command, shift @ghc_options);
}

while(@ghc_packages) {
    push(@command, '-package');
    push(@command, shift @ghc_packages);
}

open(MESSAGE, "@command 2>&1 |");
while(<MESSAGE>) {
    if(/(^\S+(\.hs|\.lhs))(:\d+:\d+:)\s?(.*)/) {
        print "\n";
        print $1;
        print $3;
        my $rest = $4;
        $rest =~ s/\s*$//s;
        print $rest;
        next;
    }
    elsif(/\s+(.*)/) {
        my $rest = $1;
        $rest =~ s/\s*$//s;
        print $rest;
        print " ";
        next;
    }
}
print "\n";
close(MESSAGE);

