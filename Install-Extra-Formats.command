#!/bin/bash
# khlz optional format setup. No remote shell scripts, sudo or security bypasses.
set -euo pipefail
export PATH=/usr/bin:/bin:/usr/sbin:/sbin
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

fail() { printf '\n%s\n' "$1" >&2; exit 1; }
[[ "$(uname -s)" == Darwin ]] || fail 'This installer requires macOS.'
[[ "$(uname -m)" == arm64 ]] || fail 'This khlz release requires Apple Silicon (M1 or later).'
[[ "$EUID" != 0 ]] || fail 'Run as your regular user. Do not run this script with sudo.'
BREW_BIN=/opt/homebrew/bin/brew
CHECK_ONLY=false
case "${1:-}" in
    --check) CHECK_ONLY=true ;;
    '') ;;
    *) fail 'Usage: Install-Extra-Formats.command [--check]' ;;
esac
printf '\nДополнительные форматы khlz\n\n'
printf 'Устанавливаются через Homebrew:\n'
printf '  FFmpeg / ffprobe — аудио и видео\n  WebP — cwebp\n  libheif и плагины — AVIF\n  LibreOffice — документы, таблицы, презентации и PDF/A\n\n'
printf 'Требуются интернет и несколько гигабайт свободного места.\n'
printf 'Компоненты будут доступны и другим приложениям на этом Mac.\n'
printf 'Сам khlz не переустанавливается. Пароли и файлы не отправляются разработчику khlz.\n\n'
if [[ ! -x "$BREW_BIN" ]]; then
    printf 'Сначала установите Homebrew с официального сайта: https://brew.sh\n'
    printf 'Затем снова откройте этот установщик. Homebrew может запросить права администратора.\n'
    if ! $CHECK_ONLY; then /usr/bin/open https://brew.sh; fi
    exit 2
fi
if $CHECK_ONLY; then
    "$BREW_BIN" --version
    for binary in ffmpeg ffprobe cwebp heif-enc; do
        if [[ -x "/opt/homebrew/bin/$binary" ]]; then printf 'OK: %s\n' "$binary"; else printf 'MISSING: %s\n' "$binary"; fi
    done
    [[ -x /Applications/LibreOffice.app/Contents/MacOS/soffice ]] && printf 'OK: LibreOffice\n' || printf 'MISSING: LibreOffice\n'
    exit 0
fi
printf 'Установить недостающие компоненты? Введите INSTALL: '
read -r answer
[[ "$answer" == INSTALL ]] || { printf 'Установка отменена.\n'; exit 0; }
# Fully qualified official formulae: no third-party taps or opaque downloaded scripts.
"$BREW_BIN" install homebrew/core/ffmpeg homebrew/core/webp homebrew/core/libheif homebrew/core/libheif-plugins
if [[ ! -x /Applications/LibreOffice.app/Contents/MacOS/soffice ]]; then
    "$BREW_BIN" install --cask homebrew/cask/libreoffice
fi
for binary in ffmpeg ffprobe cwebp heif-enc; do
    [[ -x "/opt/homebrew/bin/$binary" ]] || fail "Не найден $binary. Проверьте сообщения Homebrew выше."
done
[[ -x /Applications/LibreOffice.app/Contents/MacOS/soffice ]] || fail 'LibreOffice не установлен.'
printf '\nГотово. Завершите khlz через значок в строке меню и откройте снова.\n'
printf 'Они добавляют поддерживаемые форматы, но не функции, которых ещё нет в khlz.\n'
printf 'Для будущих обновлений этих компонентов используйте Homebrew.\n'
printf '\nНажмите Enter, чтобы закрыть это окно. '
read -r answer
