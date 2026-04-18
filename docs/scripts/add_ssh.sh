if ! pgrep -u "$USER" ssh-agent > /dev/null; then
  eval "$(ssh-agent -s)" > /dev/null
fi
ssh-add ~/.ssh/id_ed25519  2>/dev/null  || \
ssh-add ~/.ssh/id_rsa 2>/dev/null
