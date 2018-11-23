#!/bin/bash

#method account/viewPass

i=0
while true; do
        ((i++))
        echo $i #leave this echo to have some output which can be counted
        TOKENPASS=YourPassword
        RESPONSE_ID=100 #some ID defined by yourself
        AUTHTOKEN=YourToken
        TARGET_URL=https://pw.thedomain.de/api.php
        PASSWORD_ID=$i

        CURL_STRING="curl -H 'Accept: */*' -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' -X POST -d '{ \"jsonrpc\": "2.0", \"method\": \"account/viewPass\", \"params\": { \"authToken\": \"$AUTHTOKEN\", \"tokenPass\": \"$TOKENPASS\",\"id\":$PASSWORD_ID }, \"id\": $RESPONSE_ID }' $TARGET_URL --silent"

        #CURL_STRING="curl -H 'Accept: */*' -H 'Cache-Control: no-cache' -H 'Content-Type: application/json' -X POST -d '{ \"jsonrpc\": "2.0", \"method\": \"account/viewPass\", \"params\": { \"authToken\": \"$AUTHTOKEN\", \"tokenPass\": \"$TOKENPASS\",\"id\":$PASSWORD_ID }, \"id\": $RESPONSE_ID }' $TARGET_URL --silent | jq ." #with JQ

        #execute it
        eval $CURL_STRING

        if [ "$i" == "1" ]; then i=0; fi #you can set "1" to another value to have higher cycle through. Setting to 1 means always decrypt the same password
done
