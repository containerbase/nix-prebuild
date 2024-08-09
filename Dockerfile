FROM ghcr.io/containerbase/base:11.9.1@sha256:abc869b6fd4bffbf0ccd107ffc73078bd3e6aeb2ff08858424cdd5810ee920e6


#--------------------------------------
# builder images
#--------------------------------------
# FROM build-${DISTRO} as builder

ARG APT_PROXY

# add required gitpod and other system packages
RUN set -ex; \
  install-apt \
    sudo \
    ; \
  true

# allow sudo without password
RUN set e; \
  echo "$USER_NAME ALL = NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME; \
  chmod 0440 /etc/sudoers.d/$USERNAME; \
  s

ENTRYPOINT [ "dumb-init", "--", "builder.sh" ]

COPY --chmod=755 bin /usr/local/bin

ENV TOOL_NAME=nix

RUN install-builder.sh

WORKDIR /usr/src

USER 1000

RUN bash <(curl -L https://nixos.org/nix/install) --no-daemon
