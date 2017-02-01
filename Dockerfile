FROM iwanbk/box-dev-ubuntu1604
MAINTAINER Iwan Budi Kusnanto <iwanbk@gmail.com>
RUN cd && \
	wget https://nim-lang.org/download/nim-0.16.0.tar.xz && \
	tar xf nim-0.16.0.tar.xz  && \
	mv nim-0.16.0 nim && \
	cd nim && \
	sh build.sh && \
	./bin/nim c koch && \
	mv koch ./bin/ && \
	./bin/koch tools && \

	# vim nim
	cd ~/.vim/bundle && \
	git clone git://github.com/zah/nim.vim.git && \
	git clone https://github.com/scrooloose/syntastic.git

#env variables
ADD bashrc /tmp
RUN cat /tmp/bashrc >> ~/.bashrc
RUN rm /tmp/bashrc
ENV PATH=$PATH:~/nim/bin/

# install packages
RUN cd && \
    ~/nim/bin/nimble install -y c2nim jester

# install vim with py2
RUN apt-get update && apt-get install -y vim-nox-py2 && \
    update-alternatives --set vim /usr/bin/vim.nox-py2
