FROM ghcr.io/containerbase/base:11.11.4@sha256:0a082adc453fc0d8436c54267b95b76b2e9c4750e0b40c1348d8abd30af71d51


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
