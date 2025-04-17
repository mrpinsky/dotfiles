export EDITOR=vim
export BAT_THEME=ansi

export HOMEBREW_CASK_OPTS="--appdir=~/Application"

autoload zmv

### FZF
# If current selection is a text file shows its content,
# if it's a directory shows its content, the rest is ignored
FZF_CTRL_T_OPTS="--preview-window wrap --preview '
if [[ -f {} ]]; then
    file --mime {} | grep -q \"text\/.*;\" && cat {} || (tput setaf 1; file --mime {})
elif [[ -d {} ]]; then
    ls -l {}
else;
    tput setaf 1; echo YOU ARE NOT SUPPOSED TO SEE THIS!
fi'"
