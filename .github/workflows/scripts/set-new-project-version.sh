#!/bin/bash
set -o errexit

echo "::group::Set new version"
mvn ${MAVEN_DEFAULT_ARGS} build-helper:parse-version versions:set versions:commit -DnewVersion="${NEW_PROJECT_VERSION}"
git commit --all --message="${GIT_COMMIT_MESSAGE}"
git push
echo "::endgroup::"
