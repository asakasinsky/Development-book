# OS X Preferences
I don't use all of these, though they are very handy


```bash

#Use current directory as default search scope in Finder
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

#Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Select Text in Quick Look 
defaults write com.apple.finder QLEnableTextSelection -bool TRUE;

#Restart Finder when complete
killall Finder;
```

Turn off rearrange spaces based on use
----------------
System Preferences / Mission Control / "Automatically rearrange"->[ ]
