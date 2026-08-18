#!/usr/bin/env bash
#
# mac-cleanup.test.sh - mac-cleanup.sh のブラックボックステスト
#
# 実行対象は常に sandbox の HOME / TMPDIR なので、実マシンのキャッシュには触れない。
#
#   bin/tests/mac-cleanup.test.sh
#
set -uo pipefail

TARGET="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/mac-cleanup.sh"
# テスト中は PATH を絞る(go / uv を見つけさせない)ので、interpreter は明示する。
# 絞った PATH のままだと macOS 同梱の /bin/bash 3.2 が拾われてしまうため。
BASH_BIN="$(command -v bash)"
if (( BASH_VERSINFO[0] < 4 )); then
    echo "this test needs bash 4 or newer (running ${BASH_VERSION})" >&2
    exit 1
fi
WORK="$(mktemp -d "${TMPDIR:-/tmp}/mac-cleanup-test.XXXXXX")"
trap 'rm -rf "${WORK:?}"' EXIT

PASS=0
FAIL=0

ok()   { printf "  [PASS] %s\n" "$1"; PASS=$((PASS + 1)); }
ng()   { printf "  [FAIL] %s\n" "$1"; FAIL=$((FAIL + 1)); }
case_() { printf "\n== %s ==\n" "$1"; }

assert_exists()     { [[ -e "$1" ]] && ok "$2" || ng "$2 (missing: $1)"; }
assert_not_exists() { [[ ! -e "$1" ]] && ok "$2" || ng "$2 (still there: $1)"; }
assert_contains()   { grep -qF -- "$2" <<<"$1" && ok "$3" || ng "$3 (output lacks: $2)"; }
assert_status()     { [[ "$1" -eq "$2" ]] && ok "$3" || ng "$3 (exit=$1 want=$2)"; }

# sandbox の HOME / TMPDIR を作り直し、キャッシュの中身を仕込む
new_sandbox() {
    local name="$1"
    SB="$WORK/$name"
    rm -rf "${SB:?}"
    HOME_DIR="$SB/home"
    TMP_DIR="$SB/tmp"
    mkdir -p "$HOME_DIR/Library/Caches/go-build" "$HOME_DIR/go/pkg/mod" \
             "$HOME_DIR/.cache/uv" "$TMP_DIR"
    echo x > "$HOME_DIR/Library/Caches/go-build/entry"
    echo x > "$HOME_DIR/go/pkg/mod/entry"
    echo x > "$HOME_DIR/.cache/uv/entry"
}

# $HOME 配下に go の偽物を置く。go env の応答と clean の呼び出しを記録する
install_fake_go() {
    local dir="$HOME_DIR/.gvm/gos/go1.99.0/bin"
    mkdir -p "$dir"
    cat > "$dir/go" <<'EOS'
#!/usr/bin/env bash
if [[ "$1" == "env" ]]; then
    case "$2" in
        GOCACHE)    echo "$HOME/Library/Caches/go-build" ;;
        GOMODCACHE) echo "$HOME/go/pkg/mod" ;;
    esac
    exit 0
fi
if [[ "$1" == "clean" ]]; then
    echo "$*" >> "$HOME/.fake-go-clean.log"
    rm -rf "$HOME/Library/Caches/go-build" "$HOME/go/pkg/mod"
fi
EOS
    chmod +x "$dir/go"
}

# sandbox の HOME / TMPDIR で mac-cleanup.sh を動かす。PATH からは go と uv を外す
run_target() {
    OUT="$(env -u GOCACHE -u GOMODCACHE -u UV_CACHE_DIR \
        HOME="$HOME_DIR" TMPDIR="$TMP_DIR" PATH="/usr/bin:/bin:/usr/sbin:/sbin" \
        "$BASH_BIN" "$TARGET" "$@" 2>&1)"
    STATUS=$?
}

echo "target: $TARGET"
echo "workdir: $WORK"

# ---------------------------------------------------------------- find_go_bin

case_ "go が PATH にも既定パスにも無いとき、GOCACHE と GOMODCACHE を直接消す"
new_sandbox nogo
run_target go
assert_status "$STATUS" 0 "exit 0 で終わる"
assert_contains "$OUT" "go not found" "go 未検出を警告する"
assert_not_exists "$HOME_DIR/Library/Caches/go-build" "GOCACHE を削除した"
assert_not_exists "$HOME_DIR/go/pkg/mod" "GOMODCACHE を削除した"

