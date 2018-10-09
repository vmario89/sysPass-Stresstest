#!/bin/bash

for i in "$@"
do
case $i in
    --sessions=*)
    PARALLEL_SESSIONS="${i#*=}"
    shift # past argument=value
    ;;
    --duration=*)
    DURATION_SECONDS="${i#*=}"
    shift # past argument=value
    ;;
    *)
    ;;
esac
done

if [[ -z "$DURATION_SECONDS" ]] || [[ "DURATION_SECONDS" < "1" ]]; then
        echo "--duration parameter incorrect or missing (min 1)"
        exit
fi

if [[ -z "$PARALLEL_SESSIONS" ]] || [[ "$PARALLEL_SESSIONS" < "2" ]]; then
        echo "--sessions parameter incorrect or missing (min 2)"
        exit
fi

progress-bar() {
  local duration=${1}


    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}

echo Killing old process if running ...
killall syspass-stresstest.sh

echo Removing old files ...
rm syspass-stresstest-run-*.log

echo Starting stress test for $DURATION_SECONDS seconds ...
date +"%d.%m.%Y - %H:%M:%S"
echo Please visit the frontend website and test if it still reacts smooth
RUN_CMD="for RUN in {1..$PARALLEL_SESSIONS}; do \`nohup ./syspass-stresstest.sh > syspass-stresstest-run-\"\$RUN\".log 2>&1&\`;done" #pipe nohup output itself to /dev/null
eval $RUN_CMD

progress-bar $DURATION_SECONDS #wait the given duration with progress bar display

#stop it
echo Stopping stress test ...
killall syspass-stresstest.sh
date +"%d.%m.%Y - %H:%M:%S"

#count the total count of encrypted passwords while checking if syspass frontend is still available smoothly for the users
ENCRYPTED_COUNT=$(find ./ -name 'syspass-stresstest-run-*.log' | xargs wc -l | tail -n1 | cut -d' ' -f3)
echo "$ENCRYPTED_COUNT" passwords in "$DURATION_SECONDS" seconds

rm syspass-stresstest-run-*.log
