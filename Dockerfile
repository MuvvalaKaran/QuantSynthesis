From ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt -y install \
    gcc git \
    wget vim curl \
    python3-pip cmake automake \
    build-essential \
    apt-utils flex bison mona ccache


SHELL ["/bin/bash", "-c"] 

ADD ./ /root/QuantSynthesis

# WORKDIR /root/QuantSynthesis

# unzip cudd tar ball
# RUN tar -zxvf cudd-2.5.1.tar.gz
# RUN cd cudd-2.5.1 && make objlib 

# # run the aiger install shell script
# RUN ./install_aiger.sh

# make the project 
# RUN make

ENTRYPOINT "/bin/bash"