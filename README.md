# cli-bookmarks

Create, delete and jump directory bookmarks 

## requirements
```
fzf
apt install fzf 
```


## Installation

Add to .zshrc
```
source fzf-bookmark.zsh
alias cd='cd -P'
```

## Usage 
```
$ mark @bookmarkName - add bookmark for current directory
$ dmark @bookmarkName - remove bookmark 
$ cd @bookmarkName
or 
ctrl-g to GUI
```