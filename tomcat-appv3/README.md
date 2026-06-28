### tomcat-app v3.0 — K8s Demo App

基于《Kubernetes权威指南》tomcat-app 重构的现代化版本。

### 与原版对比

| 组件 | 原版 (v1/v2) | 现代化版 (v3.0) |
|:--|:--|:--|
| JDK | Java 7 (1.7.0_101) | **JDK 17** (Eclipse Temurin) |
| Tomcat | 8.0.35 | **10.1** |
| JDBC 驱动 | mysql-connector-java 5.1.37 (2016) | **mysql-connector-j 9.2.0** (2025) |
| MySQL 兼容 | 仅 5.x/8.0 (mysql_native_password) | **8.0 / 8.4 / 9.x** (caching_sha2_password 原生支持) |
| javax/jakarta | javax.* (已废弃) | **jakarta.*** (现代标准) |
| 页面 | 基础 HTML | 响应式 + 样式优化 + 详细错误提示 |
| 镜像大小 | ~154 MB | ~280 MB (功能更强) |
| SSL | 不兼容 MySQL 8.4+ TLS | 自动协商，兼容 MySQL 8.4+/9.x |

### 构建

```shell
docker buildx build \
    --platform linux/amd64,linux/arm64 \
    --cache-from=type=local,src=/root/.buildx-cache \
    --cache-to=type=local,dest=/root/.buildx-cache,mode=max \
    -t registry.cn-hangzhou.aliyuncs.com/xhyimages/xhytomcat-app:v3.0.0 \
    --push .
```

### K8s 部署

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myweb
  namespace: demo
  labels:
    app: myweb
spec:
  replicas: 2
  selector:
    matchLabels:
      app: myweb
  template:
    metadata:
      labels:
        app: myweb
    spec:
      containers:
      - name: myweb
        image: registry.cn-hangzhou.aliyuncs.com/xhyimages/xhytomcat-app:v3.0.0
        ports:
        - containerPort: 8080
        env:
        - name: MYSQL_SERVICE_HOST
          value: "mysql"
```

**注意**：v3.0 使用现代 JDBC 驱动，MySQL 无需 `--mysql-native-password=ON` 参数，直接用默认 `caching_sha2_password` 即可。
