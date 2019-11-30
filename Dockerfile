FROM balenalib/rpi-raspbian:jessie-20190619

RUN apt-get update && \
	apt-get -qy install \
        alsa-utils \
        bison \
        build-essential \
        flex \
        git \
        libasound2-dev \
        libav-tools \
        libjack-jackd2-0 \
        libmp3lame0 \
        libpulse0 \
        libsamplerate0 \
        libsndfile1-dev \
        libtwolame0 \
        make

RUN git clone https://github.com/ccrma/chuck.git
RUN cd chuck/src && make linux-alsa && sudo make install && cd -

RUN git clone https://github.com/ccrma/chugins.git
RUN cd chugins && make linux-alsa && sudo make install && cd -

RUN git clone https://github.com/concrete-mixer/flush-tones.git
COPY audio /flush-tones

CMD cd /flush-tones && /bin/perl ./init.pl
