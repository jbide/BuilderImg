FROM centos:7

MAINTAINER JY BIDE

#LABEL io.k8s.description="Dashboard of resources from multiple OpenShift projects" \
#      io.k8s.display-name="OpenShift Dashboard" \
#      io.openshift.tags="openshift,dashboard"

ENV PATH=/oc-tool/:$PATH

#COPY . /go/src/github.com/vbehar/openshift-dashboard/

COPY requirements.txt /tmp

RUN yum -y install epel-release

RUN yum -y install ansible
RUN yum -y install python python-pip python-setuptools python-passlib
RUN yum -y install wget curl rsync zip unzip vim jq tree

RUN yum -y install openssh-clients

#RUN yum -y install docker-ce
#RUN usermod -aG docker $(whoami)
#RUN systemctl enable docker.service

RUN pip install --upgrade pip
RUN pip install virtualenv

RUN virtualenv py3
RUN source /py3/bin/activate && pip install -r /tmp/requirements.txt

ARG occlient="openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit"
RUN wget https://github.com/openshift/origin/releases/download/v3.10.0/${occlient}.tar.gz
RUN tar xvfz ${occlient}.tar.gz
RUN mv ${occlient} /oc-tool
RUN chmod  777 -R /oc-tool
RUN rm ${occlient}.tar.gz

ARG terraform_version=0.12.10
RUN wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip
RUN unzip ./terraform_${terraform_version}_linux_amd64.zip -d /usr/local/bin/

ARG packer_version=1.4.4
RUN wget https://releases.hashicorp.com/packer/${packer_version}/packer_${packer_version}_linux_amd64.zip
RUN unzip ./packer_${packer_version}_linux_amd64.zip -d /usr/local/bin/


EXPOSE 8080

USER 1001

CMD [ "cat" ]