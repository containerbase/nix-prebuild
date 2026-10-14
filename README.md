# containerbase nix releases

[![build](https://github.com/containerbase/nix-prebuild/actions/workflows/build.yml/badge.svg)](https://github.com/containerbase/nix-prebuild/actions/workflows/build.yml)
![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/containerbase/nix-prebuild)
![License: MIT](https://img.shields.io/github/license/containerbase/nix-prebuild)

Prebuild nix releases used by [containerbase/base](https://github.com/containerbase/base).

## Local development

`mise install` installs Node.js, pnpm, jactionlint, shellcheck, zizmor and the dependencies.

```bash
pnpm lint            # pnpm oxfmt-fix to fix the formatting
jactionlint          # the GitHub workflows
zizmor .github/      # security audit of the GitHub workflows
```

CI runs jactionlint and zizmor through mise in the `lint` job, and the commit hook runs them on staged workflow files.

Build the image

```bash
docker build -t builder --build-arg APT_HTTP_PROXY=http://apt-proxy:3142 .
```

Test the image

```bash
docker run --rm -it -v ${PWD}/.cache:/cache -e DEBUG=true builder 2.26.1
```

`${PWD}/.cache` will contain packed releases after successful build.

Optional environment variables

| Name             | Description                                     | Default   |
| ---------------- | ----------------------------------------------- | --------- |
| `APT_HTTP_PROXY` | Set an APT http proxy for installing build deps | `<empty>` |
| `DEBUG`          | Show verbose nix build output                   | `<empty>` |
