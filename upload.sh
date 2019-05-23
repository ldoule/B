#!/bin/bash

VersionString=`grep -E 's.version.*=' B.podspec`
VersionNumber= "$VersionString" #`tr -cd 0.0.0-9.9.9 <<<"$VersionString"`

# NewVersionNumber=$(($VersionNumber + 1))
NewVersionNumber=$(date +%Y%m%d%H%M%S)

LineNumber=`grep -nE 's.version.*=' B.podspec | cut -d : -f1`
sed -i "" "${LineNumber}s/${VersionNumber}/${NewVersionNumber}/g" B.podspec

echo "current version is ${VersionNumber}, new version is ${NewVersionNumber}"

git add .
git commit -am ${NewVersionNumber}
git tag ${NewVersionNumber}
git push origin master --tags
pod repo push dlrepo B.podspec --verbose --allow-warnings --use-libraries --use-modular-headers

