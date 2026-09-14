if status is-interactive
    # Commands to run in interactive sessions can go here
end
# --- NixOS + Git aliases ---
alias gs="git status"
alias ga="git add -A"
alias gp="git push"
alias nr="cd /etc/nixos && sudo nixos-rebuild switch --flake .#thinkpad-x260"
alias save="cd /etc/nixos && git add -A && git commit -m 'update' && git push"
function savem
    cd /etc/nixos
    git add -A
    git commit -m $argv[1]
    git push
end
