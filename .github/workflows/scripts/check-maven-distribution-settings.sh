#!/bin/bash
set -o errexit

echo "::group::Checking Maven distribution settings"
if [ -n "${OVERRIDE_MAVEN_DISTRIBUTION_TYPE}" ]; then MAVEN_DISTRIBUTION_TYPE=${OVERRIDE_MAVEN_DISTRIBUTION_TYPE}; fi
if [ "${MAVEN_DISTRIBUTION_TYPE}" == "CUSTOM" ]
then
	if [ -n "${MAVEN_DISTRIBUTION_SNAPSHOTS_URL}" ] && [ -n "${MAVEN_DISTRIBUTION_RELEASES_URL}" ] && [ -n "${MAVEN_DISTRIBUTION_USERNAME}" ] && [ -n "${MAVEN_DISTRIBUTION_PASSWORD}" ]
	then
		echo "Using custom repository for Maven distribution."
	else
		echo -e "\e[31mCustom Maven distribution is enabled but not set up correctly.\e[0m"
		echo "The following variables must all be set:"
		echo "    MAVEN_DISTRIBUTION_SNAPSHOTS_URL"
		echo "    MAVEN_DISTRIBUTION_RELEASES_URL"
		echo "    MAVEN_DISTRIBUTION_USERNAME"
		echo "    MAVEN_DISTRIBUTION_PASSWORD"
		exit 1
	fi
elif [ "${MAVEN_DISTRIBUTION_TYPE}" == "GITHUB" ] || [ -z "${MAVEN_DISTRIBUTION_TYPE}" ]
then
	echo "Using GitHub Packages for Maven distribution."
	export MAVEN_DISTRIBUTION_SNAPSHOTS_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_RELEASES_URL=https://maven.pkg.github.com/${GITHUB_REPOSITORY}
	export MAVEN_DISTRIBUTION_USERNAME=${GITHUB_ACTOR}
	export MAVEN_DISTRIBUTION_PASSWORD=${GITHUB_TOKEN}
else
	echo -e "\e[31mUnknown Maven distribution type.\e[0m"
	echo "Set it to either 'GITHUB' or 'CUSTOM' (with 'GITHUB' being the default value if left empty)."
	exit 1
fi
echo "::endgroup::"
