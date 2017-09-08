#!/bin/bash

DIR="$( cd "$( dirname "$BASH_SOURCE[0]" )" && pwd )"
cd "$DIR"

URL=`wget -O- https://github.com/hlandau/acme/releases/latest | grep linux_amd64 | grep href | awk -F '"' '{print $2}' | head -1`
VER=`echo $URL | awk -F'-' '{print $2}'`
IMG=sempr/acmetool
echo $VER
docker pull $IMG:$VER

if [ $? -eq 0 ]; then
    echo "image existed"
    exit 0
fi

wget -O acmetool.tgz https://github.com${URL}
tar xvzf acmetool.tgz --strip 1
docker build -t ${IMG}:${VER} .
docker push ${IMG}:${VER}

