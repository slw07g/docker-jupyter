#from ubuntu:20.04
from --platform=arm64 ubuntu:latest
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt update && \
  apt upgrade -y && \
  apt install -y \
  python3 \
  python3-pip \
  libssl-dev \
  libffi-dev  && \
  ln -snf /usr/share/zoneinfo/$(curl https://ipapi.co/timezone) /etc/localtime
RUN export DEBIAN_FRONTEND=noninteractive && \
  pip3 install \
  jupyter \
  pyarrow \
  qgrid \
  pandas \
  ip2asn \
  pycryptodome && \
  jupyter nbextension enable --py --sys-prefix qgrid && \
  jupyter nbextension enable --py --sys-prefix widgetsnbextension
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
