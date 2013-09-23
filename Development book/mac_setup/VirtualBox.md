Запуск VM в «режиме сервиса» Headless (для Mac OS X)

Совсем не обязательно запускать VM вручную. Можно настроить её автозапуск в качестве сервиса (службы, демона). В нашем случае это очень удобно, так как на VM располагается сервер разработки. Вот по этой ссылке рассматривается другой случай.
Создаём файл /Library/LaunchDaemons/UbuntuLAMPServer.plist
Обычно имя файлов подобных этому создаётся согласно reverse domain-name style, но тут я просто создал его в стиле «верблюжей» нотации.
Содержимое файла:


sudo nano /Library/LaunchDaemons/UbuntuLAMPServer.plist

======= UbuntuLAMPServer.plist ===============
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>Label</key>
  <string>UbuntuLAMPServer.plist</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/VBoxHeadless</string>
    <string>-startvm</string>
    <string>UbuntuLAMPServer</string>
  </array>
<key>KeepAlive</key>
<true/>
  <key>UserName</key>
  <string>asakasinsky</string>
  <key>WorkingDirectory</key>
  <string>/usr/bin/VBoxHeadles</string>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
======= End of UbuntuLAMPServer.plist ============

# local dev server
alias lamp-ssh="ssh developer@192.168.56.10"
alias lamp-start="sudo launchctl load -w /Library/LaunchDaemons/UbuntuLAMPServer.plist"
alias lamp-stop="sudo launchctl unload /Library/LaunchDaemons/UbuntuLAMPServer.plist"
