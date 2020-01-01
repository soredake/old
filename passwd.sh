#!/usr/bin/env bash

set -e
# shellcheck disable=SC2002
pass1() { time cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:<>?=' \
| fold -w 60 | head -n 1 | grep -i '[!@#$%^&*()_+{}|:<>?=]'; }
pass2() { strings /dev/urandom|head -15|shuf|paste -s|tr -d '[:space:]'|cut -b-59; }
# from https://github.com/herrbischoff/awesome-osx-command-line
pass3() { LC_ALL=C tr -dc "[:alpha:][:alnum:]" < /dev/urandom | head -c 20; }
pass1
#exit 0
