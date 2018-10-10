#!/bin/bash

TOKENPASS="mrbtz23n"
RESPONSE_ID="100" #some ID defined by yourself
AUTHTOKEN="ec26ce5f6265020a6853d102957051894f6c8c85e853203d8bc16abfbb7e9a5a"
ACCOUNT_ID="32" #get the password for the account with ID - you can retrieve this info the method account/search

VERBOSITY=4
POST_DATA="{ \"jsonrpc\": \"2.0\", \"method\": \"account/viewPass\", \"params\": { \"authToken\": \"$AUTHTOKEN\", \"tokenPass\": \"$TOKENPASS\",\"id\":$ACCOUNT_ID }, \"id\": $RESPONSE_ID }"
TARGET_URL="https://pw.fablabchemnitz.de/api.php"
CONCURRENCY=400
REQUESTS=400
TIMEOUT=5 #max allowed timeout - the time a user as to wait for the response. default of apache ab is 30 seconds
TIMELIMIT=60

POSTFILE=post.tmp
LOGFILE=output.log
PLOTFILE=plot.data

echo $POST_DATA > $POSTFILE

EXEC_STRING="ab -c $CONCURRENCY -n $REQUESTS -s $TIMEOUT -H 'Accept: */*' -H 'Cache-Control: no-cache' -p post.tmp -f TLS1.2 -T application/json -g $PLOTFILE -v $VERBOSITY $TARGET_URL"

#echo $EXEC_STRING
eval $EXEC_STRING > $LOGFILE 2>&1
rm $POSTFILE
ENCRYPTED_COUNT=$(grep -c "{\"jsonrpc\":\"2.0\",\"result\":{\"" $LOGFILE)
echo $ENCRYPTED_COUNT passwords
echo $REQUESTS requests
echo $CONCURRENCY concurrency
echo $TIMEOUT timeout
echo $TIMELIMIT timelimit
echo $(awk "BEGIN {print($ENCRYPTED_COUNT/$REQUESTS*100)}")% of requested passwords decryptions could be retrieved in given timeout range. To get better values raise timeout limit, reduce concurrency or pimp your server settings.
