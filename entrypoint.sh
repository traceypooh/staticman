#!/bin/bash -e

# create our config on-demand from our runtime-only environment variables passed in to us
cat >| config.production.json <<EOF
{
  "gitlabToken": "$GLTOK",
  "rsaPrivateKey": "$RSA",
  "port": 80
}
EOF

sed -i 's/NEWLINE/\n/g' README.md

exec npm start
