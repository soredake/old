# shellcheck disable=2034,2148
# Create a new directory and enter it.
mkd() {
  mkdir -p "$@" && cd "$_";
}