case_ "go が PATH に無くても ~/.gvm/gos/*/bin/go を見つけて go clean を呼ぶ"
new_sandbox gvmgo
install_fake_go
# 解決した go のパスは --dry-run の表示でしか確認できない(実行時は出力しない)
run_target --dry-run go
assert_contains "$OUT" "go1.99.0/bin/go clean" "見つけた go のパスで clean を実行する"
run_target go
assert_status "$STATUS" 0 "exit 0 で終わる"
assert_exists "$HOME_DIR/.fake-go-clean.log" "go clean が実際に呼ばれた"
assert_contains "$(cat "$HOME_DIR/.fake-go-clean.log" 2>/dev/null)" \
    "clean -cache -modcache -testcache" "clean に 3 つのフラグを渡す"
assert_not_exists "$HOME_DIR/Library/Caches/go-build" "GOCACHE が空になった"

case_ "--dry-run では何も消さない"
new_sandbox dryrun
run_target --dry-run go
assert_status "$STATUS" 0 "exit 0 で終わる"
assert_contains "$OUT" "DRY-RUN" "DRY-RUN と表示する"
assert_exists "$HOME_DIR/Library/Caches/go-build/entry" "GOCACHE が残っている"
assert_exists "$HOME_DIR/go/pkg/mod/entry" "GOMODCACHE が残っている"

case_ "GOCACHE / GOMODCACHE の環境変数を優先する"
new_sandbox goenv
mkdir -p "$SB/custom-cache" "$SB/custom-mod"
echo x > "$SB/custom-cache/entry"
echo x > "$SB/custom-mod/entry"
OUT="$(env -u UV_CACHE_DIR HOME="$HOME_DIR" TMPDIR="$TMP_DIR" \
    PATH="/usr/bin:/bin:/usr/sbin:/sbin" \
    GOCACHE="$SB/custom-cache" GOMODCACHE="$SB/custom-mod" \
    "$BASH_BIN" "$TARGET" go 2>&1)"
STATUS=$?
assert_status "$STATUS" 0 "exit 0 で終わる"
assert_not_exists "$SB/custom-cache" "GOCACHE が指すディレクトリを消した"
assert_not_exists "$SB/custom-mod" "GOMODCACHE が指すディレクトリを消した"
assert_exists "$HOME_DIR/Library/Caches/go-build/entry" "既定パスには触っていない"

# -------------------------------------------------------------- cleanup_go_tmp

case_ "\$TMPDIR の go-build* は古いものだけ消す"
new_sandbox gotmp
mkdir -p "$TMP_DIR/go-build-old" "$TMP_DIR/go-build-fresh" \
         "$TMP_DIR/go-build-old-outside-fresh-inside" "$TMP_DIR/not-go-build"
echo x > "$TMP_DIR/go-build-old/f"
echo x > "$TMP_DIR/go-build-fresh/f"
echo x > "$TMP_DIR/go-build-old-outside-fresh-inside/f"
echo x > "$TMP_DIR/not-go-build/f"
# 古い: ディレクトリも中身も 1 日前
touch -t 202501010000 "$TMP_DIR/go-build-old/f" "$TMP_DIR/go-build-old"
touch -t 202501010000 "$TMP_DIR/not-go-build/f" "$TMP_DIR/not-go-build"
# ディレクトリ自身は古いが中身が新しい = 実行中のビルド相当
touch -t 202501010000 "$TMP_DIR/go-build-old-outside-fresh-inside"
run_target go
assert_not_exists "$TMP_DIR/go-build-old" "古い go-build を消した"
assert_exists "$TMP_DIR/go-build-fresh" "新しい go-build は残した"
assert_exists "$TMP_DIR/go-build-old-outside-fresh-inside" \
    "中身が新しい go-build は残した (実行中ビルドの保護)"
assert_exists "$TMP_DIR/not-go-build" "go-build 以外のディレクトリには触らない"

case_ "\$TMPDIR に go-build* が無くても落ちない"
new_sandbox gotmpempty
run_target go
assert_status "$STATUS" 0 "exit 0 で終わる"

# ------------------------------------------------------------------ cleanup_uv

case_ "uv キャッシュを消す"
new_sandbox uv
run_target uv
assert_status "$STATUS" 0 "exit 0 で終わる"
assert_not_exists "$HOME_DIR/.cache/uv" "~/.cache/uv を削除した"

