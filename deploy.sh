#!/bin/bash

echo -e "\nMomo Deploy Start!!!"

# Set Profile
PROFILE="dev"
echo "  > current profile : ${PROFILE}"


# Set Variables
JAR_PATH="./momo/momo-0.0.1-SNAPSHOT.jar"
PROCESS_NAME="momo"
LOG_FILE="application.log"


# Process Detect And Terminate Task
echo -e "\nReady to terminate current process..."

PID=$(pgrep -f "${PROCESS_NAME}")
if [ -z "${PID}" ]; then
  echo "  > process not detected!!"
else
  echo "  > process ${PID} detected!!"
  kill -15 "${PID}"
  while (lsof -Pi :8080 -sTCP:LISTEN | grep 8080); do sleep 1; done
  echo "  > Process Terminate Success!!"
fi


# Jar Execution Task
echo -e "\nReady to execute jar..."

chmod +x ./momo/momo-0.0.1-SNAPSHOT.jar
nohup java -jar "${JAR_PATH}" --spring.profiles.active="${PROFILE}" >>"${LOG_FILE}" 2>/dev/null &
echo "  > Jar Execute Success!!"
