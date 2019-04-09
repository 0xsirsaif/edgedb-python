#!/bin/bash

set -e -x

if [ "${TRAVIS_OS_NAME}" == "osx" ]; then
    brew update >/dev/null
    brew upgrade pyenv
    eval "$(pyenv init -)"

    if ! (pyenv versions | grep "${PYTHON_VERSION}$"); then
        pyenv install ${PYTHON_VERSION}
    fi
    pyenv global ${PYTHON_VERSION}
    pyenv rehash

    # Install PostgreSQL
    if brew ls --versions postgresql > /dev/null; then
        brew remove --force --ignore-dependencies postgresql
    fi

    brew install postgresql@${PGVERSION}
    brew services start postgresql@${PGVERSION}
fi
