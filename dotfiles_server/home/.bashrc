alias docker-gc-docker='docker run --rm -it --user $(id -u):$(id -g) -e FORCE_IMAGE_REMOVAL=1 -e FORCE_CONTAINER_REMOVAL=1 -e GRACE_PERIOD_SECONDS=300 -v /var/run/docker.sock:/var/run/docker.sock fdsfgs/docker-gc docker-gc'
alias docker-gc='PID_DIR="$XDG_RUNTIME_DIR" STATE_DIR="$HOME/.cache/docker-gc" FORCE_IMAGE_REMOVAL=1 FORCE_CONTAINER_REMOVAL=1 GRACE_PERIOD_SECONDS=300 ~/git/docker-gc/docker-gc'

transfer() { if [ $# -eq 0 ]; then echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"; return 1; fi
tmpfile=$( mktemp -t transferXXX ); if tty -s; then basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g'); curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile; else curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ; fi; cat $tmpfile; rm -f $tmpfile; }
