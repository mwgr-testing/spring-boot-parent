#!/bin/bash
set -o errexit

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Building the package and distributing it"
mvn ${MAVEN_DEFAULT_ARGS} ${MAVEN_ADDITIONAL_ARGS} clean deploy
echo "::endgroup::"
