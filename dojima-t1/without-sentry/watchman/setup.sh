#!/usr/bin/env sh

NODE_DIR=$HOME/node
HEIMDALL_HOME=$HOME/.heimdalld

# init heimdall node
heimdalld init

# copy node directories to home directories
cp -rf $NODE_DIR/watchman/config/genesis.json $HEIMDALL_HOME/config/
#cp -rf $NODE_DIR/watchman/config/config.toml $HEIMDALL_HOME/config/
#cp -rf $NODE_DIR/watchman/config/heimdall-config.toml $HEIMDALL_HOME/config/