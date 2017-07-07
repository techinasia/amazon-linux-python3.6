FROM amazonlinux:2017.03

ENV PYSHORT 3.6
ENV PYTHONVER 3.6.1
ENV MD5CHECKSUM 2d0fc9f3a5940707590e07f03ecb08b9

RUN yum -y groupinstall "Development tools"
RUN yum -y install zlib-devel
RUN yum -y install bzip2-devel openssl-devel ncurses-devel
RUN yum -y install sqlite sqlite-devel xz-devel
RUN yum -y install readline-devel tk-devel gdbm-devel db4-devel
RUN yum -y install libpcap-devel xz-devel
RUN yum -y install libjpeg-devel
RUN yum -y install wget

WORKDIR /tmp

RUN wget --no-check-certificate https://www.python.org/ftp/python/${PYTHONVER}/Python-${PYTHONVER}.tgz
RUN tar -zxvf Python-${PYTHONVER}.tgz

WORKDIR /tmp/Python-${PYTHONVER}
RUN ./configure --prefix=/usr/local LDFLAGS="-Wl,-rpath /usr/local/lib" --with-ensurepip=install
RUN make && make altinstall
RUN pip3.6 install virtualenv

WORKDIR /root
RUN rm -r /tmp/Python-${PYTHONVER}
