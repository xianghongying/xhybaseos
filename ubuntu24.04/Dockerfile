#==================== 配置基础信息 ====================
FROM docker.1ms.run/library/ubuntu:24.04

# 避免交互式提示阻塞构建
ARG DEBIAN_FRONTEND=noninteractive

# 设置时区为亚洲/上海（东八区 UTC+8）
ENV TZ=Asia/Shanghai

#==================== 配置镜像信息 ====================
LABEL org.opencontainers.image.title="xhybaseos-ubuntu24.04" \
      org.opencontainers.image.description="Ubuntu 24.04 LTS (Resolute Raccoon) Base OS Image" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="xhy"

#==================== 安装证书校验 ====================
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

#==================== 配置国内仓库 ====================
ARG TARGETARCH

# 设置阿里云源
RUN set -eux; \
    . /etc/os-release; echo "OS=${ID} VERSION=${VERSION_CODENAME} ARCH=${TARGETARCH}"; \
    if [ "${TARGETARCH}" = "amd64" ]; then \
      UBUNTU_URI="https://mirrors.aliyun.com/ubuntu"; \
    else \
      # arm64/armhf 等走 ports
      UBUNTU_URI="https://mirrors.aliyun.com/ubuntu-ports"; \
    fi; \
    cat > /etc/apt/sources.list.d/ubuntu.sources <<EOF
Types: deb
URIs: ${UBUNTU_URI}
Suites: resolute resolute-updates resolute-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: ${UBUNTU_URI}
Suites: resolute-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF

#==================== 安装常用工具 ====================
RUN apt-get update && apt-get install -y --no-install-recommends \
    bind9-dnsutils \
    bzip2 \
    curl \
    diffutils \
    findutils \
    htop \
    iputils-ping \
    iproute2 \
    jq \
    less \
    lsof \
    net-tools \
    netcat-openbsd \
    procps \
    tar \
    traceroute \
    tree \
    unzip \
    vim \
    wget \
    zip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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
