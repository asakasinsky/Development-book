# OS X Preferences

## Some system «hack»

__Pay attention to а «Select Text in Quick Look» line. It can be very useful in your workflow.__  

All (or one of this) you must enter in the Terminal App.

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
```

For the changes to take effect, you need input: 
```bash
killall Finder;
```


## Turn off «rearrange spaces based on use»

System Preferences / Mission Control / "Automatically rearrange"->[ ]
