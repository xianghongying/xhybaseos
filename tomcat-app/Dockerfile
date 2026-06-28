FROM js.linuxsb.com/library/tomcat:10.1.56-jdk21

LABEL maintainer="xhy@itzgr.cn" \
      description="Tomcat Demo App - Modernized version of kubeguide/tomcat-app for MySQL 8.4+/9.x"

# 设置时区为亚洲/上海（东八区 UTC+8）
ENV TZ=Asia/Shanghai

#==================== 配置镜像信息 ====================
LABEL org.opencontainers.image.title="xhytomcat:10.1.56-jdk21" \
      org.opencontainers.image.description="Jdk21 Base OS Image" \
      org.opencontainers.image.version="1.0.0" \
      org.opencontainers.image.authors="xhy"

# 下载最新 MySQL JDBC 驱动（min JDK 17）
ADD https://repo1.maven.org/maven2/com/mysql/mysql-connector-j/9.2.0/mysql-connector-j-9.2.0.jar \
    /usr/local/tomcat/lib/mysql-connector-j-9.2.0.jar

# 删除 Tomcat 自带默认应用（安全加固）
RUN rm -rf /usr/local/tomcat/webapps/ROOT \
           /usr/local/tomcat/webapps/docs \
           /usr/local/tomcat/webapps/examples \
           /usr/local/tomcat/webapps/host-manager \
           /usr/local/tomcat/webapps/manager

# 部署 demo 应用
COPY demo/ /usr/local/tomcat/webapps/demo/

# 暴露 Tomcat 端口
EXPOSE 8080

CMD ["catalina.sh", "run"]
