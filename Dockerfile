FROM openshift/origin-base

MAINTAINER JY BIDE

#LABEL io.k8s.description="Dashboard of resources from multiple OpenShift projects" \
#      io.k8s.display-name="OpenShift Dashboard" \
#      io.openshift.tags="openshift,dashboard"

ENV PATH=/oc-tool/:$PATH

#COPY . /go/src/github.com/vbehar/openshift-dashboard/

ARG occlient="openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit"
RUN wget https://github.com/openshift/origin/releases/download/v3.10.0/${occlient}.tar.gz
RUN tar xvfz ${occlient}.tar.gz
RUN mv ${occlient} /oc-tool
RUN chmod  777 -R /oc-tool
RUN rm ${occlient}.tar.gz

#EXPOSE 8080

CMD [ "cat" ]