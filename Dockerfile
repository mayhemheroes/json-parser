# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y gcc

## Add source code to the build stage.
ADD . /json-parser
WORKDIR /json-parser/examples

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN gcc test_json.c ../*.c -I../ -lm -o json-parser

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /json-parser/examples/json-parser /
