FROM ghcr.io/containerbase/base:12.0.2@sha256:788939a46f861fb70060d7ec62574447c12e8eb2cf35c6e2314d43ad19208f61


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
