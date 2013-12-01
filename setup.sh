#!/usr/bin/env bash

DF_DIR=${PWD}/dotfiles
SF_DIR=${PWD}/bin
DOTFILES=$(ls ${DF_DIR})
SCRIPTS=$(ls ${SF_DIR})

# Takes three arguments:
# 1. src path
# 2. dst path
function linkDotfile() {
  local src=$1;
  local dst=$2;

  if [ ! -e ${dst} ]; then
    ln -s ${src} ${dst}
  elif [ "$(readlink ${dst})" == ${src} ]; then
    echo "info: already linked ${src}";
  else
    echo "warning: ${dst} already exists";
  fi;
}

for df in ${DOTFILES}; {
  bf=$(basename ${df});
  linkDotfile "${DF_DIR}/${bf}" "${HOME}/.${bf}"
}

mkdir -p ${HOME}/bin;
for sf in ${SCRIPTS}; {
  sf=$(basename ${sf});
  linkDotfile "${SF_DIR}/${sf}" "${HOME}/bin/${sf}"
}
