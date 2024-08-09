#!/bin/bash

set -e

# shellcheck source=/dev/null
. /usr/local/containerbase/util.sh
# shellcheck source=/dev/null
. /usr/local/containerbase/utils/v2/overrides.sh

# shellcheck source=/dev/null
. /home/ubuntu/.nix-profile/etc/profile.d/nix.sh

# trim leading v
TOOL_VERSION=${1#v}

# shellcheck disable=SC1091
#CODENAME=$(. /etc/os-release && echo "${VERSION_CODENAME}")

ARCH=$(uname -p)
tp=$(create_versioned_tool_path)

check_semver "${TOOL_VERSION}"

echo "Building ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"

if [[ "${DEBUG}" == "true" ]]; then
  set -x
fi

echo "------------------------"
echo "init repo"

git reset --hard "${TOOL_VERSION}"


echo "------------------------"
echo "build ${TOOL_NAME}"
nix-build .#nix-static


mkdir "${tp}/bin"
cp result/bin/nix "${tp}/bin/nix"
shell_wrapper nix "${tp}/bin"

echo "------------------------"
echo "testing"
nix --version

file "${tp}/bin/nix"
#ldd "${tp}/bin/nix"

echo "------------------------"
echo "create archive"
echo "Compressing ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"
sudo tar -cJf "/cache/${TOOL_NAME}-${TOOL_VERSION}-${ARCH}.tar.xz" -C "$(find_tool_path)" "${TOOL_VERSION}"
