#!/usr/bin/env bash

set -e

NODE_PACKAGES=${PACKAGES}

echo "Activating feature 'np-install'."

# The 'install.sh' entrypoint script is always executed as the root user.

# If packages are requested, loop thru and install globally.
if [ ${#NODE_PACKAGES[@]} -gt 0 ]; then
    echo "Installing packages: ${NODE_PACKAGES}"
    to_install=(`echo ${NODE_PACKAGES} | tr ',' ' '`)

    for i in "${to_install[@]}"
    do
      if [ "$(npm list --global --depth 0 --omit dev | grep "${i}")" != "" ]; then
        echo "${i} already exists. Skipping installation."
        continue
      fi

      echo "Installing ${i}."
      su ${_REMOTE_USER} -c "npm install -g ${i}" || continue
    done
fi
