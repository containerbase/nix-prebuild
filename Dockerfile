FROM ghcr.io/containerbase/base:12.0.8@sha256:4c972bdc114bd049c41ac7ecbf5f50d19d4a202f7837bf2f0b5b6a3bae7ff407


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
