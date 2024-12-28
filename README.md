# MASSA Blockchain Node - Docker Container

Dockerfile and startup scripts for MASSA node

MASSA_VERSION="MAIN.2.4"; \
docker image build \
   --build-arg MASSA_VERSION="$MASSA_VERSION" \
   -t "dex2build/massa-node:$MASSA_VERSION" \
   --no-cache \
   --progress=plain \
   .


MASSA_VERSION="MAIN.2.4"; \
docker image build \
   --build-arg MASSA_VERSION="$MASSA_VERSION" \
   -t "dex2build/massa-node:$MASSA_VERSION" \
   .


MASSA_VERSION="MAIN.2.4"; \
docker container create \
   -h "massa" \
   --name "massa_node_$MASSA_VERSION" \
   --restart always \
   -e MASSA_PASS="" \
   -e MASSA_ADDRESS="" \
   -p 31244:31244 \
   -p 31245:31245 \
   -p 31248:31248 \
   dex2build/massa-node:$MASSA_VERSION

MASSA_VERSION="MAIN.2.4"; \
docker container run \
   -d \
   -h "massa" \
   --name "massa_node_$MASSA_VERSION" \
   --restart always \
   -e MASSA_PASS="" \
   -p 31244:31244 \
   -p 31245:31245 \
   -p 31248:31248 \
   dex2build/massa-node:$MASSA_VERSION


MASSA_VERSION="MAIN.2.4"; \
docker container run \
   --rm \
   -ti \
   -h "massa" \
   --name "massa_node_$MASSA_VERSION" \
   -e MASSA_PASS="" \
   -e MASSA_ADDRESS="" \
   -p 31244:31244 \
   -p 31245:31245 \
   -p 31248:31248 \
   dex2build/massa-node:$MASSA_VERSION


MASSA_VERSION="MAIN.2.4"; \
docker container exec \
   -e MASSA_PASS="" \
   -ti \
   massa_node_$MASSA_VERSION \
   ./massa-client.sh


N12g56nq3GUEagHm8PjL1ff6fBFbAoGjZXPfDUKSCeNZbQyzmD8Z
