FROM ubuntu:latest

ARG ACCOUNT_ID=none
ENV ACCOUNT_ID=$ACCOUNT_ID

# betanet, testnet, mainnet...
ARG NETWORK=none
ENV NETWORK=$NETWORK

WORKDIR /root

ENV NEARCORE_PATH=nearcore/target/release

COPY nearcore/target/release ${NEARCORE_PATH}

RUN apt-get update && apt-get install -y python3 git python3-pip
RUN pip3 install --upgrade pip && pip3 install --user nearup && echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile || true

EXPOSE 3030 24567

CMD /bin/bash -c "source ~/.profile && nearup run $NETWORK --binary-path $NEARCORE_PATH --home \"/.near/data/\" --account-id $ACCOUNT_ID && nearup logs --follow"
