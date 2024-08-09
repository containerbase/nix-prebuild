#!/bin/bash

set -e

# shellcheck source=/dev/null
. /usr/local/containerbase/util.sh
# shellcheck source=/dev/null
. /usr/local/containerbase/utils/v2/overrides.sh

# add required system packages
install-apt \
    sudo \
    ;

# allow sudo without password
echo "${USER_NAME} ALL = NOPASSWD: ALL" > "/etc/sudoers.d/${USER_NAME}"
chmod 0440 "/etc/sudoers.d/${USER_NAME}"
sudo id

# prepare nix source
chmod g+w /usr/src
sudo -u "${USER_NAME}" git clone https://github.com/NixOS/nix.git /usr/src/nix

# create folders
create_tool_path > /dev/null
mkdir /cache
