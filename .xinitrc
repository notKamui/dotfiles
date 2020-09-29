[[ -f ~/.config/zsh/.zshenv ]] && source ~/.config/zsh/.zshenv

picom &
xrdb -merge ~/.cache/wal/colors.Xresources
xrdb -load ~/.Xresources
setxkbmap fr
nm-applet &
jetbrains-toolbox &
exec awesome

