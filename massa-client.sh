#!/usr/bin/env bash

PASS_FILE="massa-pass.txt"

echo "Starting massa-client..."

if [[ -z "$MASSA_PASS" ]]; then
      echo "MASSA_PASS not set. Using $PASS_FILE"

      if [[ ! -f $PASS_FILE ]]; then
            echo "$PASS_FILE not found. Exiting..."
            exit 1
      fi

      MASSA_PASS=$(cat $PASS_FILE)
fi

cd ~/massa-client
./massa-client -p $MASSA_PASS

echo "massa-client exited"
exit 0

