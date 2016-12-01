#/bin/bash
set -xe

################################################################################
#                                     APT                                      #
################################################################################


apt-get update
apt-get -yy upgrade
apt-get -yy install build-essential \
                zlib1g-dev          \
                cmake               \
                git                 \
                python              \
                python3-dev         \
                python3-pip         \
                python3-docopt      \
                libtbb2             \
                python3-numpy       \
                wget
apt-get clean
apt-get autoclean
apt-get -yy autoremove
rm -rf /var/lib/apt/lists/*

RUN pip3 install screed==0.9 \
                 snakemake==3.8.2

cd /usr/local/src
wget 
git clone --recursive https://github.com/kdmurray91/axe && \
cd axe &&                                                  \
git checkout 0.3.1 &&                                      \
cmake . &&                                                 \
make && make test && make install &&                       \
cd .. &&                                                   \
rm -rf /usr/local/src/*

ADD http://packages.seqan.de/mason2/mason2-2.0.3-Linux-x86_64.tar.xz /usr/local/src/
RUN tar xvf mason2*.tar* &&                          \
    mv mason2-*-Linux-x86_64/bin/* /usr/local/bin && \
    rm -rf /usr/local/src/mason*

# ADD https://github.com/najoshi/sabre/archive/master.tar.gz /usr/local/src/sabre-master.tar.gz
# RUN tar xvf sabre-*.tar.gz &&               \
#     cd sabre-* &&                           \
#     make &&                                 \
#     mv sabre-master/sabre /usr/local/bin && \
#     rm -rf /usr/local/src/*

ADD https://github.com/seqan/flexbar/releases/download/v2.5.0/flexbar_v2.5_linux64.tgz /usr/local/src/
RUN tar xvf flexbar_*.tgz &&                         \
    mv flexbar_*_linux64/flexbar /usr/local/bin/flexbar && \
    rm -rf /usr/local/src/flexbar*

RUN git clone https://github.com/kdmurray91/axe-experiments /experiments
WORKDIR /experiments
CMD snakemake