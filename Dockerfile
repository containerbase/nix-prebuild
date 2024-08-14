FROM ghcr.io/containerbase/base:11.11.0@sha256:ca03a334e8e3959e72e63f9a5860f98c564955be52ce66be764ebe81d4127fc2


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
