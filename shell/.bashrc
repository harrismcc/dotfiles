# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/bashrc.pre.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.pre.bash"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/bashrc.post.bash" ]] && builtin source "$HOME/.fig/shell/bashrc.post.bash"


# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/harris/.lmstudio/bin"
# End of LM Studio CLI section


# Added by git-ai installer on Thu Jan 29 14:05:26 PST 2026
export PATH="/Users/harris/.git-ai/bin:$PATH"
# fnm (Fast Node Manager)
export FNM_DIR="$HOME/.local/share/fnm"
export PATH="$FNM_DIR:$PATH"
eval "$(fnm env)"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init bash)"; fi
