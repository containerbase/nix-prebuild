#-------------------------
# renovate rebuild trigger
# https://github.com/cachix/devenv/tags
#-------------------------

# makes lint happy
FROM scratch

# renovate: datasource=github-tags depName=devenv packageName=cachix/devenv versioning=loose
ENV DEVENV_VERSION=2.3
