#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us

# this env var needs to be base64 encoded for transport, and we'll unpack it to:
# rsaPrivateKey: "-----BEGIN RSA PRIVATE KEY-----\n[..KEY..]\n-----END RSA PRIVATE KEY-----"

RSA_1LINER=$(echo "$RSA" |base64 -d|sed ':a;N;$!ba;s/\n/\\n/g')

cat >| config.production.json <<EOF
{
  "githubToken": "$GHTOK",
  "rsaPrivateKey": "$RSA_1LINER",
  "port": 80
}
EOF

sed -i 's/NEWLINE/\\n/g' config.production.json

export NODE_ENV=production


while true; do
  set +e
  npm start
  set -e
  echo DIED
  sleep 15
done
