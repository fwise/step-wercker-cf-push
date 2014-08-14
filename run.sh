wget http://go-cli.s3-website-us-east-1.amazonaws.com/releases/v6.3.2/cf-linux-amd64.tgz
tar -zxvf cf-linux-amd64.tgz
CF=./cf

${CF} api ${WERCKER_CF_PUSH_CLOUDFOUNDRY_API_URL}

appname=${WERCKER_CF_PUSH_CLOUDFOUNDRY_APP_NAME}
username=${WERCKER_CF_PUSH_CLOUDFOUNDRY_USER_NAME}
password=${WERCKER_CF_PUSH_CLOUDFOUNDRY_USER_PASS}
organization=${WERCKER_CF_PUSH_CLOUDFOUNDRY_USER_PASS}
space=${WERCKER_CF_PUSH_CLOUDFOUNDRY_USER_PASS}
${CF} login -u $username -p $password -o $organization -s $space

PUSH_CMD=""

if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_USE_MANIFEST} == true ]; then
  PUSH_CMD="${CF} push ${appname}"

else
  PUSH_CMD="${CF} push ${appname}"

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_BUILDPACK} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -b ${WERCKER_CF_PUSH_CLOUDFOUNDRY_BUILDPACK}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_COMMAND} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -c ${WERCKER_CF_PUSH_CLOUDFOUNDRY_COMMAND}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_DOMAIN} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -d ${WERCKER_CF_PUSH_CLOUDFOUNDRY_DOMAIN}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_NUM_INSTANCES} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -i ${WERCKER_CF_PUSH_CLOUDFOUNDRY_NUM_INSTANCES}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_MEMORY} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -m ${WERCKER_CF_PUSH_CLOUDFOUNDRY_MEMORY}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_HOST} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -n ${WERCKER_CF_PUSH_CLOUDFOUNDRY_HOST}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_PATH} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -p ${WERCKER_CF_PUSH_CLOUDFOUNDRY_PATH}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_STACK} != "" ]; then
    PUSH_CMD="${PUSH_CMD} -s ${WERCKER_CF_PUSH_CLOUDFOUNDRY_STACK}"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_NO_HOSTNAME} ]; then
    PUSH_CMD="${PUSH_CMD} --no-hostname"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_NO_ROUTE} ]; then
    PUSH_CMD="${PUSH_CMD} --no-route"
  fi

  if [ ${WERCKER_CF_PUSH_CLOUDFOUNDRY_NO_START} ]; then
    PUSH_CMD="${PUSH_CMD} --no-start"
  fi
fi;

echo ${PUSH_CMD} | sh
