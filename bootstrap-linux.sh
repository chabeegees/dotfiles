#!/usr/bin/env bash
set -euo pipefail
DOTS="$(cd "$(dirname "$0")" && pwd)"

echo "▶ 패키지 설치"
sudo apt-get update -qq
sudo apt-get install -y -qq zsh git curl unzip ripgrep fzf \
     zsh-autosuggestions zsh-syntax-highlighting

echo "▶ starship"
command -v starship >/dev/null || \
  curl -sS https://starship.rs/install.sh | sh -s -- -y

echo "▶ zoxide"
command -v zoxide >/dev/null || \
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

echo "▶ 설정 링크"
mkdir -p ~/.config
ln -sf "$DOTS/zshrc.linux"   ~/.zshrc
ln -sf "$DOTS/starship.toml" ~/.config/starship.toml
ln -sf "$DOTS/ripgreprc"     ~/.ripgreprc
echo 'export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc' >> ~/.zshrc

echo "▶ 기본 셸 변경"
sudo chsh -s "$(command -v zsh)" "$USER"

echo "✅ 완료 — 다시 접속하면 적용됨"
