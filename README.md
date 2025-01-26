# staticman

This allows static site generators (eg: jekyll, hugo) to get comments into the website

from https://staticman.net/docs/getting-started

Opted for the recommended option for using a GitHub App
"Option 1. Authenticate as a GitHub application"

Its private key becomes secret `GH_PRIVATE_KEY` and the app ID becomes secret `APP_ID`.

I created a 2nd private key to secret `RSA_PRIVATE_KEY`.

See [entrypoint.sh](entrypoint.sh) for more details.
