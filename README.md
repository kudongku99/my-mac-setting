# my-mac-setting

맥 개발 환경 설정 파일을 이 저장소에 백업합니다. `brew install`, mise 버전 변경, 셸 설정 수정처럼 환경을 바꾼 뒤 `./backup.sh`를 실행하세요.

| 원본 | 백업 위치 | 내용 |
| --- | --- | --- |
| `~/Brewfile` | `home/Brewfile` | brew 패키지와 앱 |
| `~/.config/mise/config.toml` | `home/.config/mise/config.toml` | Node, Java, Go 등 버전 |
| `~/.zshrc`, `~/.zprofile` | `home/.zshrc`, `home/.zprofile` | 셸 설정 |
| `~/.p10k.zsh` | `home/.p10k.zsh` | 프롬프트 모양 |

`home/` 아래는 홈 디렉터리 기준 경로를 그대로 따릅니다.

## 백업

```bash
./backup.sh
```

1. `brew bundle dump --force`로 `~/Brewfile`을 현재 설치 상태로 갱신합니다.
2. 위 파일들을 `home/`으로 복사합니다.
3. 바뀐 내용이 있으면 `home/`만 커밋하고, `origin` 리모트가 있으면 push합니다.

백업 대상을 늘리려면 `backup.sh`의 `FILES` 배열에 홈 기준 경로를 추가하면 됩니다.

## 주의

공개 저장소이고 `backup.sh`는 확인 없이 push합니다. 토큰이나 API 키는 백업 대상이 아닌 별도 파일(예: `~/.secrets.zsh`)에 두고 `.zshrc`에서 불러오세요.

## 새 맥에서 복원

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
git clone https://github.com/kudongku99/my-mac-setting.git && cd my-mac-setting
cp -Rp home/. "$HOME"/
brew bundle --file="$HOME/Brewfile"
mise install
```

`.zshrc`는 oh-my-zsh와 powerlevel10k 테마를 사용하는데, 이 둘은 Brewfile에 없으므로 따로 설치해야 합니다.

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
```
