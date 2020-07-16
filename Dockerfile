FROM alpine:latest

ENV LANG="en_US.UTF-8" LANGUAGE="en_US:ja" LC_ALL="en_US.UTF-8"

RUN apk update
RUN apk upgrade
RUN apk add --update curl git gcc g++ make
RUN apk add --update neovim

# install python
RUN apk add --update python2 python2-dev python3 python3-dev
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python
RUN curl -kL https://bootstrap.pypa.io/get-pip.py | python3

RUN python -m pip install --upgrade pip
RUN python -m pip install pynvim
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install pynvim

# install nodejs
RUN apk add --update nodejs npm
RUN npm install -g neovim

# install ruby
RUN apk add --update ruby ruby-dev
RUN gem install neovim

# install dein.vim
RUN curl -sf https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
RUN sh ./installer.sh ~/.cache/dein
RUN rm ./installer.sh

COPY nvim /root/.config/nvim
RUN nvim -c "call dein#install()" -c UpdateRemotePlugins -c q!
