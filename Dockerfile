FROM ghcr.io/containerbase/base:13.4.0@sha256:632b07d4a7c0019be8bb7b7b22d551bc3d574a25054ee12ce16950652db9789a


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
