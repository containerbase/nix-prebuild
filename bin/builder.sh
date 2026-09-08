#!/bin/bash

set -e

# shellcheck source=/dev/null
. /usr/local/containerbase/util.sh
# shellcheck source=/dev/null
. /usr/local/containerbase/utils/v2/overrides.sh

export PATH="${USER_HOME}/.nix-profile/bin:${PATH}"

# trim leading v
TOOL_VERSION=${1#v}

ARCH=$(uname -m)
tp=$(create_versioned_tool_path)
target=.#devenv-static-unwrapped
nix_args=()

check_semver "${TOOL_VERSION}"

if dpkg --compare-versions "${TOOL_VERSION}" lt "2.3"; then
  echo "${TOOL_NAME} ${TOOL_VERSION} has no static flake output! Use v2.3 or higher." >&2
  exit 1
fi

echo "Building ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"

if [[ "${DEBUG}" == "true" ]]; then
  set -x
  nix_args+=(--print-build-logs)
fi

echo "------------------------"
echo "init repo"

git reset --hard "v${TOOL_VERSION}"
git clean -fdx

echo "------------------------"
echo "build ${TOOL_NAME}"
nix --extra-experimental-features "nix-command flakes" \
  build "${nix_args[@]}" --accept-flake-config "${target}"

mkdir "${tp}/bin"
cp result/bin/devenv "${tp}/bin/devenv"

echo "------------------------"
echo "testing"
"${tp}/bin/devenv" --version

file "${tp}/bin/devenv"

if ! file -b "${tp}/bin/devenv" | grep -qE 'statically linked|static-pie linked'; then
  echo "Not a statically linked binary - aborting" >&2
  exit 1
fi

echo "------------------------"
echo "create archive"
echo "Compressing ${TOOL_NAME} ${TOOL_VERSION} for ${ARCH}"
sudo tar -cJf "/cache/${TOOL_NAME}-${TOOL_VERSION}-${ARCH}.tar.xz" -C "$(find_tool_path)" "${TOOL_VERSION}"
