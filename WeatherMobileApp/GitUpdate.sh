#!/bin/bash

set -Eeuo pipefail

APP_TARGET="WeatherMobileApp"

cd WeatherMobileApp

PROJECT_FILE=$(find . -d 1 -iname '*.xcodeproj')

APP_PLIST=$(
    xcodebuild -project "$PROJECT_FILE" -target "$APP_TARGET" -showBuildSettings \
    | grep "INFOPLIST_FILE" \
    | awk -F  "=" '{print $2}' \
    | awk '{$1=$1};1'
)

if [ -z "${APP_PLIST:-}" ]; then
  echo "** ERROR: Unable to locate app info plist file"
  exit -1
fi

BUILD_BUILDID=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $APP_PLIST)

if [[ -z "${BUILD_BUILDID:-}" ]]; then
echo "** ERROR: Unable to determine build number."
exit -1
fi

git add "$APP_PLIST"
git commit -m"Info plist updated"
git push origin HEAD:release/version/1.0

echo "** INFO: Setting build number to $BUILD_BUILDID."
exit 0
