FROM ghcr.io/containerbase/base:13.4.5@sha256:c0b402890bfc22a8c1bb6fd4bd5687397d390d5936fa441f94800a08eadbe273


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

RUN bash <(curl -L https://nixos.org/nix/install) --no-daemon
