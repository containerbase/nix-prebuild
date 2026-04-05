FROM ghcr.io/containerbase/base:14.6.11@sha256:38798b60223c1bb258672f5ff5c6b3bceea37567b56824d214fe1b1e5018367d


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
