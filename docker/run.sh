#!/bin/bash

docker run --name vision \
  --network host \
  --rm \
  -d \
  vision:foxy-amd