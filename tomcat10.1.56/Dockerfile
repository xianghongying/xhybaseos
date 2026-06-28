#==================== 配置基础信息 ====================
FROM js.linuxsb.com/library/tomcat:10.1.56-jre25

# 设置时区为亚洲/上海（东八区 UTC+8）
ENV TZ=Asia/Shanghai

# 避免交互式提示阻塞构建
ARG DEBIAN_FRONTEND=noninteractive

#==================== 配置镜像信息 ====================
LABEL org.opencontainers.image.title="xhytomcat:10.1.56-jre25" \
      org.opencontainers.image.description="Ubuntu 24.04 LTS (noble Numbat) Base OS Image" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="xhy"

#==================== 修复 GPG 密钥环 ====================
RUN rm -rf /etc/apt/trusted.gpg.d /usr/share/keyrings/ubuntu-archive-keyring.gpg && \
    apt-get update -o Acquire::AllowInsecureRepositories=true && \
    apt-get install -y --allow-unauthenticated --no-install-recommends ca-certificates wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget -qO /usr/share/keyrings/ubuntu-archive-keyring.gpg \
        http://archive.ubuntu.com/ubuntu/project/ubuntu-archive-keyring.gpg && \
    apt-get update && \
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
Suites: noble noble-updates noble-backports
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg

Types: deb
URIs: ${UBUNTU_URI}
Suites: noble-security
Components: main restricted universe multiverse
Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
EOF

#==================== 安装常用工具 ====================
RUN apt-get update && apt-get install -y --no-install-recommends \
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
        https://down.linuxsb.com/myoptions/myshellinit/my_Vimrc_Diy01_v2 \
    && chmod 644 /etc/profile.d/custom_bash.sh \
    && chmod 644 /root/.vimrc

#==================== 配置登录信息 ====================
RUN echo 'source /etc/profile.d/custom_bash.sh' >> /root/.bashrc
