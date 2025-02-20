#!/bin/zsh -e

# create our config on-demand from our runtime-only environment variable secrets passed in to us
# from GitHub Actions

export NODE_ENV=production

cat >| config.production.json <<EOF
{
  "githubAppID": "$APP_ID",
  "githubPrivateKey": "$GH_PRIVATE_KEY",
  "rsaPrivateKey": "$GH_PRIVATE_KEY",
  "port": 80
}
EOF

# Swap "NEWLINE" strings to "\n" in the JSON config
sed -i 's/NEWLINE/\\n/g' config.production.json

# just in case this crashes, make a super cheap restarter loop
while true; do
  set +e
  npm start
  set -e
  echo DIED
  sleep 15
done
