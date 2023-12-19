#!/usr/bin/env bash

set -e

SLS_VERSION=${VERSION:-"latest"}
INSTALL_AWS_TOOLS_FOR_DOTNET=${INSTALL_TOOLS_FOR_DOTNET:-true}

echo "Activating feature 'serverless@${SLS_VERSION}'"

# The 'install.sh' entrypoint script is always executed as the root user.

# If we don't already have Serverless Framework installed, install it now.
# HACK: No binary installer for native aarch64 :(
# See https://github.com/serverless/serverless/issues/8696
# if ! serverless --version > /dev/null ; then
#   echo "Installing Serverless..."
#   if [ "${SLS_VERSION}" = "latest" ]; then
#       curl -o- -L https://slss.io/install | bash
#   else
#       curl -o- -L https://slss.io/install | VERSION=${SLS_VERSION} bash
#   fi
# fi
