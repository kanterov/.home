#!/usr/bin/env bash

declare -r df_dir="${PWD}/dotfiles"
declare -r sf_dir="${PWD}/bin"
declare -ra dotfiles=($(ls "${df_dir}"))
declare -ra scripts=($(ls "${sf_dir}"))

# Takes three arguments:
# 1. src path
# 2. dst path
function linkDotfile() {
  local src="$1";
  local dst="$2";

  if [ ! -e "${dst}" ]; then
    ln -s "${src}" "${dst}"
  elif [ "$(readlink "${dst}")" = "${src}" ]; then
    echo "info: already linked ${src}";
  else
    echo "warning: ${dst} already exists";
  fi;
}

function linkDotfiles() {
  local bf

  for df in "${dotfiles[@]}"; {
    bf="$(basename ${df})";
    linkDotfile "${df_dir}/${bf}" "${HOME}/.${bf}"
  }
}

function linkBinScripts() {
  local sf

  mkdir -p "${HOME}/bin";
  for sf in "${scripts[@]}"; {
    sf="$(basename "${sf}")";
    linkDotfile "${sf_dir}/${sf}" "${HOME}/bin/${sf}"
  }
}

set -eu
linkDotfiles
linkBinScripts
