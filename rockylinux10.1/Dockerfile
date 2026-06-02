#==================== 配置基础信息 ====================
FROM js.linuxsb.com/rockylinux/rockylinux:10.1
# 设置时区为亚洲/上海（东八区 UTC+8）
ENV TZ=Asia/Shanghai

#==================== 配置镜像信息 ====================
LABEL org.opencontainers.image.title="xhybaseos-rockylinux10.1" \
      org.opencontainers.image.description="Rocky Linux 10.1 OS Image (RHEL 10 Compatible)" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="xhy"

#==================== 替换 Rocky 原生仓库为国内源 ====================
RUN sed -e 's|^mirrorlist=|#mirrorlist=|g' \
        -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' \
        -i.bak \
        /etc/yum.repos.d/rocky-*.repo

#==================== 安装 EPEL 并替换为国内源 ====================
RUN dnf install -y --setopt=install_weak_deps=False \
        epel-release && \
    sed -e 's|^metalink=|#metalink=|g' \
        -e 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|g' \
        -i.bak \
        /etc/yum.repos.d/epel*.repo

#==================== 安装常用工具 ====================
RUN dnf install -y --setopt=install_weak_deps=False \
        bash-completion \
        bind-utils \
        bzip2 \
        ca-certificates \
        curl \
        diffutils \
        file \
        findutils \
        htop \
        iproute \
        iputils \
        jq \
        less \
        lsof \
        net-tools \
        nmap-ncat \
        openssh-clients \
        procps-ng \
        tar \
        traceroute \
        tree \
        unzip \
        vim-enhanced \
        wget \
        xz \
        zip \
    && dnf clean all \
    && rm -rf /var/cache/dnf/*

#==================== 配置环境信息 ====================
RUN curl -fsSL https://down.linuxsb.com/myoptions/myshellinit/my_Bashrc_Diy01_v1 \
        >> /etc/profile.d/custom_bash.sh \
    && curl -fsSL -o /root/.vimrc \
        https://down.linuxsb.com/myoptions/myshellinit/my_Vimrc_Diy01_v1 \
    && chmod 644 /etc/profile.d/custom_bash.sh \
    && chmod 644 /root/.vimrc

#==================== 配置登录信息 ====================
RUN echo 'source /etc/profile.d/custom_bash.sh' >> /root/.bashrc
WORKDIR /root
CMD ["/bin/bash", "-l"]
