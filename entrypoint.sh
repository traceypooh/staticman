#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us

export NODE_ENV=production

# For RSA_PRIVATE_KEY, I just made a (random) new key from: https://travistidwell.com/jsencrypt/demo/

# For "transport" issues making the pathway from GH Secrets > nomad > env var inside container,
# we switch the [NEWLINE] chars to [SPACE] chars, and then swap the 1st & last [SPACE] chars
# to "NEWLINE" string, eg:
# -----BEGIN RSA PRIVATE KEY-----NEWLINE<value with SPACE chars>NEWLINE-----END RSA PRIVATE KEY-----
#
# with something like this:
#  cat RSA_PKEY.key |tr '\n' ' ' |perl -pe 's/(KEY-----) /$1NEWLINE/; s/ (-----END)/NEWLINE$1/'
#
# We then later swap "NEWLINE" strings to "\\n" in the JSON file below

# The docs currently state that the GitHub Application ID in config.production.json is githubAppId; actually, it’s gitHubAppID.


cat >| config.production.json <<EOF
{
  "githubAppID": "$APP_ID",
  "githubPrivateKey": "$GH_PRIVATE_KEY",
  "rsaPrivateKey": "$RSA_PRIVATE_KEY",
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
