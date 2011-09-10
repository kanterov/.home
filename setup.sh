#!/usr/bin/env bash

DF_DIR=${PWD}/dotfiles
DOTFILES=$(ls ${DF_DIR}) 

for df in ${DOTFILES}; {
  bf=$(basename ${df});
  ln -Fs ${DF_DIR}/${bf} ${HOME}/.${bf};
}

