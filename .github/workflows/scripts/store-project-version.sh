#!/bin/bash
set -o errexit

if [ -z "${OUTPUT_VARIABLE_NAME}" ]; then OUTPUT_VARIABLE_NAME=projectVersion; fi

echo "::group::Storing project version (into variable '${OUTPUT_VARIABLE_NAME}')"
if [ -n "${PROJECT_DIRECTORY}" ]; then cd ${PROJECT_DIRECTORY}; fi
EXTRACT_PROJECT_VERSION_COMMAND="mvn ${MAVEN_DEFAULT_ARGS} help:evaluate -Dexpression=project.version -q"
# Note: Running the command first without assigning to a variable ensures that a failure will exit this script.
${EXTRACT_PROJECT_VERSION_COMMAND}
PROJECT_VERSION=$(${EXTRACT_PROJECT_VERSION_COMMAND} -DforceStdout)
echo "Project version: ${PROJECT_VERSION}"
echo "::endgroup::"

echo "::set-output name=${OUTPUT_VARIABLE_NAME}::${PROJECT_VERSION}"
