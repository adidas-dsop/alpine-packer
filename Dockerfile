FROM dsop/alpine-base
RUN cd /usr/local/bin && \
    wget https://releases.hashicorp.com/packer/0.8.6/packer_0.8.6_linux_amd64.zip && \
    unzip packer_0.8.6_linux_amd64.zip && \
    rm packer_0.8.6_linux_amd64.zip

RUN apk update && \
  apk upgrade && \
  apk add \
    docker@community openrc && \
  rm -rf /var/cache/apk/*

RUN echo "#!/bin/bash" > /usr/local/bin/start-docker && \
    echo "start-stop-daemon -S -b -x /usr/bin/docker  -- daemon" >> /usr/local/bin/start-docker && \
    echo "/bin/bash" >> /usr/local/bin/start-docker && \
    chmod +x /usr/local/bin/start-docker

WORKDIR /work

CMD ["/usr/local/bin/start-docker"]