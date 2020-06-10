FROM jenkins/inbound-agent:latest
USER root
RUN sed -i 's#http://deb.debian.org#http://mirrors.aliyun.com#g' /etc/apt/sources.list \
    && sed -i 's#http://security.debian.org#http://mirrors.aliyun.com#g' /etc/apt/sources.list \
    && sed -i 's#http://deb.debian.org#http://mirrors.aliyun.com#g' /etc/apt/sources.list.d/* \
    && sed -i 's#http://security.debian.org#http://mirrors.aliyun.com#g' /etc/apt/sources.list.d/* \
    && apt-get -y update \
    && apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common \
    && curl -fsSL http://mirrors.aliyun.com/docker-ce/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/docker-ce/linux/debian $(lsb_release -cs) stable" \
    && curl -fsSL http://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] http://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main" \
    && apt-get -y update \
    && apt-get -y install docker-ce docker-ce-cli containerd.io kubectl
USER ${user}
