# containerbase nix releases

[![build](https://github.com/containerbase/nix-prebuild/actions/workflows/build.yml/badge.svg)](https://github.com/containerbase/nix-prebuild/actions/workflows/build.yml)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/containerbase/nix-prebuild)
![License: MIT](https://img.shields.io/github/license/containerbase/nix-prebuild)

Prebuild nix releases used by [containerbase/base](https://github.com/containerbase/base).

## Local development

Build the image

```bash
docker build -t builder --build-arg APT_PROXY=http://apt-proxy:3142 --build-arg DISTRO=focal .
```

Test the image

```bash
docker run --rm -it -v ${PWD}/.cache:/cache -e DEBURG=true builder 8.0.3
```

`${PWD}/.cache` will contain packed releases after successful build.

Optional environment variables

| Name        | Description                                                  | Default   |
| ----------- | ------------------------------------------------------------ | --------- |
| `DISTRO`    | Set an ubuntu base distro, `focal` and `jammy` are supported | `focal`   |
| `APT_PROXY` | Set an APT http proxy for installing build deps              | `<empty>` |
| `DEBUG`     | Show verbose nix build output                                | `<empty>` |
