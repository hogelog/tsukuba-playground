FROM ubuntu:18.04

ARG TERRAFORM_VERSION=0.12.19_linux_amd64
ARG TERRAFORM_MD5=fa51a06674389ffa3457cacb34689a74

RUN apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install -y awscli gcc make ruby ruby-dev bundler

RUN wget https://releases.hashicorp.com/terraform/0.12.19/terraform_$TERRAFORM_VERSION.zip && \
  test "$(md5sum terraform_$TERRAFORM_VERSION.zip)" = "$TERRAFORM_MD5  terraform_$TERRAFORM_VERSION.zip" && \
  unzip terraform_$TERRAFORM_VERSION.zip && \
  rm terraform_$TERRAFORM_VERSION.zip && \
  mv terraform /usr/local/bin/

CMD ["bash"]
