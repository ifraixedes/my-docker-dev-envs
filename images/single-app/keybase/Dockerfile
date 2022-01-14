FROM ubuntu:20.04

RUN mkdir /tmp/box-setup
ADD setup-scripts /tmp/box-setup/setup-scripts

RUN cd /tmp/box-setup/setup-scripts \
      && ./00-keybase.sh \
      && apt-get autoremove \
      && apt-get clean

RUN rm -rf /tmp/box-setup
WORKDIR "/home/${USER_NAME}"

CMD ["bash"]
