FROM ghcr.io/containerbase/base:12.0.9@sha256:c8278c4075bb04c39d7651b5aab9c70071f292976e1b8552def4c67116bde2d4


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
