#!/usr/bin/bash


NODE_PATH="$HOME/massa-node"

PASS_FILE="massa-pass.txt"
PASS_LENGTH=16

CONFIG_FILE="config.toml"
CONFIG_FILE_PATH="$NODE_PATH/config"


echo "Starting MASSA Node..."

if [[ -z "$MASSA_PASS" ]]; then
   echo "MASSA_PASS not set. Using $PASS_FILE"

   if [[ ! -f $NODE_PATH/$PASS_FILE ]] || [[ ! -s $NODE_PATH/$PASS_FILE ]];
      then
         echo "$PASS_FILE not found or empty. Generating..."
         head /dev/urandom | md5sum | head -c $PASS_LENGTH > $NODE_PATH/$PASS_FILE
   fi

   MASSA_PASS=$(cat $NODE_PATH/$PASS_FILE)

else
   echo -n "$MASSA_PASS" > $NODE_PATH/$PASS_FILE

fi

echo -e "MASSA_PASS: \"$MASSA_PASS\""


if [[ ! -f $CONFIG_FILE_PATH/$CONFIG_FILE ]] || [[ ! -s $CONFIG_FILE_PATH/$CONFIG_FILE ]]; then
   echo "$CONFIG_FILE not found. Creating..."
   echo -e "[protocol]\n    #routable_ip = \"\"\n\n[bootstrap]\n    retry_delay = 5000\n    read_timeout = 300000\n    read_timeout = 300000" > $CONFIG_FILE_PATH/$CONFIG_FILE
fi


if [[ ! -z "$MASSA_ADDRESS" ]]; then
   sed -i "/routable_ip/c\    routable_ip = \"$MASSA_ADDRESS\"" $CONFIG_FILE_PATH/$CONFIG_FILE
fi

echo "MASSA_ADDRESS: $(grep "routable_ip" $CONFIG_FILE_PATH/$CONFIG_FILE | awk '{print $3}')"


./massa-node -p $MASSA_PASS


echo "MASSA Node exited"
exit 0