case_ "uv は --dry-run で消さない"
new_sandbox uvdry
run_target --dry-run uv
assert_exists "$HOME_DIR/.cache/uv/entry" "~/.cache/uv が残っている"

case_ "UV_CACHE_DIR の環境変数を優先する"
new_sandbox uvenv
mkdir -p "$SB/custom-uv"
echo x > "$SB/custom-uv/entry"
OUT="$(HOME="$HOME_DIR" TMPDIR="$TMP_DIR" PATH="/usr/bin:/bin:/usr/sbin:/sbin" \
    UV_CACHE_DIR="$SB/custom-uv" "$BASH_BIN" "$TARGET" uv 2>&1)"
STATUS=$?
assert_not_exists "$SB/custom-uv" "UV_CACHE_DIR が指すディレクトリを消した"
assert_exists "$HOME_DIR/.cache/uv/entry" "既定パスには触っていない"

# ------------------------------------------------------------------- CLI 表面

case_ "CLI の表面"
new_sandbox cli
run_target --help
assert_contains "$OUT" "uv" "--help の TARGETS に uv がある"
run_target --list
assert_status "$STATUS" 0 "--list が exit 0"
assert_contains "$OUT" "GOCACHE" "--list が GOCACHE を表示する"
assert_contains "$OUT" "uv" "--list が uv を表示する"
run_target --status
assert_status "$STATUS" 0 "--status が exit 0"
assert_contains "$OUT" "Go build cache" "--status が Go build cache を表示する"
assert_contains "$OUT" "/System/Volumes/Data" "--status が Data volume を表示する"
run_target definitely-not-a-target
assert_contains "$OUT" "Unknown target" "未知のターゲットを拒否する"

case_ "標準入力を読むコマンドがあってもハングしない"
new_sandbox stdinhang
# データが永遠に来ない FIFO を stdin にする。スクリプトが端末から読む作りだと
# ここで無限に待つ (実機で 30 分止まった現象と同じ形)。
FIFO="$SB/never-writes"
mkfifo "$FIFO"
sleep 120 > "$FIFO" &
FIFO_WRITER=$!
(
    env -u GOCACHE -u GOMODCACHE -u UV_CACHE_DIR \
        HOME="$HOME_DIR" TMPDIR="$TMP_DIR" PATH="/usr/bin:/bin:/usr/sbin:/sbin" \
        "$BASH_BIN" "$TARGET" go uv < "$FIFO" > "$SB/out.log" 2>&1
    echo "$?" > "$SB/exit-code"
) &
RUNNER=$!
WAITED=0
while kill -0 "$RUNNER" 2>/dev/null && [[ "$WAITED" -lt 30 ]]; do
    sleep 1
    WAITED=$((WAITED + 1))
done
if kill -0 "$RUNNER" 2>/dev/null; then
    kill -9 "$RUNNER" 2>/dev/null
    ng "30 秒以内に終わる (入力待ちでハングした)"
else
    ok "30 秒以内に終わる (入力待ちにならない)"
    assert_status "$(cat "$SB/exit-code" 2>/dev/null || echo 99)" 0 "exit 0 で終わる"
    assert_not_exists "$HOME_DIR/Library/Caches/go-build" "掃除も実行されている"
fi
kill "$FIFO_WRITER" 2>/dev/null || true

case_ "bash 3 では黙って空振りせず、はっきり失敗する"
new_sandbox oldbash
if [[ -x /bin/bash ]] && [[ "$(/bin/bash -c 'echo ${BASH_VERSINFO[0]}')" -lt 4 ]]; then
    OUT="$(HOME="$HOME_DIR" TMPDIR="$TMP_DIR" /bin/bash "$TARGET" --help 2>&1)"
    STATUS=$?
    assert_status "$STATUS" 1 "exit 1 で終わる"
    assert_contains "$OUT" "requires bash 4 or newer" "必要な bash 版を伝える"
    assert_exists "$HOME_DIR/Library/Caches/go-build/entry" "何も消していない"
else
    ok "skip: /bin/bash が bash 4 以上なので当ケースは対象外"
fi

printf "\n=========================\n"
printf "PASS: %d  FAIL: %d\n" "$PASS" "$FAIL"
printf "=========================\n"
[[ "$FAIL" -eq 0 ]]
