#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us

# the key env var needs to be base64 encoded for transport, and we'll unpack it to:
#   "-----BEGIN RSA PRIVATE KEY-----\n[..KEY..]\n-----END RSA PRIVATE KEY-----"

export NODE_ENV=production
export PORT=80
export GITHUB_PRIVATE_KEY=$(echo "$RSA" |base64 -d|sed ':a;N;$!ba;s/\n/\\n/g')
export GITHUB_APP_ID=$APP_ID

# cat >| config.production.json <<EOF
# {
#   "githubToken": "$GHTOK",
#   "rsaPrivateKey": "$RSA_1LINER",
#   "port": 80
# }
# EOF

# sed -i 's/NEWLINE/\\n/g' config.production.json

while true; do
  set +e
  npm start
  set -e
  echo DIED
  sleep 15
done
