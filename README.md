# MASSA Blockchain Node - Docker Container

The MASSA blockchain node can be launched with a single command using the Docker containerization technology.

**Important!** Before proceeding further, make sure that Docker is installed on your server.

More details here: https://www.docker.com/get-started/

Link to Docker repository: https://hub.docker.com/r/dex2build/massa-node

# Simple one-line launch:

## Starting the node

    MASSA_VERSION="MAIN.2.4"; \
    docker container run \
    -d \
    -h "massa" \
    --name "massa_node_$MASSA_VERSION" \
    --restart always \
    -e MASSA_PASS="MySuperPass" \
    -e MASSA_ADDRESS="12.34.56.78" \
    -p 31244:31244 \
    -p 31245:31245 \
    -p 31248:31248 \
    -p 33035:33035 \
    -p 33037:33037 \
    dex2build/massa-node:$MASSA_VERSION

`MASSA_PASS` - Specify your own password or leave this variable empty so that the container generates and remembers a random password

`MASSA_ADDRESS` - Specify your external address so that your node is a full member of the network


## Using the MASSA client to configure the node

    MASSA_VERSION="MAIN.2.4"; \
    docker container exec \
    -ti \
    massa_node_$MASSA_VERSION \
    ./massa-client.sh

## Access to the host shell

    MASSA_VERSION="MAIN.2.4"; \
    docker container exec \
    -ti \
    massa_node_$MASSA_VERSION \
    bash


# Expert mode:

### Clone repository
    git clone https://github.com/dex2code/massa-docker.git ./massa-docker \\
    cd massa-docker

### Build image

    MASSA_VERSION="MAIN.2.4"; \
    docker image build \
    --build-arg MASSA_VERSION="$MASSA_VERSION" \
    -t "dex2build/massa-node:$MASSA_VERSION" \
    .

### Create container

    MASSA_VERSION="MAIN.2.4"; \
    docker container create \
    -h "massa" \
    --name "massa_node_$MASSA_VERSION" \
    --restart always \
    -e MASSA_PASS="MySuperPass" \
    -e MASSA_ADDRESS="12.34.56.78" \
    -p 31244:31244 \
    -p 31245:31245 \
    -p 31248:31248 \
    -p 33035:33035 \
    -p 33037:33037 \
    dex2build/massa-node:$MASSA_VERSION

### Run container

    MASSA_VERSION="MAIN.2.4"; \
    docker container start dex2build/massa-node:$MASSA_VERSION

### Stop container

    MASSA_VERSION="MAIN.2.4"; \
    docker container stop dex2build/massa-node:$MASSA_VERSION

### Remove container

    MASSA_VERSION="MAIN.2.4"; \
    docker container rm dex2build/massa-node:$MASSA_VERSION




