FROM ubuntu:18.04

ARG TERRAFORM_VERSION=0.12.19_linux_amd64
ARG TERRAFORM_MD5=fa51a06674389ffa3457cacb34689a74

ARG ENVCHAIN_VERSION=1.0.1
ARG ENVCHAIN_MD5=7ef354d9dd4955b70856fa15889030cf

RUN apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install -y awscli unzip wget gnome-keyring gcc make libreadline-dev libsecret-1-dev

RUN wget https://releases.hashicorp.com/terraform/0.12.19/terraform_$TERRAFORM_VERSION.zip && \
  test "$(md5sum terraform_$TERRAFORM_VERSION.zip)" = "$TERRAFORM_MD5  terraform_$TERRAFORM_VERSION.zip" && \
  unzip terraform_$TERRAFORM_VERSION.zip && \
  rm terraform_$TERRAFORM_VERSION.zip && \
  mv terraform /usr/local/bin/

RUN wget https://github.com/sorah/envchain/archive/v$ENVCHAIN_VERSION.zip && \
  test "$(md5sum v$ENVCHAIN_VERSION.zip)" = "$ENVCHAIN_MD5  v$ENVCHAIN_VERSION.zip" && \
  unzip v$ENVCHAIN_VERSION.zip && \
  rm v$ENVCHAIN_VERSION.zip && \
  cd envchain-$ENVCHAIN_VERSION/ && \
  make && \
  mv envchain /usr/local/bin && \
  cd .. && \
  rm -rf envchain-$ENVCHAIN_VERSION/

RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y ruby bundler ruby-dev

CMD ["bash"]
