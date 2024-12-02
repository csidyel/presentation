#!/bin/bash
# Usage: ./.semaphore/helpers/install_chrome.sh
# Installs Chrome and Chromedriver to /usr/local/bin/chrome and /usr/local/bin/chromedriver
# This script assumes you've already run download_chrome.sh or restored vendor/chrome from Semaphore cache
# If it cannot find the 'vendor/chrome' directory, it will re-download Chrome and Chromedriver.

set -euo pipefail # https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/

if [ ! -d "vendor/chrome" ]; then
  echo "'vendor/chrome' not found, downloading Chrome and Chromedriver..."
  ./.semaphore/helpers/download_chrome.sh
fi

sudo cp -r vendor/chrome/chrome-linux64 /usr/local/bin/chrome-linux64
sudo ln -sf /usr/local/bin/chrome-linux64/chrome /usr/local/bin/chrome
sudo ln -sf /usr/local/bin/chrome-linux64/chrome /usr/bin/google-chrome
sudo cp -r vendor/chrome/chromedriver-linux64 /usr/local/bin/chromedriver-linux64
sudo ln -sf /usr/local/bin/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver

CHROME_VERSION=$(chrome --version)
CHROMEDRIVER_VERSION=$(chromedriver --version)

echo "Installed chrome ($CHROME_VERSION) and chromedriver ($CHROMEDRIVER_VERSION)."
