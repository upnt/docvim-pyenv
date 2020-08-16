FROM alpine:latest
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"
RUN apk update && \
    apk add --update --no-cache --virtual .builddeps git \
            build-base libffi-dev openssl-dev \
            bzip2-dev zlib-dev readline-dev sqlite-dev && \
    apk add --update --no-cache bash \
            ruby-dev nodejs npm && \
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
SHELL ["/bin/bash", "-c"]
RUN source ~/.bashrc && \
# install neovim
#automake autoconf pcre-dev openssl-dev outils-md5 wget unzip
            #gettext-dev
# install python2
    pyenv install 2.7.18 && \
    pyenv virtualenv 2.7.18 neovim2 && \
    pyenv activate neovim2 && \
    pip2 install -U pip && \
    pip2 install pynvim && \
# install python3
    pyenv install 3.8.5 && \
    pyenv virtualenv 3.8.5 neovim3 && \
    pyenv activate neovim3 && \
    pip3 install -U pip && \
    pip3 install pynvim && \
# install neovim
    git clone https://github.com/neovim/neovim.git -b nightly --depth 1 && \
    cd neovim && \
    make && \
    make install && \
    cd ../ && \
# remove
    rm -rf neovim && \
    apk del --purge .builddeps
