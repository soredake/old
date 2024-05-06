#!/bin/bash

cd "$(mktemp -d)" || exit
curl -s https://api.github.com/repos/Docile-Alligator/Infinity-For-Reddit/releases/latest | jq -r ".assets[] | select(.name | test(\"apk\")) | select(.name | test(\"Patreon\"; \"i\") | not) | .browser_download_url" | xargs wget
curl -s https://api.github.com/repos/ReVanced/revanced-cli/releases/latest | jq -r ".assets[] | select(.name | test(\"jar\")) | .browser_download_url" | xargs wget
curl -s https://api.github.com/repos/ReVanced/revanced-patches/releases/latest | jq -r ".assets[] | select(.name | test(\"jar\")) | .browser_download_url" | xargs wget
export VERSION=$(filename="Infinity-v*.apk"; version=$(basename $filename .apk); echo ${version#*v})
java -jar revanced-cli*.jar patch --include=api --include=subscription -a Infinity*.apk -o Infinity-v${VERSION}_patched.apk -b revanced-patches-*.jar

java -jar revanced-cli-4.4.0-all.jar list-patches  --with-packages  --with-versions  --with-options  revanced-patches-3.2.0.jar | grep client --color

# Name: Spoof client
# Description: Restores functionality of the app by using custom client ID.
#         Title: OAuth client ID
#         Description: The Reddit OAuth client ID. You can get your client ID from https://www.reddit.com/prefs/apps. The application type has to be "Installed app" and the redirect URI has to be set to "infinity://localhost".
#         Key: client-id
# Description: Unlocks the subscription feature but requires a custom client ID.
