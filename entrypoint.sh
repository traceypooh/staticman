#!/bin/bash -e

pwd
env; # xxx

# create our config on-demand from our runtime-only environment variables passed in to us
cat > config.production.json <<EOF
{
  "gitlabToken": "$SEKRIT",
  "githubToken": "$SEKRIT"
  "rsaPrivateKey": "-----BEGIN RSA PRIVATE KEY-----$SEKRIT-----END RSA PRIVATE KEY-----",
  "port": 80
}
EOF

exec npm start
