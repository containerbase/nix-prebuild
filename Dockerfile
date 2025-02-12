FROM ghcr.io/containerbase/base:13.7.12@sha256:2196fac1d02596edc810f038146d9210d8f3ef67945308984652ea3a0a6f118a


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
