FROM alpine:latest
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"
RUN apk update && \
    apk add --update --no-cache git bash curl \
            build-base libffi-dev openssl-dev \
            bzip2-dev zlib-dev readline-dev sqlite-dev \
            neovim neovim-doc \
            ruby-dev nodejs npm && \
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv && \
    git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv && \
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc && \
    echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(pyenv init -)"' >> ~/.bashrc && \
    echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc && \
# setup neovim
    npm install -g neovim && \
    gem install neovim && \
    mkdir ~/.config/nvim && \ 
    echo "let g:python_host_prog='~/.pyenv/versions/py2nvim/bin/python'" >> ~/.config/nvim/init.vim && \
    echo "let g:python3_host_prog='~/.pyenv/versions/py3nvim/bin/python'" >> ~/.config/nvim/init.vim

SHELL ["/bin/bash", "-c"]
RUN source ~/.bashrc && \
# install python2
    pyenv install 2.7.18 && \
    pyenv virtualenv 2.7.18 py2nvim && \
    pyenv activate py2nvim && \
    pip2 install -U pip && \
    pip2 install pynvim && \
    pyenv global 2.7.18 && \
    pip2 install -U pip && \
# install python3
    pyenv install 3.8.5 && \
    pyenv virtualenv 3.8.5 py3nvim && \
    pyenv activate py3nvim && \
    pip3 install -U pip && \
    pip3 install pynvim && \
    pyenv global 3.8.5 && \
    pip3 install -U pip
