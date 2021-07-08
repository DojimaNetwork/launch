#!/usr/bin/env sh

NODE_DIR=${NODE_DIR:-$HOME/node}
BIN_DIR=$(go env GOPATH)/bin
USER=$(whoami)


VALIDATOR_ADDRESS='${VALIDATOR_ADDRESS}'

cat > metadata <<EOF
VALIDATOR_ADDRESS=0xc40Bd8A9B58B8590087b901B52e5F0af0Cd43fBD
EOF

cat > bor.service <<EOF
[Unit]
  Description=bor
  StartLimitIntervalSec=500
  StartLimitBurst=5

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  EnvironmentFile=/etc/dojima/metadata
  ExecStartPre=/bin/chmod +x $NODE_DIR/bulldog/start.sh
  ExecStart=/bin/bash $NODE_DIR/bulldog/start.sh $VALIDATOR_ADDRESS
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld.service <<EOF
[Unit]
  Description=heimdalld
  StartLimitIntervalSec=500
  StartLimitBurst=5

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/heimdalld start
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld-rest-server.service <<EOF
[Unit]
  Description=heimdalld-rest-server
  StartLimitIntervalSec=500
  StartLimitBurst=5

[Service]
  Restart=on-failure
  RestartSec=5s
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/heimdalld rest-server
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF

cat > heimdalld-bridge.service <<EOF
[Unit]
  Description=heimdalld-bridge

[Service]
  WorkingDirectory=$NODE_DIR
  ExecStart=$BIN_DIR/bridge start --all
  Type=simple
  User=$USER

[Install]
  WantedBy=multi-user.target
EOF
