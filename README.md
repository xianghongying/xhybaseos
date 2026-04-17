## 基础介绍
### 文件介绍
本仓库存储个人使用的基于各类系统所构建的容器镜像所需的原始dockerfile。

## 构建方式
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

### Alpine 3.23

构建方式如下；
```shell
cd alpine3.23.4

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhyalpine:3.23 \
    --push .
```

### Nginx

构建方式如下：
```shell
cd nginx1.30

docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhynginx:1.30.0-alpine \
    --push .
```
