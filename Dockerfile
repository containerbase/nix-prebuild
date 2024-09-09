FROM ghcr.io/containerbase/base:11.11.12@sha256:42469cfb8f6d7fd2fe49a56b7361a3b74c74ee4e261983068cc0ffa33e6fdf48


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
