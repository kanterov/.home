#!/usr/bin/env bash

DF_DIR=${PWD}/dotfiles
SF_DIR=${PWD}/bin
DOTFILES=$(ls ${DF_DIR})
SCRIPTS=$(ls ${SF_DIR})

for df in ${DOTFILES}; {
  bf=$(basename ${df});
  ln -Fs ${DF_DIR}/${bf} ${HOME}/.${bf};
}

mkdir -p ${HOME}/bin;
for sf in ${SCRIPTS}; {
  sf=$(basename ${sf});
  ln -Fs ${SF_DIR}/${sf} ${HOME}/bin/${sf};
}
