# containerbase devenv releases

[![build](https://github.com/containerbase/devenv-prebuild/actions/workflows/build.yml/badge.svg)](https://github.com/containerbase/devenv-prebuild/actions/workflows/build.yml)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/containerbase/devenv-prebuild)
![License: MIT](https://img.shields.io/github/license/containerbase/devenv-prebuild)

Prebuild [devenv](https://github.com/cachix/devenv) releases used by [containerbase/base](https://github.com/containerbase/base).

## Local development

Build the image

```bash
docker build -t builder --build-arg APT_HTTP_PROXY=http://apt-proxy:3142 .
```

Test the image

```bash
docker run --rm -it -v ${PWD}/.cache:/cache -e DEBUG=true builder 2.3
```

`${PWD}/.cache` will contain packed releases after successful build.

Optional environment variables

| Name             | Description                                     | Default   |
| ---------------- | ----------------------------------------------- | --------- |
| `APT_HTTP_PROXY` | Set an APT http proxy for installing build deps | `<empty>` |
| `DEBUG`          | Show verbose nix build output                   | `<empty>` |
