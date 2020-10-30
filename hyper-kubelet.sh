#!/bin/bash

IMAGETAG=$1

CGO_ENABLED=0 GOOS=linux make WHAT="cmd/kubelet"
docker build . -t $IMAGETAG
docker push $IMAGETAG