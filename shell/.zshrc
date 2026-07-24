ZSH_THEME="drexalt"
export PATH="$(brew --prefix)/opt/python@3.10/libexec/bin:$PATH"
export PATH="/Users/jonahturner/.local/bin:$PATH"
export CPATH=/opt/homebrew/include
export LIBRARY_PATH=/opt/homebrew/lib
# opam configuration
[[ ! -r /Users/jonahturner/.opam/opam-init/init.zsh ]] || source /Users/jonahturner/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
alias bb="ssh drexalt@blackbox"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/cups/bin:$PATH"
alias sv="source .venv/bin/activate"
alias tn='tmux new -As'
alias ts="~/.config/scripts/tmux-session-dispensary.sh"
alias ls="ls -G"
alias oc="opencode --port"
tas() {
  local s
  s=$(tmux ls -F '#S' 2>/dev/null | sk --prompt 'tmux sessions > ') || return
  tmux attach -t "$s"
}

# opencode
export PATH=/Users/jonahturner/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"
