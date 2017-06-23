FROM node:8.1

ENV DEBIAN_FRONTEND noninteractive

COPY . /nimiq

WORKDIR /nimiq
RUN npm install
RUN npm run build

WORKDIR /nimiq/src/main/platform/nodejs
RUN npm install

WORKDIR /nimiq/clients/nodejs
RUN npm install

ENV WALLET_SEED your-wallet-seed
ENV HOST your-hostname
ENV PORT 50100
ENV KEY_PATH /certs/privkey.pem
ENV CERT_PATH /certs/fullchain.pem

WORKDIR /nimiq/clients/nodejs
CMD /usr/local/bin/node index.js --miner --host $HOSTNAME --port $PORT --key $KEY_PATH --cert $CERT_PATH --wallet-seed $WALLET_SEED
