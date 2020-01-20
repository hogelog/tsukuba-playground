FROM ubuntu:18.04

RUN apt-get update && \
  env DEBIAN_FRONTEND=noninteractive apt-get install -y wget unzip awscli gcc make ruby ruby-dev bundler

ARG TERRAFORM_VERSION=0.12.19
ARG TERRAFORM_ZIP=terraform_${TERRAFORM_VERSION}_linux_amd64.zip
ARG TERRAFORM_MD5=fa51a06674389ffa3457cacb34689a74

RUN wget -q https://releases.hashicorp.com/terraform/$TERRAFORM_VERSION/$TERRAFORM_ZIP && \
  test "$(md5sum $TERRAFORM_ZIP)" = "$TERRAFORM_MD5  $TERRAFORM_ZIP" && \
  unzip $TERRAFORM_ZIP && \
  rm $TERRAFORM_ZIP && \
  mv terraform /usr/local/bin/

CMD ["bash"]
