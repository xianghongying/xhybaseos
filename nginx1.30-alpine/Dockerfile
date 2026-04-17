#==================== 配置基础信息 ====================
FROM docker.1ms.run/library/nginx:1.30.0-alpine

# 设置时区为亚洲/上海（东八区 UTC+8）
ENV TZ=Asia/Shanghai

#==================== 配置镜像信息 ====================
LABEL org.opencontainers.image.title="xhybaseos-alpine:3.23.4" \
      org.opencontainers.image.description="Alpine:3.23.4 Base OS Image" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="xhy"

# 设置阿里云源
RUN cat > /etc/apk/repositories <<EOF
https://mirrors.aliyun.com/alpine/v3.23/main
https://mirrors.aliyun.com/alpine/v3.23/community
EOF

RUN mkdir -p ~/.pip
RUN cat > ~/.pip/pip.conf <<EOF
[global]
index-url = http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=mirrors.aliyun.com
EOF

#==================== 安装常用工具 ====================
RUN RUN set -eux; \
    apk update && apk add --no-cache \
    bash \
    bind-tools \
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
    procps-ng \
    tar \
    traceroute \
    tree \
    unzip \
    vim \
    wget \
    zip \
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
COPY ./nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
