# Headless Mode (OSX)

It is not necessary to run VM manually. You can configure the startup as a service (daemon). In my case, it is very convenient as server development is located on the VM. 

Create a /Library/LaunchDaemons/UbuntuLEMPServer.plist file.

>Usually the name of the file like this one created under _reverse domain-name_ style, but then I just created it in the _CamelCase_ style.

```bash  
sudo subl /Library/LaunchDaemons/UbuntuLEMPServer.plist  
```

```bash  
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">  
<plist version="1.0">  
<dict>  
<key>Label</key>
  <string>UbuntuLEMPServer.plist</string>
  <key>ProgramArguments</key>
  <array>
    <string>/usr/bin/VBoxHeadless</string>
    <string>-startvm</string>
    <string>UbuntuLEMPServer</string>
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
```

```bash  
alias lemp-start="sudo launchctl load -w /Library/LaunchDaemons/UbuntuLEMPServer.plist"  
alias lemp-stop="sudo launchctl unload /Library/LaunchDaemons/UbuntuLEMPServer.plist"  
```
