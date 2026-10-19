FROM ghcr.io/containerbase/base:14.43.0@sha256:4646fdf373f044ddb51d85c7b31839f62a0491495b7da75b7eed39da425ad917


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
