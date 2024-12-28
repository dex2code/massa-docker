#!/usr/bin/bash

NODE_PATH="$HOME/massa-node"

PASS_FILE="massa-pass.txt"
PASS_LENGTH=16

CONFIG_FILE="config.toml"
CONFIG_FILE_PATH="$NODE_PATH/config"

echo "Starting massa-node..."


if [[ -z "$MASSA_PASS" ]]; then
   echo "MASSA_PASS not set. Using $PASS_FILE"

   if [[ ! -f $NODE_PATH/$PASS_FILE ]] || [[ ! -s $NODE_PATH/$PASS_FILE ]]; then
      echo "$PASS_FILE not found. Generating..."
      head /dev/urandom | md5sum | head -c $PASS_LENGTH > $NODE_PATH/$PASS_FILE
   fi

   MASSA_PASS=$(cat $NODE_PATH/$PASS_FILE)
fi

echo -n "$MASSA_PASS" > $NODE_PATH/$PASS_FILE
echo "MASSA_PASS: $MASSA_PASS"


if [[ ! -f $CONFIG_FILE_PATH/$CONFIG_FILE ]] || [[ ! -s $CONFIG_FILE_PATH/$CONFIG_FILE ]]; then
   echo "$CONFIG_FILE not found. Creating..."
   echo -e "[network]\n    #routable_ip = \"\"\n\n[protocol]\n    #routable_ip = \"\"\n\n[bootstrap]\n    retry_delay = 15000\n" > $CONFIG_FILE_PATH/$CONFIG_FILE
fi

if [[ ! -z "$MASSA_ADDRESS" ]]; then
   echo "MASSA_ADDRESS set: $MASSA_ADDRESS"

   sed -i "/routable_ip/c\    routable_ip = \"$MASSA_ADDRESS\"" $CONFIG_FILE_PATH/$CONFIG_FILE
fi


./massa-node -p $MASSA_PASS

echo "massa-node exited"
exit 0
