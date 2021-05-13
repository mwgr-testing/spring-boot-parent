#!/bin/bash
set -o errexit

echo "::group::Configuring user in global git configuration"
git config --global user.name "${GIT_USER_NAME}"
git config --global user.email "${GIT_USER_EMAIL}"
echo "::endgroup::"
