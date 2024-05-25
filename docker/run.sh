#!/bin/bash

docker run --name vision \
  --network host \
  --rm \
  -d \
  vision_foxy:amd