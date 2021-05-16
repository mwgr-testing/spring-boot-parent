#!/bin/bash
set -o errexit

source .github/workflows/scripts/check-maven-distribution-settings.sh

echo "::group::Performing the release with Maven"
mvn ${MAVEN_DEFAULT_ARGS} ${MAVEN_ADDITIONAL_ARGS} build-helper:parse-version release:prepare release:perform \
	-Darguments="${MAVEN_DEFAULT_ARGS} ${MAVEN_ADDITIONAL_ARGS}" \
	-Dgoals="deploy" \
	-DtagNameFormat="${TAG_NAME_FORMAT}" \
	-DdevelopmentVersion="${NEXT_DEVELOPMENT_VERSION}" \
	-DscmCommentPrefix="${SCM_COMMENT_PREFIX}"
echo "::endgroup::"
