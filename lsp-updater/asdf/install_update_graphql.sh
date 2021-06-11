#!/usr/bin/env sh

# https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#graphql
# https://github.com/graphql/graphiql/tree/main/packages/graphql-language-service-cli
# Update graphql-language-service-cli - João Vítor Carli Pereira
# LICENSE MIT

ASDF_NODE_VERSIONS=$(asdf shim-versions node | sed 's/[^ ]* //')
ASDF_NODE_PATH="$HOME/.asdf/installs/nodejs"
TMP_DIR="/tmp/nvim-langservers/graphql-language-service-cli/"
UPDATE_CMD="install -g graphql-language-service-cli"

for VERSION in $ASDF_NODE_VERSIONS;
do
    NPM_PATH="${ASDF_NODE_PATH}/${VERSION}/bin/npm"
    GRAPHQL_LANGUAGE_SERVICE_CLI_UPDATE="${NPM_PATH} ${UPDATE_CMD}"
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
    eval $GRAPHQL_LANGUAGE_SERVICE_CLI_UPDATE

    cd -
    rm -r $TMP_DIR
done

