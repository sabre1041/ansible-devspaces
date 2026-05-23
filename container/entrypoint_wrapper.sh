#!/bin/bash

set -euo pipefail

if [ ! -d "${HOME}" ]; then
    mkdir -p "${HOME}"
fi

# Configure Z shell
if [ ! -f ${HOME}/.zshrc ]
then
  (echo "HISTFILE=${HOME}/.zsh_history"; echo "HISTSIZE=1000"; echo "SAVEHIST=1000") > ${HOME}/.zshrc
  (echo "if [ -f ${PROJECT_SOURCE}/workspace.rc ]"; echo "then"; echo "  . ${PROJECT_SOURCE}/workspace.rc"; echo "fi") >> ${HOME}/.zshrc
  if [ -f ${HOME}/.keystore ]
  then
    echo "export MAVEN_OPTS=\"-Djavax.net.ssl.trustStore=${HOME}/.keystore -Djavax.net.ssl.trustStorePassword=changeit\"" >> ${HOME}/.zshrc
  fi
fi

# Configure Bash shell
if [ ! -f ${HOME}/.bashrc ]
then
  (echo "if [ -f ${PROJECT_SOURCE}/workspace.rc ]"; echo "then"; echo "  . ${PROJECT_SOURCE}/workspace.rc"; echo "fi") > ${HOME}/.bashrc
  if [ -f ${HOME}/.keystore ]
  then
    echo "export MAVEN_OPTS=\"-Djavax.net.ssl.trustStore=${HOME}/.keystore -Djavax.net.ssl.trustStorePassword=changeit\"" >> ${HOME}/.zshrc
  fi
fi

exec /entrypoint.sh "$@"