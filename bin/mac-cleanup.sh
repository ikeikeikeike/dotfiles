#!/usr/bin/env bash
#
# mac-cleanup.sh - macOS Disk Cleanup Script
#
# Usage:
#   mac-cleanup.sh nix npm go          # 指定項目をクリーンアップ
#   mac-cleanup.sh --list              # 利用可能な項目を表示
#   mac-cleanup.sh --all               # 全項目をクリーンアップ
#   mac-cleanup.sh --dry-run nix npm   # 削除せずにサイズ確認
#   mac-cleanup.sh --status            # 現在のディスク使用状況
#

set -euo pipefail

# ===== 色定義 =====
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ===== グローバル変数 =====
DRY_RUN=false
VERBOSE=false
LOG_FILE="$HOME/.mac-cleanup.log"

# ===== ユーティリティ =====

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" >> "$LOG_FILE"
}

info()    { echo -e "${BLUE}[INFO]${NC} $*"; }
success() { echo -e "${GREEN}[OK]${NC} $*"; }
warn()    { echo -e "${YELLOW}[WARN]${NC} $*"; }
error()   { echo -e "${RED}[ERROR]${NC} $*"; }
dry()     { echo -e "${DIM}[DRY-RUN]${NC} $*"; }

get_size() {
    local path="$1"
    if [[ -e "$path" ]]; then
        du -sh "$path" 2>/dev/null | awk '{print $1}'
    else
        echo "N/A"
    fi
}

command_exists() {
    command -v "$1" &>/dev/null
}

