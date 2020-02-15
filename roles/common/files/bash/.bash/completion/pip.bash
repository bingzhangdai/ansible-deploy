if command -v pip >/dev/null; then
  eval "$(pip completion --bash)"
fi

if command -v pip3 >/dev/null; then
  eval "$(pip3 completion --bash)"
fi