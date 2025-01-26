#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us
# eg:
# rsaPrivateKey: "-----BEGIN RSA PRIVATE KEY-----\nkey\n-----END RSA PRIVATE KEY-----"

cat >| config.production.json <<EOF
{
  "githubToken": "$GHTOK",
  "rsaPrivateKey": "$RSA",
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
