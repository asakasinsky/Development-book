# OS X Preferences

## Some system «hack»

__Pay attention to а «Select Text in Quick Look» line. It can be very useful in your workflow.__  

All (or one of this) you must enter in the Terminal App.

```bash

# Enable the Debug Menu in Disk Utility  
defaults write com.apple.DiskUtility DUDebugMenuEnabled 1

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
```

For the changes to take effect, you need input:  
```bash  
killall Finder;  
```


## Turn off «rearrange spaces based on use»

System Preferences / Mission Control / "Automatically rearrange"->[ ]

## Speed up Mission Control animations

```bash  
defaults write com.apple.dock expose-animation-duration -float 0.15  
killall Dock  
```

## Window state restoring

Deselect: _System Settings — General — Close windows when qutting an application []_
