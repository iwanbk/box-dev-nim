FROM iwanbk/box-dev-ubuntu1604
MAINTAINER Iwan Budi Kusnanto <iwanbk@gmail.com>
RUN cd && \
	wget http://nim-lang.org/download/nim-0.15.2.tar.xz && \
	tar xf nim-0.15.2.tar.xz && \
	mv nim-0.15.2 nim && \
	cd nim && \
	sh build.sh && \
	./bin/nim e install_tools.nims && \

	# vim nim
	cd ~/.vim/bundle && \
	git clone git://github.com/zah/nim.vim.git && \
	git clone https://github.com/scrooloose/syntastic.git
