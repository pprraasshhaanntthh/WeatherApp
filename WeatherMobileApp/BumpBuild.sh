#!/bin/bash

set -Eeuo pipefail

APP_TARGET="WeatherMobileApp"
WIDGET_TARGET="News Widget"

echo pwd

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

WIDGET_PLIST=$(
    xcodebuild -project "$PROJECT_FILE" -target "$WIDGET_TARGET" -showBuildSettings \
    | grep "INFOPLIST_FILE" \
    | awk -F  "=" '{print $2}' \
    | awk '{$1=$1};1'
)

if [ -z "${WIDGET_PLIST:-}" ]; then
  echo "** ERROR: Unable to locate  widget info plist file"
  exit -1
fi

BUILD_BUILDID=$(/usr/libexec/PlistBuddy -c "Print CFBundleVersion" $APP_PLIST)
BUILD_BUILDID=$(($BUILD_BUILDID+1))


if [[ -z "${BUILD_BUILDID:-}" ]]; then
    echo "** ERROR: Unable to determine build number."
    exit -1
fi

echo "** INFO: Setting build number to $BUILD_BUILDID."
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_BUILDID" $APP_PLIST
/usr/libexec/PlistBuddy -c "Set :CFBundleVersion $BUILD_BUILDID" $WIDGET_PLIST

exit 0