safe_rm() {
    local path="$1"
    if [[ -e "$path" ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "Would delete: $path ($(get_size "$path"))"
        else
            rm -rf "$path"
            success "Deleted: $path"
            log "Deleted: $path"
        fi
    fi
}

# ===== クリーンアップ関数 =====

cleanup_nix() {
    echo -e "\n${BOLD}=== Nix ===${NC}"
    if ! command_exists nix; then
        warn "Nix not installed"
        return 0
    fi
    info "Current: $(get_size /nix/store)"
    if [[ "$DRY_RUN" == true ]]; then
        dry "nix-collect-garbage -d && nix store optimise"
    else
        nix-collect-garbage -d 2>/dev/null || true
        nix store optimise 2>/dev/null || true
        success "Done: $(get_size /nix/store)"
        log "Nix cleaned"
    fi
}

cleanup_go() {
    echo -e "\n${BOLD}=== Go ===${NC}"
    info "Current: $(get_size "$HOME/go")"
    if command_exists go; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "go clean -cache -modcache -testcache"
        else
            go clean -cache -modcache -testcache 2>/dev/null || true
            success "Done: $(get_size "$HOME/go")"
            log "Go cleaned"
        fi
    else
        safe_rm "$HOME/go/pkg/mod"
    fi
}

cleanup_npm() {
    echo -e "\n${BOLD}=== npm ===${NC}"
    info "Current: $(get_size "$HOME/.npm")"
    if command_exists npm; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "npm cache clean --force"
        else
            npm cache clean --force 2>/dev/null || true
            success "Done: $(get_size "$HOME/.npm")"
            log "npm cleaned"
        fi
    else
        safe_rm "$HOME/.npm/_cacache"
    fi
}

cleanup_macports() {
    echo -e "\n${BOLD}=== MacPorts ===${NC}"
    if ! command_exists port; then
        warn "MacPorts not installed"
        return 0
    fi
    info "Current: $(get_size /opt/local)"
    if [[ "$DRY_RUN" == true ]]; then
        dry "sudo port reclaim && sudo port uninstall inactive"
    else
        sudo port reclaim 2>/dev/null || true
        sudo port uninstall inactive 2>/dev/null || true
        success "Done: $(get_size /opt/local)"
        log "MacPorts cleaned"
    fi
}

cleanup_homebrew() {
    echo -e "\n${BOLD}=== Homebrew ===${NC}"
    if ! command_exists brew; then
        warn "Homebrew not installed"
        return 0
    fi
    local prefix
    prefix=$(brew --prefix 2>/dev/null)
    info "Current: $(get_size "$prefix/Cellar")"
    if [[ "$DRY_RUN" == true ]]; then
        dry "brew cleanup -s && brew autoremove"
    else
        brew cleanup -s 2>/dev/null || true
        brew autoremove 2>/dev/null || true
        safe_rm "$HOME/Library/Caches/Homebrew"
        success "Done: $(get_size "$prefix/Cellar")"
        log "Homebrew cleaned"
    fi
}

cleanup_pip() {
    echo -e "\n${BOLD}=== pip ===${NC}"
    info "Current: $(get_size "$HOME/.cache/pip")"
    if command_exists pip3; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "pip3 cache purge"
        else
            pip3 cache purge 2>/dev/null || true
        fi
    fi
    safe_rm "$HOME/.cache/pip"
    safe_rm "$HOME/Library/Caches/pip"
    success "Done"
    log "pip cleaned"
}

cleanup_cargo() {
    echo -e "\n${BOLD}=== Cargo/Rust ===${NC}"
    local cargo_dir="$HOME/.cargo"
    if [[ ! -d "$cargo_dir" ]]; then
        warn "Cargo not installed"
        return 0
    fi
    info "Current: $(get_size "$cargo_dir")"
    safe_rm "$cargo_dir/registry/cache"
    safe_rm "$cargo_dir/registry/src"
    safe_rm "$cargo_dir/git/checkouts"
    success "Done: $(get_size "$cargo_dir")"
    log "Cargo cleaned"
}

cleanup_nvm() {
    echo -e "\n${BOLD}=== nvm ===${NC}"
    local nvm_dir="${NVM_DIR:-$HOME/.nvm}"
    if [[ ! -d "$nvm_dir" ]]; then
        warn "nvm not installed"
        return 0
    fi
    info "Current: $(get_size "$nvm_dir")"
    safe_rm "$nvm_dir/.cache"
    success "Done"
    log "nvm cleaned"
}

cleanup_yarn() {
    echo -e "\n${BOLD}=== yarn ===${NC}"
    info "yarn cache: $(get_size "$HOME/.yarn/cache")"
    info "Yarn v1 cache: $(get_size "$HOME/Library/Caches/Yarn")"
    if command_exists yarn; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "yarn cache clean"
        else
            yarn cache clean 2>/dev/null || true
        fi
    fi
    safe_rm "$HOME/Library/Caches/Yarn"
    success "Done"
    log "yarn cleaned"
}

cleanup_pnpm() {
    echo -e "\n${BOLD}=== pnpm ===${NC}"
    info "Current: $(get_size "$HOME/.pnpm-store")"
    if command_exists pnpm; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "pnpm store prune"
        else
            pnpm store prune 2>/dev/null || true
        fi
    fi
    safe_rm "$HOME/Library/Caches/pnpm"
    success "Done"
    log "pnpm cleaned"
}

cleanup_caches() {
    echo -e "\n${BOLD}=== ~/Library/Caches ===${NC}"
    info "Current: $(get_size "$HOME/Library/Caches")"

    local safe_caches=(
        "com.apple.dt.Xcode"
        "com.spotify.client"
        "com.microsoft.VSCode"
        "com.microsoft.VSCode.ShipIt"
        "com.googlecode.iterm2"
        "org.mozilla.firefox"
        "com.brave.Browser"
        "Yarn"
        "pip"
        "CocoaPods"
        "org.swift.swiftpm"
        "Google/Chrome/Default/Cache"
        "Google/Chrome/Default/Code Cache"
    )

    for cache in "${safe_caches[@]}"; do
        safe_rm "$HOME/Library/Caches/$cache"
    done
    success "Done: $(get_size "$HOME/Library/Caches")"
    log "User caches cleaned"
}

cleanup_logs() {
    echo -e "\n${BOLD}=== Logs ===${NC}"
    info "User logs: $(get_size "$HOME/Library/Logs")"
    if [[ "$DRY_RUN" == true ]]; then
        dry "Delete logs older than 30 days"
    else
        find "$HOME/Library/Logs" -type f -mtime +30 -delete 2>/dev/null || true
        success "Done: $(get_size "$HOME/Library/Logs")"
        log "Logs cleaned"
    fi
}

cleanup_trash() {
    echo -e "\n${BOLD}=== Trash ===${NC}"
    info "Current: $(get_size "$HOME/.Trash")"
    safe_rm "$HOME/.Trash"/*
    success "Done"
    log "Trash emptied"
}

cleanup_xcode() {
    echo -e "\n${BOLD}=== Xcode ===${NC}"
    if [[ ! -d "/Applications/Xcode.app" ]]; then
        warn "Xcode not installed"
        return 0
    fi
    info "DerivedData: $(get_size "$HOME/Library/Developer/Xcode/DerivedData")"
    info "Archives: $(get_size "$HOME/Library/Developer/Xcode/Archives")"

    safe_rm "$HOME/Library/Developer/Xcode/DerivedData"
    safe_rm "$HOME/Library/Developer/Xcode/Archives"

    if [[ "$DRY_RUN" == true ]]; then
        dry "xcrun simctl delete unavailable"
    else
        xcrun simctl delete unavailable 2>/dev/null || true
    fi
    success "Done"
    log "Xcode cleaned"
}

cleanup_docker() {
    echo -e "\n${BOLD}=== Docker ===${NC}"
    if ! command_exists docker; then
        warn "Docker not installed"
        return 0
    fi
    if ! docker info &>/dev/null; then
        warn "Docker not running"
        return 0
    fi
    docker system df 2>/dev/null || true
    if [[ "$DRY_RUN" == true ]]; then
        dry "docker system prune -af && docker volume prune -f"
    else
        docker system prune -af 2>/dev/null || true
        docker volume prune -f 2>/dev/null || true
        success "Done"
        log "Docker cleaned"
    fi
}

cleanup_maven() {
    echo -e "\n${BOLD}=== Maven ===${NC}"
    if [[ ! -d "$HOME/.m2/repository" ]]; then
        warn "Maven repository not found"
        return 0
    fi
    info "Current: $(get_size "$HOME/.m2/repository")"
    safe_rm "$HOME/.m2/repository"
    success "Done"
    log "Maven cleaned"
}

cleanup_gradle() {
    echo -e "\n${BOLD}=== Gradle ===${NC}"
    if [[ ! -d "$HOME/.gradle" ]]; then
        warn "Gradle not found"
        return 0
    fi
    info "Current: $(get_size "$HOME/.gradle/caches")"
    safe_rm "$HOME/.gradle/caches"
    safe_rm "$HOME/.gradle/wrapper/dists"
    success "Done"
    log "Gradle cleaned"
}

cleanup_cocoapods() {
    echo -e "\n${BOLD}=== CocoaPods ===${NC}"
    info "Current: $(get_size "$HOME/Library/Caches/CocoaPods")"
    if command_exists pod; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "pod cache clean --all"
        else
            pod cache clean --all 2>/dev/null || true
        fi
    fi
    safe_rm "$HOME/Library/Caches/CocoaPods"
    success "Done"
    log "CocoaPods cleaned"
}

cleanup_browsers() {
    echo -e "\n${BOLD}=== Browsers ===${NC}"
    # Chrome
    info "Chrome: $(get_size "$HOME/Library/Caches/Google/Chrome")"
    safe_rm "$HOME/Library/Caches/Google/Chrome/Default/Cache"
    safe_rm "$HOME/Library/Caches/Google/Chrome/Default/Code Cache"
    safe_rm "$HOME/Library/Caches/Google/Chrome/Default/GPUCache"

    # Safari
    info "Safari: $(get_size "$HOME/Library/Caches/com.apple.Safari")"
    safe_rm "$HOME/Library/Caches/com.apple.Safari"

    # Firefox
    info "Firefox: $(get_size "$HOME/Library/Caches/Firefox")"
    safe_rm "$HOME/Library/Caches/Firefox"

    success "Done"
    log "Browsers cleaned"
}

cleanup_spotify() {
    echo -e "\n${BOLD}=== Spotify ===${NC}"
    info "Current: $(get_size "$HOME/Library/Caches/com.spotify.client")"
    safe_rm "$HOME/Library/Caches/com.spotify.client"
    safe_rm "$HOME/Library/Application Support/Spotify/PersistentCache"
    success "Done"
    log "Spotify cleaned"
}

cleanup_slack() {
    echo -e "\n${BOLD}=== Slack ===${NC}"
    info "Current: $(get_size "$HOME/Library/Caches/com.tinyspeck.slackmacgap")"
    safe_rm "$HOME/Library/Caches/com.tinyspeck.slackmacgap"
    safe_rm "$HOME/Library/Application Support/Slack/Service Worker/CacheStorage"
    success "Done"
    log "Slack cleaned"
}

cleanup_dns() {
    echo -e "\n${BOLD}=== DNS Cache ===${NC}"
    if [[ "$DRY_RUN" == true ]]; then
        dry "Flush DNS cache"
    else
        sudo dscacheutil -flushcache 2>/dev/null || true
        sudo killall -HUP mDNSResponder 2>/dev/null || true
        success "Done"
        log "DNS flushed"
    fi
}

cleanup_quicklook() {
    echo -e "\n${BOLD}=== QuickLook ===${NC}"
    if [[ "$DRY_RUN" == true ]]; then
        dry "Reset QuickLook cache"
    else
        qlmanage -r cache 2>/dev/null || true
        success "Done"
        log "QuickLook reset"
    fi
}

cleanup_font() {
    echo -e "\n${BOLD}=== Font Cache ===${NC}"
    if [[ "$DRY_RUN" == true ]]; then
        dry "Reset font cache"
    else
        sudo atsutil databases -remove 2>/dev/null || true
        success "Done"
        log "Font cache reset"
    fi
}

cleanup_dotcache() {
    echo -e "\n${BOLD}=== ~/.cache ===${NC}"
    info "Current: $(get_size "$HOME/.cache")"
    local items=("pip" "yarn" "go-build" "node" "typescript" "eslint" "prettier" "husky" "pre-commit")
    for item in "${items[@]}"; do
        safe_rm "$HOME/.cache/$item"
    done
    success "Done: $(get_size "$HOME/.cache")"
    log "~/.cache cleaned"
}

cleanup_timemachine() {
    echo -e "\n${BOLD}=== Time Machine ===${NC}"
    local count
    count=$(tmutil listlocalsnapshots / 2>/dev/null | wc -l | tr -d ' ')
    info "Local snapshots: $count"
    if [[ "$count" -gt 0 ]]; then
        if [[ "$DRY_RUN" == true ]]; then
            dry "Delete all local snapshots"
        else
            for snap in $(tmutil listlocalsnapshots / 2>/dev/null | grep -o 'com.apple.TimeMachine.*'); do
                sudo tmutil deletelocalsnapshots "${snap#com.apple.TimeMachine.}" 2>/dev/null || true
            done
            success "Done"
            log "Time Machine snapshots deleted"
        fi
    fi
}

cleanup_system() {
    echo -e "\n${BOLD}=== System Caches ===${NC}"
    info "/Library/Caches: $(get_size /Library/Caches)"
    info "/var/log: $(get_size /var/log)"
    if [[ "$DRY_RUN" == true ]]; then
        dry "Clean system caches (requires sudo)"
    else
        sudo rm -rf /Library/Caches/* 2>/dev/null || true
        sudo rm -rf /var/log/asl/*.asl 2>/dev/null || true
        success "Done"
        log "System caches cleaned"
    fi
}

# ===== 項目マッピング =====

declare -A CLEANUP_FUNCS=(
    [nix]=cleanup_nix
    [go]=cleanup_go
    [npm]=cleanup_npm
    [macports]=cleanup_macports
    [homebrew]=cleanup_homebrew
    [brew]=cleanup_homebrew
    [pip]=cleanup_pip
    [python]=cleanup_pip
    [cargo]=cleanup_cargo
    [rust]=cleanup_cargo
    [nvm]=cleanup_nvm
    [node]=cleanup_nvm
    [yarn]=cleanup_yarn
    [pnpm]=cleanup_pnpm
    [caches]=cleanup_caches
    [cache]=cleanup_caches
    [logs]=cleanup_logs
    [log]=cleanup_logs
    [trash]=cleanup_trash
    [xcode]=cleanup_xcode
    [docker]=cleanup_docker
    [maven]=cleanup_maven
    [gradle]=cleanup_gradle
    [cocoapods]=cleanup_cocoapods
    [pods]=cleanup_cocoapods
    [browsers]=cleanup_browsers
    [browser]=cleanup_browsers
    [chrome]=cleanup_browsers
    [spotify]=cleanup_spotify
    [slack]=cleanup_slack
    [dns]=cleanup_dns
    [quicklook]=cleanup_quicklook
    [ql]=cleanup_quicklook
    [font]=cleanup_font
    [fonts]=cleanup_font
    [dotcache]=cleanup_dotcache
    [timemachine]=cleanup_timemachine
    [tm]=cleanup_timemachine
    [system]=cleanup_system
)

# ===== コマンド =====

show_list() {
    echo -e "${BOLD}Available cleanup targets:${NC}\n"

    echo -e "${CYAN}Package Managers:${NC}"
    printf "  %-12s %s\n" "nix" "$(get_size /nix/store)"
    printf "  %-12s %s\n" "go" "$(get_size "$HOME/go")"
    printf "  %-12s %s\n" "npm" "$(get_size "$HOME/.npm")"
    printf "  %-12s %s\n" "macports" "$(get_size /opt/local)"
    printf "  %-12s %s\n" "homebrew" "$(command_exists brew && get_size "$(brew --prefix 2>/dev/null)/Cellar" || echo "N/A")"
    printf "  %-12s %s\n" "pip" "$(get_size "$HOME/.cache/pip")"
    printf "  %-12s %s\n" "cargo" "$(get_size "$HOME/.cargo")"
    printf "  %-12s %s\n" "nvm" "$(get_size "${NVM_DIR:-$HOME/.nvm}")"
    printf "  %-12s %s\n" "yarn" "$(get_size "$HOME/.yarn/cache")"
    printf "  %-12s %s\n" "pnpm" "$(get_size "$HOME/.pnpm-store")"

    echo -e "\n${CYAN}macOS:${NC}"
    printf "  %-12s %s\n" "caches" "$(get_size "$HOME/Library/Caches")"
    printf "  %-12s %s\n" "logs" "$(get_size "$HOME/Library/Logs")"
    printf "  %-12s %s\n" "trash" "$(get_size "$HOME/.Trash")"
    printf "  %-12s %s\n" "system" "/Library/Caches, /var/log"
    printf "  %-12s %s\n" "timemachine" "local snapshots"
    printf "  %-12s %s\n" "dns" "flush DNS"
    printf "  %-12s %s\n" "quicklook" "reset"
    printf "  %-12s %s\n" "font" "reset"

    echo -e "\n${CYAN}Development:${NC}"
    printf "  %-12s %s\n" "xcode" "$(get_size "$HOME/Library/Developer")"
    printf "  %-12s %s\n" "docker" "images, volumes"
    printf "  %-12s %s\n" "maven" "$(get_size "$HOME/.m2")"
    printf "  %-12s %s\n" "gradle" "$(get_size "$HOME/.gradle")"
    printf "  %-12s %s\n" "cocoapods" "$(get_size "$HOME/Library/Caches/CocoaPods")"

    echo -e "\n${CYAN}Apps:${NC}"
    printf "  %-12s %s\n" "browsers" "Chrome, Safari, Firefox"
    printf "  %-12s %s\n" "spotify" "$(get_size "$HOME/Library/Caches/com.spotify.client")"
    printf "  %-12s %s\n" "slack" "$(get_size "$HOME/Library/Caches/com.tinyspeck.slackmacgap")"

    echo -e "\n${CYAN}Other:${NC}"
    printf "  %-12s %s\n" "dotcache" "$(get_size "$HOME/.cache")"

    echo -e "\n${BOLD}Usage:${NC}"
    echo "  mac-cleanup.sh nix npm go     # Clean specific targets"
    echo "  mac-cleanup.sh --all          # Clean everything"
    echo "  mac-cleanup.sh --dry-run nix  # Preview only"
}

show_status() {
    echo -e "${BOLD}Disk Usage Summary${NC}\n"

    df -h / | tail -1 | awk '{printf "System: %s total, %s used, %s available (%s)\n\n", $2, $3, $4, $5}'

    echo -e "${CYAN}Top directories:${NC}"
    local dirs=(
        "/nix/store:Nix"
        "$HOME/Library/Caches:User Caches"
        "$HOME/Library/Application Support:App Support"
        "/opt/local:MacPorts"
        "$HOME/go:Go"
        "$HOME/.npm:npm"
        "$HOME/.cache:~/.cache"
        "$HOME/Library/Developer:Developer"
        "$HOME/.Trash:Trash"
    )

    for item in "${dirs[@]}"; do
        local path="${item%%:*}"
        local name="${item##*:}"
        if [[ -d "$path" ]]; then
            printf "  %-15s %s\n" "$name" "$(get_size "$path")"
        fi
    done
}

run_all() {
    cleanup_nix
    cleanup_go
    cleanup_npm
    cleanup_macports
    cleanup_homebrew
    cleanup_pip
    cleanup_cargo
    cleanup_nvm
    cleanup_yarn
    cleanup_pnpm
    cleanup_caches
    cleanup_logs
    cleanup_trash
    cleanup_xcode
    cleanup_docker
    cleanup_maven
    cleanup_gradle
    cleanup_cocoapods
    cleanup_browsers
    cleanup_spotify
    cleanup_slack
    cleanup_dns
    cleanup_quicklook
    cleanup_dotcache
    cleanup_timemachine
    cleanup_system
}

show_help() {
    cat << 'EOF'
mac-cleanup.sh - macOS Disk Cleanup Script

USAGE:
    mac-cleanup.sh [OPTIONS] [TARGETS...]

OPTIONS:
    --list, -l       Show available cleanup targets with sizes
    --status, -s     Show disk usage summary
    --all, -a        Run all cleanups
    --dry-run, -n    Preview what would be deleted
    --help, -h       Show this help

EXAMPLES:
    mac-cleanup.sh --list
    mac-cleanup.sh nix npm go
    mac-cleanup.sh --dry-run caches browsers
    mac-cleanup.sh --all

TARGETS:
    nix, go, npm, macports, homebrew, pip, cargo, nvm, yarn, pnpm,
    caches, logs, trash, system, timemachine, dns, quicklook, font,
    xcode, docker, maven, gradle, cocoapods, browsers, spotify, slack,
    dotcache
EOF
}

# ===== メイン =====

main() {
    local targets=()

    # 引数なしの場合
    if [[ $# -eq 0 ]]; then
        show_help
        exit 0
    fi

    # 引数解析
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --dry-run|-n)
                DRY_RUN=true
                shift
                ;;
            --all|-a)
                log "=== Cleanup ALL started ==="
                run_all
                log "=== Cleanup ALL finished ==="
                exit 0
                ;;
            --list|-l)
                show_list
                exit 0
                ;;
            --status|-s)
                show_status
                exit 0
                ;;
            --help|-h)
                show_help
                exit 0
                ;;
            -*)
                error "Unknown option: $1"
                exit 1
                ;;
            *)
                targets+=("$1")
                shift
                ;;
        esac
    done

    # ターゲットの実行
    if [[ ${#targets[@]} -eq 0 ]]; then
        show_help
        exit 0
    fi

    log "=== Cleanup started: ${targets[*]} ==="

    for target in "${targets[@]}"; do
        local func="${CLEANUP_FUNCS[$target]:-}"
        if [[ -n "$func" ]]; then
            $func
        else
            error "Unknown target: $target"
            echo "Run 'mac-cleanup.sh --list' to see available targets"
        fi
    done

    log "=== Cleanup finished ==="
    echo -e "\n${GREEN}Done!${NC} Log: $LOG_FILE"
}

main "$@"
