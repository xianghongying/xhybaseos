<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>K8s Demo App — MySQL + Tomcat</title>
<style>
  body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 40px auto; max-width: 900px; padding: 0 20px; }
  h2 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 8px; }
  table { border-collapse: collapse; width: 100%; margin: 20px 0; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
  th { background: #3498db; color: white; padding: 12px; text-align: left; }
  td { padding: 10px 12px; border-bottom: 1px solid #ecf0f1; }
  tr:hover { background: #f8f9fa; }
  .error { background: #ffeaa7; border-left: 4px solid #fdcb6e; padding: 15px; margin: 15px 0; border-radius: 4px; }
  .info { background: #dfe6e9; padding: 8px 15px; border-radius: 4px; margin: 10px 0; font-size: 14px; color: #636e72; }
  .success { color: #00b894; font-weight: bold; }
</style>
</head>
<body>

<h2>🐳 Kubernetes Demo App — MySQL + Tomcat</h2>

<div class="info">
  Pod: <strong><%= System.getenv("HOSTNAME") != null ? System.getenv("HOSTNAME") : "unknown" %></strong>
  &nbsp;|&nbsp;
  MySQL: <strong><%= System.getenv("MYSQL_SERVICE_HOST") != null ? System.getenv("MYSQL_SERVICE_HOST") : "N/A" %>:<%= System.getenv("MYSQL_SERVICE_PORT") != null ? System.getenv("MYSQL_SERVICE_PORT") : "3306" %></strong>
  &nbsp;|&nbsp;
  JDBC Driver: <strong><%= DriverManager.getDrivers().hasMoreElements() ? DriverManager.getDrivers().nextElement().getClass().getName() : "N/A" %></strong>
</div>

<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

try {
    // 读取环境变量获取 MySQL 地址
    String ip = System.getenv("MYSQL_SERVICE_HOST");
    String port = System.getenv("MYSQL_SERVICE_PORT");
    ip = (ip == null) ? "localhost" : ip;
    port = (port == null) ? "3306" : port;

    String jdbcUrl = "jdbc:mysql://" + ip + ":" + port + "/";

    // JDBC 4.0+ 自动注册驱动，无需 Class.forName
    conn = DriverManager.getConnection(jdbcUrl + "?useSSL=false&allowPublicKeyRetrieval=true", "root", "123456");

    stmt = conn.createStatement();

    // 创建数据库（不存在时）
    stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS HPE_APP DEFAULT CHARSET utf8mb4 COLLATE utf8mb4_general_ci");
    stmt.execute("USE HPE_APP");

    // 创建表（不存在时）
    stmt.executeUpdate(
        "CREATE TABLE IF NOT EXISTS T_USERS (" +
        "  ID INT NOT NULL AUTO_INCREMENT, " +
        "  USER_NAME VARCHAR(100), " +
        "  LEVEL VARCHAR(20), " +
        "  PRIMARY KEY (ID)" +
        ") ENGINE=InnoDB DEFAULT CHARSET=utf8mb4"
    );

    // 插入初始数据（仅当表为空时）
    rs = stmt.executeQuery("SELECT COUNT(*) FROM T_USERS");
    rs.next();
    if (rs.getInt(1) == 0) {
        stmt.executeUpdate("INSERT INTO T_USERS(USER_NAME, LEVEL) VALUES ('小英子', '100')");
        stmt.executeUpdate("INSERT INTO T_USERS(USER_NAME, LEVEL) VALUES ('运维团队', '100')");
        out.println("<p class=\"success\">✅ 数据库初始化完成，已插入演示数据。</p>");
    }

    // 查询全量数据
    rs = stmt.executeQuery("SELECT ID, USER_NAME, LEVEL FROM T_USERS ORDER BY ID");
%>

<h3>📊 用户列表（来自 MySQL 数据库）</h3>
<table>
  <tr><th>ID</th><th>用户名</th><th>等级</th></tr>
<%
    while (rs.next()) {
%>
  <tr>
    <td><%= rs.getInt("ID") %></td>
    <td><%= rs.getString("USER_NAME") %></td>
    <td><%= rs.getString("LEVEL") %></td>
  </tr>
<%
    }
%>
</table>

<%
} catch (SQLException e) {
%>
<div class="error">
  <strong>❌ 数据库连接失败</strong><br>
  错误类型: <%= e.getClass().getSimpleName() %><br>
  错误信息: <%= e.getMessage() %><br>
  <br>
  <strong>排查建议：</strong><br>
  1. 确认 MySQL Service 已创建：<code>kubectl get svc mysql -n demo</code><br>
  2. 确认环境变量已注入：<code>kubectl exec deployment/myweb -n demo -- env | grep MYSQL</code><br>
  3. 确认 MySQL root 密码为 123456<br>
  4. 如果报 SSL 错误，检查 MySQL 是否开启了 SSL<br>
  5. MySQL 日志：<code>kubectl logs deployment/mysql -n demo</code>
</div>
<%
} catch (Exception e) {
%>
<div class="error">
  <strong>❌ 未知错误</strong><br>
  <%= e.getClass().getName() %>: <%= e.getMessage() %>
</div>
<%
} finally {
    try { if (rs != null) rs.close(); } catch (Exception e) {}
    try { if (stmt != null) stmt.close(); } catch (Exception e) {}
    try { if (conn != null) conn.close(); } catch (Exception e) {}
}
%>

<hr>
<p style="color: #b2bec3; font-size: 12px;">
  K8s Demo App v3.0 | Tomcat 10.1 + JDK 17 + MySQL Connector/J 9.x<br>
  Support MySQL 8.4+ / 9.x (caching_sha2_password native)
</p>

</body>
</html>
