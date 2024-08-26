FROM ghcr.io/containerbase/base:11.11.8@sha256:84abb66e5b105e1023dfd4b43a114c7d09ca68820c7db6a4e0a7e1e18ffbc426


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
