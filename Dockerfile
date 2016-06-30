FROM quay.io/nordstrom/baseimage-ubuntu:16.04

ARG VAULT_VERSION 
ARG VAULT_SHA256

USER root

RUN apt-get update -qy \
 && apt-get install -qy curl unzip \
 && curl -sLo /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
 && echo "${VAULT_SHA256}  /tmp/vault.zip" > /tmp/vault.sha256 \
 && sha256sum -c /tmp/vault.sha256 \
 && cd /bin \
 && unzip /tmp/vault.zip \
 && chmod +x /bin/vault \
 && rm /tmp/vault.zip

RUN chmod 755 /bin/vault
USER ubuntu

ENTRYPOINT ["/bin/vault"]
