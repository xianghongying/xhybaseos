## 基础介绍

### 文件介绍
本仓库存储个人使用的基于各类系统所构建的容器镜像所需的原始dockerfile。

## 构建方式

### Alpine 3.23

构建方式如下；

```shell
cd alpine3.23.4

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyalpine:3.23.4 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name alpinedocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyalpine:3.23.4
```

### Alpine 3.24

构建方式如下；

```shell
cd alpine3.24.1

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyalpine:3.24.1 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name alpinedocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyalpine:3.24.1
```

### Debianbookworm

构建方式如下；

```shell
cd debianbookworm

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhydebian:bookworm-slim \
    --push .
```

运行测试：

```shell
docker run -it --rm --name debiandocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhydebian:bookworm-slim
```

### Apache

构建方式如下：

```shell
cd httpd2.4-alpine

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyhttpd:2.4.68-alpine3.24 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name httpddocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyhttpd:2.4.68-alpine3.24
```

### Nginx 1.30

构建方式如下：
```shell
cd nginx1.30

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhynginx:1.30.0-alpine3.23 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name nginxdocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhynginx:1.30.0-alpine3.23
```

### Nginx 1.31

构建方式如下：
```shell
cd nginx1.31

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhynginx:1.31.2-alpine3.23 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name nginxdocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhynginx:1.31.2-alpine3.23
```

### Python3

构建方式如下：
```shell
cd python3.14.4-alpine

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhypython:3.14-alpine3.24 \
    --push .
```
运行测试：

```shell
docker run -it --rm --name pythondocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhypython:3.14-alpine3.24
```

### Redis8.8

构建方式如下：
```shell
cd redis8.8-alpine

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyredis:8.8.0-alpine3.23 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name pythondocker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyredis:8.8.0-alpine3.23
```

### Rockylinux:10.1

构建方式如下：
```shell
cd rockylinux10.1

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyrockylinux:10.1 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name rocky10docker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyrockylinux:10.1
```

### Tomcat-app-v3

构建方式如下：
```shell
cd tomcat-appv3

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhytomcat-app:v3.0.0 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name rocky10docker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhytomcat-app:v3.0.0
```

### Ubuntu 24.04

构建方式如下：
```shell
cd ubuntu24.04

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyubuntu:24.04 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name ubuntu24docker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyubuntu:24.04
```

### Ubuntu 26.04

构建方式如下：
```shell
cd ubuntu26.04

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyubuntu:26.04 \
    --push .
```

运行测试：

```shell
docker run -it --rm --name ubuntu26docker registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyubuntu:26.04
```

