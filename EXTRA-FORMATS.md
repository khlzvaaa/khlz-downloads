# Дополнительные форматы khlz

1. Распакуйте архив и откройте **Install-Extra-Formats.command**. Откроется Terminal с перечнем компонентов.
2. Если Homebrew отсутствует, установщик откроет его официальный сайт. Установите Homebrew и снова откройте файл.
3. Введите `INSTALL`, чтобы установить FFmpeg/ffprobe, cwebp, heif-enc с плагинами и LibreOffice. Это необязательные общесистемные компоненты: нужны интернет и несколько гигабайт места. Homebrew может запросить системные инструменты разработчика; установка LibreOffice может потребовать права администратора.
4. Перезапустите khlz, чтобы появились дополнительные форматы.

Само приложение khlz не заменяется. Скрипт не отключает защиту macOS, не запускает удалённые shell-скрипты и не требует передачи паролей разработчику. Если macOS блокирует открытие скачанного установщика, используйте ручные команды ниже из официальной документации Homebrew.

При уже установленном Homebrew можно установить компоненты вручную:

```sh
brew install ffmpeg webp libheif libheif-plugins
brew install --cask libreoffice
```

Скрипт устанавливает отсутствующие компоненты и не обновляет все программы на вашем Mac. Для обновлений используйте Homebrew. Проверить наличие компонентов без установки: `bash Install-Extra-Formats.command --check`.

Это установщик зависимостей, а не офлайн-пакет с кодеками. Исходный код скрипта доступен в репозитории. Поддержка конкретного формата зависит от версии кодека и параметров файла; установка не добавляет в khlz ещё не реализованные инструменты.

Официальные источники: [Homebrew](https://brew.sh), [FFmpeg](https://formulae.brew.sh/formula/ffmpeg), [WebP](https://formulae.brew.sh/formula/webp), [libheif](https://formulae.brew.sh/formula/libheif), [плагины libheif](https://formulae.brew.sh/formula/libheif-plugins), [LibreOffice](https://formulae.brew.sh/cask/libreoffice).
