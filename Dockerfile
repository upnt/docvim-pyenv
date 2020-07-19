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
# install dein.vim
    curl -sf https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh && \
    sh ./installer.sh ~/.cache/dein && \
# remove
    rm ./installer.sh && \
    apk del --purge .builddeps

COPY nvim /root/.config/nvim
RUN nvim -c "call dein#install()" -c UpdateRemotePlugins -c q!

COPY .bashrc /root/.bashrc
COPY .bash_aliases /root/.bash_aliases
COPY bin /usr/local/bin

ENTRYPOINT ["nvim"]