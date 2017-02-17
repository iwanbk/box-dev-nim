FROM iwanbk/box-dev-ubuntu1604
MAINTAINER Iwan Budi Kusnanto <iwanbk@gmail.com>

# compile nim
RUN cd && \
	git clone -b v0.16.0 https://github.com/nim-lang/Nim.git nim && \
	cd nim && \
	git clone --depth 1 -b v0.16.0 https://github.com/nim-lang/csources && \
	cd csources && sh build.sh

# install nim tools
RUN cd ~/nim && \
	./bin/nim c koch && \
	./koch boot -d:release && \
	./koch nimble

# vim nim
RUN	cd ~/.vim/bundle && \
	git clone git://github.com/zah/nim.vim.git && \
	git clone https://github.com/scrooloose/syntastic.git

#env variables
ADD bashrc /tmp
RUN cat /tmp/bashrc >> ~/.bashrc
RUN rm /tmp/bashrc
ENV PATH=$PATH:~/nim/bin/

# install packages
RUN cd && \
    ~/nim/bin/nimble install -y c2nim

# install vim with py2
RUN apt-get update && apt-get install -y vim-nox-py2 && \
    update-alternatives --set vim /usr/bin/vim.nox-py2
