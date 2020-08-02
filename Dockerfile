FROM alpine:latest
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

# install neovim
RUN apk update && \
    apk add --update --no-cache --virtual .builddeps curl gcc musl-dev linux-headers make && \
    apk add --update --no-cache bash neovim git \
            python2-dev python3-dev \
            nodejs npm ruby-dev && \
# setup neovim
    curl -kL https://bootstrap.pypa.io/get-pip.py | python && \
    curl -kL https://bootstrap.pypa.io/get-pip.py | python3 && \
    python -m pip install pynvim && \
    python3 -m pip install pynvim neovim-remote && \
    npm install -g neovim && \
    gem install neovim && \
# remove
    apk del --purge .builddeps

COPY .bashrc /root/.bashrc
COPY .bash_aliases /root/.bash_aliases
COPY bin /usr/local/bin

ENTRYPOINT ["nvim"]
