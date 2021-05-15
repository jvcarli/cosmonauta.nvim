#!/usr/bin/env sh

# Update typescript-language-server - João Vítor Carli Pereira
# LICENSE MIT

# https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#tsserver
# https://github.com/theia-ide/typescript-language-server

ASDF_NODE_VERSIONS=$(asdf shim-versions node | sed 's/[^ ]* //')
ASDF_NODE_PATH="$HOME/.asdf/installs/nodejs"
TMP_DIR="/tmp/nvim-langservers/typescript-language-server/"
UPDATE_CMD="install -g typescript typescript-language-server"

for VERSION in $ASDF_NODE_VERSIONS;
do
    NPM_PATH="${ASDF_NODE_PATH}/${VERSION}/bin/npm"
    TYPESCRIPT_LANG_SERVER_UPDATE="${NPM_PATH} ${UPDATE_CMD}"
    ASDF_SHIM="asdf local nodejs ${VERSION}"

    mkdir -p $TMP_DIR
    cd $TMP_DIR

    eval $ASDF_SHIM

    # command evaluation using the full path is redundant
    # because of the activation of environment
    # using `asdf local ndoejs ${VERSION}`
    # HACK:For some reason executing the commands using the full npm path is not enough. 
    # The commands are only executed properly
    # when `asdf local ...` is executed before
    # the command bellow
    eval $TYPESCRIPT_LANG_SERVER_UPDATE

    cd -
    rm -r $TMP_DIR
done

