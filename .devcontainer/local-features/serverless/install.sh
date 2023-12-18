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

# If AWS Tools for .NET are requested.
# See https://aws.amazon.com/developer/language/net/tools/
if [ "${INSTALL_AWS_TOOLS_FOR_DOTNET}" = "true" ]; then
  echo "Installing .NET Tools for Amazon Lambdas..."
  # Install .NET project templates
  dotnet new -i Amazon.Lambda.Templates::*
  # Install .NET CLI tools
  dotnet tool install -g amazon.lambda.tools
  dotnet tool install -g amazon.lambda.testtool-6.0

  # List installed packages
  dotnet tool list -g
fi
