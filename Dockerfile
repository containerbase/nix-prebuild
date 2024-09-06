FROM ghcr.io/containerbase/base:11.11.11@sha256:35a28285bdf54adb610c63ea9e0fbce391b21c8ae7a8aaa3d00629e421a2cc87


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

USER 1000

RUN bash <(curl -L https://nixos.org/nix/install) --no-daemon
