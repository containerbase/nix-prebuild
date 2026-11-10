FROM ghcr.io/containerbase/base:14.66.14@sha256:979631e1e5cd5bcdb8c0a11dc7ff8f668e85b8a7bb5d41f90088fce47ac92ebd


#--------------------------------------
# builder images
#--------------------------------------
# FROM build-${DISTRO} as builder

ARG APT_HTTP_PROXY


ENTRYPOINT [ "dumb-init", "--", "builder.sh" ]

COPY --chmod=755 bin /usr/local/bin

ENV TOOL_NAME=nix

RUN install-builder.sh

WORKDIR /usr/src/nix

USER 12021

RUN bash <(curl --fail -L https://nixos.org/nix/install) --no-daemon
