#-------------------------
# renovate rebuild trigger
# https://github.com/NixOS/nix/tags
#-------------------------

# makes lint happy
FROM scratch

# renovate: datasource=github-tags depName=nix packageName=NixOS/nix versioning=semver
ENV NIX_VERSION=2.27.1
