# staticman

This allows static site generators (eg: jekyll, hugo) to get comments into the website

from https://staticman.net/docs/getting-started

Opted for the recommended option for using a GitHub App
"Option 1. Authenticate as a GitHub application"

Its private key becomes secret `GH_PRIVATE_KEY` and the app ID becomes secret `APP_ID`.

I created a 2nd private key to secret `RSA_PRIVATE_KEY`.

Just add those 3 GitHub Secrets (`APP_ID`, `GH_PRIVATE_KEY`, `RSA_PRIVATE_KEY`) to your repo in the

`Settings`: `Security`: `Secrets and variables`: `Actions`

See [entrypoint.sh](entrypoint.sh) for more details.


## Issues needing fixes

The docs currently state that the GitHub Application ID in config.production.json is githubAppId; actually, it’s gitHubAppID.


## ssh/rsa key details

For the `RSA_PRIVATE_KEY`, I just made a (random) new key from:

https://travistidwell.com/jsencrypt/demo/

For "transport" string encoding issues, making the pathway from GH Secrets to: nomad/orchestration to: env var inside the container,
we switch the `[NEWLINE]` chars to `[SPACE]` chars, and then swap the 1st & last `[SPACE]` chars
to the string `"NEWLINE"`, eg:

```txt
-----BEGIN RSA PRIVATE KEY-----NEWLINE<value with SPACE chars>NEWLINE-----END RSA PRIVATE KEY-----
```

with something like this:

```sh
cat RSA_PKEY.key |tr '\n' ' ' |perl -pe 's/(KEY-----) /$1NEWLINE/; s/ (-----END)/NEWLINE$1/'
```

We then later swap `"NEWLINE"` strings to "\\n" (newline characters) in the JSON file in [entrypoint.sh](entrypoint.sh) just before the `npm start` happens at the start of the container.
