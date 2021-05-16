#!/bin/bash
set -o errexit

echo "::group::Creating release branch"
mvn ${MAVEN_DEFAULT_ARGS} build-helper:parse-version scm:branch -Dbranch="${RELEASE_BRANCH_NAME}"
echo "::endgroup::"
