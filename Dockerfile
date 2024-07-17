FROM ubuntu:22.04 AS build

WORKDIR /hyperliquid/
RUN apt-get update && \
  apt-get install -y curl && \
  curl https://binaries.hyperliquid.xyz/Testnet/hl-visor -s -o /hyperliquid/hl-visor && \
  chmod +x /hyperliquid/hl-visor

COPY . .

FROM ubuntu:22.04

ARG USER_ID=1000
ARG GROUP_ID=1001
RUN apt-get update && \
  apt-get install -y curl && \
  groupadd -g ${GROUP_ID} node && \
  useradd -m -u ${USER_ID} -g node node

WORKDIR /home/node/
COPY --chown=node:node --from=build /hyperliquid/hl-visor /home/node/hl-visor
COPY --chown=node:node --from=build /hyperliquid/non_validator_config.json /home/node/non_validator_config.json
COPY --chown=node:node --from=build /hyperliquid/initial_peers.json /home/node/initial_peers.json
COPY --chown=node:node --from=build /hyperliquid/visor.json /home/node/visor.json

RUN mkdir -p /home/node/hl/ && chown -R node:node /home/node/hl/

EXPOSE 8000 9000

USER node
ENV RUST_BACKTRACE=1
ENV RUST_LOG=debug
ENTRYPOINT [ "./hl-visor" ]

