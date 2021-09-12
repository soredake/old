#!/bin/bash
_os="linux64"
_lang="en-US"
AUTODOWNLOAD="release"

die() {
  echo "$1"
  exit 1
}

download() {
  case $AUTODOWNLOAD in
    esr) URL=-esr ;;
    beta) URL=-beta ;;
    devedition) URL=-devedition ;;
    nightly) URL=-nightly ;;
    *) URL=
  esac
  [[ -d "$HOME/.cache" ]] && ccache="$HOME/.cache"
  cdir="${ccache:-$WORKDIR}/fxlowmem"
  _base="$AUTODOWNLOAD-latest.tar.bz2"
  [[ ! -d "$cdir" ]] && mkdir -p "${cdir}"
  # cleanup
  if [[ -n "$CLEAN" ]]; then
    rm -f "${cdir}/$_base"
    rm -f "${cdir}/${AUTODOWNLOAD}*"
  fi
  # download
  echo "Downloading firefox version: $AUTODOWNLOAD"
  [[ ! -e "${cdir}/$_base" ]] && curl -Lo "${cdir}/$_base" "https://download.mozilla.org/?product=firefox${URL}-latest-ssl&os=${_os}&lang=${_lang}"
  [[ -n "$CLEAN" ]] && rm "${cdir}/$AUTODOWNLOAD.version"
  if [[ ! -f "${cdir}/$AUTODOWNLOAD.version" ]]; then
    tar xvf "${cdir}/$_base" firefox/application.ini -O | grep -Po '(?<=^Version=).*' >"${cdir}/$AUTODOWNLOAD.version"
  fi
  version="$(cat "${cdir}/$AUTODOWNLOAD".version)"
  LOCATION="${cdir}/${AUTODOWNLOAD}-${version}"
  [[ -n "$CLEAN" ]] && rm -r "${LOCATION}"
  if ! test -d "${LOCATION}"; then
    mkdir "${LOCATION}"
    # unpack
    tar xvjf "${cdir}/$_base" --strip-components=1 -C "${LOCATION}"
  fi
  current_version="$(grep -Po '(?<=^Version=).*' "${LOCATION}/application.ini")"
  if [[ ${current_version} != "${version}" ]]; then
    echo "Firefox is updated, moving ${AUTODOWNLOAD}-${version} to ${AUTODOWNLOAD}-${current_version}"
    echo "${current_version}" > "${cdir}/$AUTODOWNLOAD".version
    mv -f "${LOCATION}" "${cdir}/${AUTODOWNLOAD}-${current_version}"
    LOCATION="${cdir}/${AUTODOWNLOAD}-${current_version}"
    version="$(cat "${cdir}/$AUTODOWNLOAD".version)"
  fi
}

start() {
  if [[ -n "${AUTODOWNLOAD}" && -z "${LOCATION}" ]]; then
    download "${AUTODOWNLOAD}"
  fi
  fxbranch="${AUTODOWNLOAD}"-
  fxver="${version}"-
  date=$(date +%d.%m.%G-%T)
  profile=${PROFILE:-$(mktemp -d "${cdir}/firefox-${fxbranch}${fxver}${date}"-XXX)}
  location=${LOCATION:-/usr/lib/firefox}
  logfile=${LOGFILE:-$(mktemp -t -p "${cdir}" "firefox-${fxbranch}${fxver}${date}"-XXX.log)}
  cat > "${profile}/user.js" <<END
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.startup.page", 3);
END
  if [[ -n "${INFO}" ]]; then
    echo "Using date: ${date}"
    echo "Using profile dir: ${profile}"
    echo "Using firefox location: ${location}"
    echo "Using log file: ${logfile}"
  fi
  echo "Launching firefox version: ${AUTODOWNLOAD}-${version}"
  nohup "${location}"/firefox --new-instance --profile "${profile}" &>"${logfile}" &
}

while getopts "p:l:g:a:d:c:i:h:c" opt; do
  case $opt in
    p) PROFILE="${OPTARG}" ;;
    l) LOCATION="${OPTARG}" ;;
    g) LOGFILE="${OPTARG}" ;;
    a) AUTODOWNLOAD=${OPTARG} ;;
    d) WORKDIR=${OPTARG} ;;
    c) CLEAN=true ;;
    i) INFO=true ;;
    h) ACTION="help" ;;
    *) echo "no such action"
  esac
done

shift $((OPTIND -1))

if [[ -z "${ACTION}" ]]; then
    ACTION="${1:-start}"
fi

case "${ACTION}" in
    start) start ;;
    help) echo "usage: ${0} [-p, -l, -lg, -a, -i, -h]
    -p use custom profile path
    -l use custom firefox location (such as firefox from your package manager or other)
    -g use custom log location
    -a autodownload one of this versions: esr, release, beta, devedition, nightly
    -d where to store logs and versions
    -i output some info
    -c remove cached downloaded version
    -h help" ;;
    *) die "invalid action '${ACTION}'" ;;
esac
