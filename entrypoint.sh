#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us

export NODE_ENV=production

#export PORT=80
#export GITHUB_APP_ID=$APP_ID
# for this first one, eg: https://travistidwell.com/jsencrypt/demo/
#export RSA_PRIVATE_KEY=$(echo "$RSA_PKEY" |sed 's/NEWLINE/\\n/g')
#export GITHUB_PRIVATE_KEY=$(echo "$RSA" |sed 's/NEWLINE/\\n/g')

## the key env vars need to be base64 encoded for transport, and we'll unpack it to:
##   "-----BEGIN RSA PRIVATE KEY-----\n[..KEY..]\n-----END RSA PRIVATE KEY-----"
## export GITHUB_PRIVATE_KEY=$(echo "$RSA" |base64 -d|sed ':a;N;$!ba;s/\n/\\n/g')
## cat RSA_PKEY.key |tr '\n' ' ' |perl -pe 's/(KEY-----) /$1NEWLINE/; s/ (-----END)/NEWLINE$1/'


# The docs currently state that the GitHub Application ID in config.production.json is githubAppId; actually, it’s gitHubAppID.


cat >| config.production.json <<EOF
{
  "githubAppID": "$APP_ID",
  "githubPrivateKey": "$RSA",
  "rsaPrivateKey": "$RSA_PKEY",
  "port": 80
}
EOF

sed -i 's/NEWLINE/\\n/g' config.production.json

while true; do
  set +e
  npm start
  set -e
  echo DIED
  sleep 15
done
