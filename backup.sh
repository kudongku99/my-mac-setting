#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$REPO_DIR/home"

FILES=(
  Brewfile
  .config/mise/config.toml
  .zshrc
  .zprofile
  .p10k.zsh
)

log() { printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"; }

log "백업 시작"

if brew bundle dump --force --file="$HOME/Brewfile" >/dev/null 2>&1; then
  log "Brewfile 갱신 완료"
else
  log "Brewfile 갱신 실패, 기존 파일로 백업합니다"
fi

for f in "${FILES[@]}"; do
  src="$HOME/$f"
  dest="$BACKUP_DIR/$f"
  if [[ ! -f "$src" ]]; then
    log "건너뜀: $src 없음"
    continue
  fi
  mkdir -p "$(dirname "$dest")"
  cp -p "$src" "$dest"
done

cd "$REPO_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  log "git 저장소가 아니라서 복사만 하고 끝냅니다"
  exit 0
fi

git add -- home
if git diff --cached --quiet -- home; then
  log "변경 없음"
  exit 0
fi

git commit --quiet -m "backup: $(date '+%Y-%m-%d %H:%M')" -- home
log "커밋 완료: $(git log -1 --format=%h)"

if git remote get-url origin >/dev/null 2>&1; then
  git push --quiet origin HEAD
  log "push 완료"
else
  log "origin 리모트가 없어 push는 건너뜁니다"
fi
