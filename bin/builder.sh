#!/bin/bash

set -e

# shellcheck source=/dev/null
. /usr/local/containerbase/util.sh
# shellcheck source=/dev/null
. /usr/local/containerbase/utils/v2/overrides.sh

export PATH="${USER_HOME}/.nix-profile/bin:${PATH}"

# trim leading v
TOOL_VERSION=${1#v}

# shellcheck disable=SC1091
#CODENAME=$(. /etc/os-release && echo "${VERSION_CODENAME}")

ARCH=$(uname -p)
tp=$(create_versioned_tool_path)
target=.#nix-cli-static

check_semver "${TOOL_VERSION}"

if dpkg --compare-versions "${TOOL_VERSION}" lt "2.26.0"; then
  target=.#nix-static
fi

echo "Building ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"

if [[ "${DEBUG}" == "true" ]]; then
  set -x
fi

echo "------------------------"
echo "init repo"

git reset --hard "${TOOL_VERSION}"


echo "------------------------"
echo "build ${TOOL_NAME}"
nix --extra-experimental-features "nix-command flakes" build ${target}


mkdir "${tp}/bin"
cp result/bin/nix "${tp}/bin/nix"

echo "------------------------"
echo "testing"
"${tp}/bin/nix" --version

file "${tp}/bin/nix"
#ldd "${tp}/bin/nix"

echo "------------------------"
echo "create archive"
echo "Compressing ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"
sudo tar -cJf "/cache/${TOOL_NAME}-${TOOL_VERSION}-${ARCH}.tar.xz" -C "$(find_tool_path)" "${TOOL_VERSION}"
