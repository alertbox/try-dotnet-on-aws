#!/usr/bin/env bash

set -e

NPM_PACKAGES=${PACKAGES}

echo "Activating feature 'npm-ig'"

# The 'install.sh' entrypoint script is always executed as the root user.

# If packages are requested, loop thru and install globally.
if [ ${#NPM_PACKAGES[@]} -gt 0 ]; then
    echo "Installing packages: ${NPM_PACKAGES}"
    packages=(`echo ${NPM_PACKAGES} | tr ',' ' '`)

    for i in "${packages[@]}"
    do
      if [ "$(npm list --global --depth 0 --omit dev | grep "${i}")" != "" ]; then
        echo "${i} already exists - skipping installation"
        continue
      fi

      echo "Installing ${i}"
      su ${_REMOTE_USER} -c "yarn global add ${i}" || continue
    done
fi
