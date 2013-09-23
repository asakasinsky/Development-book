
Запуск VM в «режиме сервиса» Headless (для Mac OS X)
Совсем не обязательно запускать VM вручную. Можно настроить её автозапуск в качестве сервиса (службы, демона). В нашем случае это очень удобно, так как на VM располагается сервер разработки. 

Для начала сделаем так, чтобы сервер не ждал нажатия клавиши при загрузке. 

на виртуальной машине:
sudo nano /etc/default/grub

Добавим строку:
GRUB_RECORDFAIL_TIMEOUT=2

Обновим Grub:
sudo update-grub

Теперь на хостовой машине создаём файл /Library/LaunchDaemons/UbuntuLAMPServer.plist
Обычно имя файлов подобных этому создаётся согласно reverse domain-name style, но тут я просто создал его в стиле «верблюжей» нотации.
Содержимое файла:

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

перезагружаем хостовую машину или выполняем команду 
sudo launchctl load -w /Library/LaunchDaemons/UbuntuLAMPServer.plist
можно выгрузить
sudo launchctl unload /Library/LaunchDaemons/UbuntuLAMPServer.plist
и всё. В процессах можно наблюдать VBoxHeadless

ПРОВЕРИТЬ!!!
И запускаем в фоне в консольном режиме:
VBoxManage startvm memtest --type headless




Выключить виртуальную машину можно командой:
VBoxManage controlvm memtest poweroff




За состоянием теста следим с помощью отладчика VirtualBox:
VBoxManage debugvm memtest info vgatext
