FROM nordstrom/baseimage-ubuntu:14.04

ENV VAULT_VERSION 0.5.0
ENV VAULT_SHA256 f81accce15313881b8d53b039daf090398b2204b1154f821a863438ca2e5d570

RUN apt-get update -qy \
 && apt-get install -qy curl unzip \
 && curl -sLo /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip \
 && echo "${VAULT_SHA256}  /tmp/vault.zip" > /tmp/vault.sha256 \
 && sha256sum -c /tmp/vault.sha256 \
 && cd /bin \
 && unzip /tmp/vault.zip \
 && chmod +x /bin/vault \
 && rm /tmp/vault.zip

ENTRYPOINT ["/bin/vault"]
