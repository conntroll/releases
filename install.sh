#!/usr/bin/env sh

set -e

osarch(){
  case $(uname -s) in
    Darwin) os="darwin" ;;
    *) os="linux" ;;
  esac

  case $(uname -m) in
    x86_64) arch="amd64" ;;
    i686) arch="386" ;;
    i386) arch="386" ;;
    armv8l) arch="arm64" ;;
    armv8b) arch="arm64" ;;
    aarch64) arch="arm64" ;;
    aarch64_be) arch="arm64" ;;
    *) arch="other" ;;
  esac

  if [ "$arch" = "other" ]; then
    >&2 cat <<EOF
    "[ERROR] Architecture $(uname -m) unrecognized by this script. 
    Please go to https://get.k0s.io/latest/ to download it manually, 
    and submit an issue at https://github.com/btwiuse/k0s/issues" 1>&2
EOF
    exit 1
  fi

  echo "${os}/${arch}"
}

dl(){
  DL_CMD="echo please install one of {curl,wget}"
  if type curl 2>/dev/null 1>&2; then
    DL_CMD="curl -L --progress-bar"
  elif type wget 2>/dev/null 1>&2; then
    DL_CMD="wget --progress=bar -O-"
  elif type busybox 2>/dev/null 1>&2; then
    DL_CMD="busybox wget -O-"
  fi
  eval "${DL_CMD} ${1}"
}

install(){
  bindir="${HOME}/.k0s/bin"
  bin="${bindir}/k0s"
  # bindir="${HOME}/.local/bin/k0s"
  mkdir -p "${bindir}"
  compressed="$(echo "$(osarch)"/k0s.tar.gz | tr / -)"
  dl "https://github.com/btwiuse/k0s/releases/download/latest/${compressed}" | tar -C "${bindir}" -xz k0s
  cat <<EOF
        Successfully installed k0s to ${bin}
        Please add the directory to your PATH
         
        export PATH=\${PATH}:${bindir}

        Try run \`k0s -version\` to check the version
EOF
}

main(){
  install # && /bin/k0s client -version
}

main "${@}"
