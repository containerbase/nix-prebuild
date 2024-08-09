#!/bin/bash

set -e

# shellcheck source=/dev/null
. /usr/local/containerbase/util.sh
# shellcheck source=/dev/null
. /usr/local/containerbase/utils/v2/overrides.sh


# trim leading v
TOOL_VERSION=${1#v}

# shellcheck disable=SC1091
#CODENAME=$(. /etc/os-release && echo "${VERSION_CODENAME}")

ARCH=$(uname -p)


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
nix build .#nix-static

mkdir "/usr/local/${TOOL_NAME}/${TOOL_VERSION}/bin"
cp result/bin/nix "/usr/local/${TOOL_NAME}/${TOOL_VERSION}/bin/nix"

echo "------------------------"
echo "testing"
"/usr/local/${TOOL_NAME}/${TOOL_VERSION}/bin/nix" --version

file "/usr/local/${TOOL_NAME}/${TOOL_VERSION}/bin/nix"
#ldd "/usr/local/${TOOL_NAME}/${TOOL_VERSION}/bin/nix"

echo "------------------------"
echo "create archive"
echo "Compressing ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"
tar -cJf "/cache/${TOOL_NAME}-${TOOL_VERSION}-${ARCH}.tar.xz" -C "/usr/local/${TOOL_NAME}" "${TOOL_VERSION}"