FROM ubuntu:latest


# below is for alpine
# RUN apk add python3 git curl
RUN apt-get update && apt-get install -y python3 git curl

WORKDIR /root

ARG account_id=gielve.stakehouse.betanet
ENV account_id=$account_id

ENV nearcore_path=nearcore/target/release

# need to be compiled on a linux system

COPY nearcore/target/release ${nearcore_path}
# Install nearup
RUN curl --proto '=https' --tlsv1.2 -sSfL https:/up.near.dev | python3 && source ~/.profile || true

# CMD nearup betanet --nodocker --account-id $account_id
CMD nearup betanet --nodocker --binary-path $nearcore_path --account-id $account_id & sleep infinity

# CMD tail -f /dev/null
# Add metadata to the image to describe which port the container is listening on at runtime.
# EXPOSE 8080
