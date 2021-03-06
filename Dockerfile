FROM ubuntu:16.04

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

RUN apt-get update && apt-get install -y wget g++ libtool rsync make python-dev python-numpy python-pip \
    && rm -rf /var/lib/apt/lists/* && pip install --no-cache-dir matplotlib scipy numpy scikit-learn keras tensorflow jupyter metakernel zmq notebook==5.* plaidml-keras plaidbench energyflow
# fastjet
RUN wget http://fastjet.fr/repo/fastjet-3.3.1.tar.gz \
    && tar xzf fastjet-3.3.1.tar.gz && rm fastjet-3.3.1.tar.gz \
    && cd fastjet-3.3.1 \
    && ./configure --prefix=/app && make && make install \
    && cd .. 
# fastjet-contrib
RUN wget http://fastjet.hepforge.org/contrib/downloads/fjcontrib-1.036.tar.gz \
    && tar xzf fjcontrib-1.036.tar.gz && rm fjcontrib-1.036.tar.gz \
    && cd fjcontrib-1.036 \
    && ./configure --fastjet-config=/app/bin/fastjet-config && make && make install \
    && cd .. 
# Pythia
RUN wget http://home.thep.lu.se/~torbjorn/pythia8/pythia8235.tgz \
    && tar xzf pythia8235.tgz && rm pythia8235.tgz \
    && cd pythia8235 \
    && ./configure --prefix=/app && make && make install \
    && cd ..

# Run app.py when the container launches
CMD ["/bin/bash"]
