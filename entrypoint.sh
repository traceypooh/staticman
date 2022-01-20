#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variables passed in to us
cat >| config.production.json <<EOF
{
  "gitlabToken": "$GLTOK",
  "rsaPrivateKey": "$RSA",
  "port": 80
}
EOF

sed -i 's/NEWLINE/\\n/g' config.production.json

export NODE_ENV=production


while true; do
  ( set +e; npm start )
  echo DIED
  sleep 15
done
