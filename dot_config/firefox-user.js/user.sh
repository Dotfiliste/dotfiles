#! /bin/bash

# https://github.com/yokoffing/Betterfox

MAC_ZEN_PROFILES_PATH="$HOME/Library/Application Support/zen/Profiles"
PROFILE_FOLDER=$(find "$MAC_ZEN_PROFILES_PATH" -type d -maxdepth 1 -name '* (release)')

curl -s https://raw.githubusercontent.com/yokoffing/Betterfox/main/user.js > user.js
cat my-user.js >> user.js
mv user.js "$PROFILE_FOLDER/user.js"
