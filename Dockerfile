FROM ghcr.io/containerbase/base:11.9.1@sha256:abc869b6fd4bffbf0ccd107ffc73078bd3e6aeb2ff08858424cdd5810ee920e6


#--------------------------------------
# builder images
#--------------------------------------
# FROM build-${DISTRO} as builder

ARG APT_PROXY

ENTRYPOINT [ "dumb-init", "--", "builder.sh" ]

COPY --chmod=755 bin /usr/local/bin


# renovate: datasource=github-tags packageName=NixOS/nix
RUN install-tool nix 2.24.2

ENV TOOL_NAME=nix

RUN install-builder.sh

WORKDIR /nix

