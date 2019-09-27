FROM ubuntu:cosmic 

MAINTAINER Dobin Rutishauser version: 0.1                                         

EXPOSE 10000/tcp
EXPOSE 10000/udp
EXPOSE 20000/tcp
EXPOSE 20000/udp

RUN apt-get update && \
    apt-get install -y curl git wget clang gdb python python-pip binutils-dev libunwind-dev clang iproute2 vim && \
    git clone https://github.com/uzurpatorius/ffw.git && \
    ( cd ffw && pip install -r requirements.txt ) && \
    ( cd ffw && git clone https://gitlab.com/akihe/radamsa.git && cd radamsa && make OFLAGS=-O1) && \
    ( cd ffw && git clone https://github.com/google/honggfuzz && cd honggfuzz && make ) && \
    ( cd / && git clone https://github.com/dobin/ffw-examples.git ) && \
    ( mkdir /Development; ln -s /ffw /Development/ffw; ln -s /ffw/honggfuzz /Development/honggfuzz; ln -s /ffw-examples /Development/ffw-examples )

WORKDIR /ffw

CMD /bin/bash 
