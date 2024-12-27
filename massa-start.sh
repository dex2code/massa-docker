
#!/usr/bin/env bash

PASS_FILE="massa-pass.txt"
PASS_LENGTH=16

echo "Starting massa-node..."

if [[ -z "$MASSA_PASS" ]];
   then
      echo "MASSA_PASS not set. Using $PASS_FILE"

      if [[ ! -f $PASS_FILE ]]; then
         echo "$PASS_FILE not found. Generating..."
         head /dev/urandom | md5sum | head -c $PASS_LENGTH > $PASS_FILE;
      fi

      MASSA_PASS=$(cat $PASS_FILE)
   
   else
      echo "MASSA_PASS set"
      echo -n "$MASSA_PASS" > $PASS_FILE

   chmod 600 $PASS_FILE
fi

echo "MASSA_PASS: $MASSA_PASS"

./massa-node -p $MASSA_PASS

echo "massa-node exited"
exit 0
