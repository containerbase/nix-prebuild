FROM ghcr.io/containerbase/base:13.8.36@sha256:e6a36fd4c7e9458b64e0b92f7c28c937aa4cb52598bb770034012c635a4de4e4


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
