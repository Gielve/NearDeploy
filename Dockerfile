FROM ubuntu:latest

ARG ACCOUNT_ID=none
ENV ACCOUNT_ID=$ACCOUNT_ID

# betanet, testnet, mainnet...
ARG NETWORK=none
ENV NETWORK=$NETWORK

WORKDIR /root

ENV NEARCORE_PATH=nearcore/target/release

COPY nearcore/target/release ${NEARCORE_PATH}

RUN apt-get update && apt-get install -y python3 git curl
RUN curl --proto '=https' --tlsv1.2 -sSfL https://up.near.dev | python3 && source ~/.profile || true

EXPOSE 3030 24567
CMD /bin/bash -c "source ~/.profile && nearup $NETWORK --nodocker --binary-path $NEARCORE_PATH --home \"/.near/data/\" --account-id $ACCOUNT_ID && nearup logs --follow"
