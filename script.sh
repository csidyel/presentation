#!/bin/bash
# Downloads the latest stable chrome and chromedriver, and unzips them to vendor/chrome.
# Usage: ./.semaphore/helpers/download_chrome.sh

set -euo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

# detect if "jq" is installed, and install it if not
if ! command -v jq &> /dev/null
then
  echo "jq could not be found, installing it now..."
  sudo apt-get install jq
fi

#CHROME_STABLE_VERSION=$(./.semaphore/helpers/get_chrome_latest_version.sh)
CHROME_STABLE_VERSION="131.0.6778.85"
CHROME_DOWNLOAD_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_STABLE_VERSION/linux64/chrome-linux64.zip"
CHROMEDRIVER_DOWNLOAD_URL="https://storage.googleapis.com/chrome-for-testing-public/$CHROME_STABLE_VERSION/linux64/chromedriver-linux64.zip"
CHROME_CACHE_KEY="chrome-$CHROME_STABLE_VERSION"
CHROMEDRIVER_CACHE_KEY="chromedriver-$CHROME_STABLE_VERSION"

retry --sleep 5 --times 5 "cache restore ${CHROME_CACHE_KEY}"
#CHROME_CACHE_RESTORE_PID=$!
#wait $CHROME_CACHE_RESTORE_PID

retry --sleep 5 --times 5 "cache restore ${CHROMEDRIVER_CACHE_KEY}"
#CHROMEDRIVER_CACHE_RESTORE_PID=$!
#wait $CHROMEDRIVER_CACHE_RESTORE_PID

mkdir -p vendor/chrome

clear_cache=0

# download and unzip chrome zip file
if [ ! -f "vendor/chrome/chrome.zip" ]; then
  echo "Did not find vendor/chrome/chrome.zip. Downloading Chrome $CHROME_STABLE_VERSION..."
  clear_cache=1
  curl -s "$CHROME_DOWNLOAD_URL" > vendor/chrome/chrome.zip
fi
# check if extracted archive dir exists. if not, extract the zip
if [ ! -d "vendor/chrome/chrome-linux64" ]; then
  unzip -o vendor/chrome/chrome.zip -d vendor/chrome
fi

# download and unzip the chromedriver zip file
if [ ! -f "vendor/chrome/chromedriver.zip" ]; then
  echo "Did not find vendor/chrome/chromedriver.zip. Downloading Chrome $CHROME_STABLE_VERSION..."
  clear_cache=1
  curl -s "$CHROMEDRIVER_DOWNLOAD_URL" > vendor/chrome/chromedriver.zip
fi
# check if extracted archive dir exists. if not, extract the zip
if [ ! -d "vendor/chrome/chromedriver-linux64" ]; then
  unzip -o vendor/chrome/chromedriver.zip -d vendor/chrome
fi

# Store the cache if clear_cache=1
if [ "$clear_cache" -eq 1 ]; then
  cache delete  "$CHROME_CACHE_KEY" # clear out if it already exists. we want to store fresh data.
  retry --sleep 5 --times 5 "cache store $CHROME_CACHE_KEY vendor/chrome/chrome.zip"
  #CHROME_CACHE_STORE_PID=$!
  #wait $CHROME_CACHE_STORE_PID
  cache delete  "$CHROMEDRIVER_CACHE_KEY" # clear out if it already exists. we want to store fresh data.
  retry --sleep 5 --times 5 "cache store $CHROMEDRIVER_CACHE_KEY vendor/chrome/chromedriver.zip"
  #CHROMEDRIVER_CACHE_RESTORE_PID=$!
  #wait $CHROMEDRIVER_CACHE_RESTORE_PID
fi
