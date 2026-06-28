<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>添加用户 — K8s Demo App</title>
<style>
  body { font-family: 'Segoe UI', sans-serif; margin: 40px auto; max-width: 600px; padding: 0 20px; }
  h2 { color: #2c3e50; }
  form { background: #f8f9fa; padding: 20px; border-radius: 8px; }
  input, select { padding: 8px; margin: 5px 0; width: 100%; box-sizing: border-box; border: 1px solid #ddd; border-radius: 4px; }
  button { background: #3498db; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; margin-top: 10px; }
  button:hover { background: #2980b9; }
  .msg { padding: 10px; margin: 15px 0; border-radius: 4px; }
  .success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
  .error { background: #f8d7da; border: 1px solid #f5c6cb; color: #721c24; }
  a { color: #3498db; }
</style>
</head>
<body>

<h2>➕ 添加用户</h2>

<%
String userName = request.getParameter("user_name");
String level = request.getParameter("level");

if (userName != null && !userName.trim().isEmpty()) {
    Connection conn = null;
    Statement stmt = null;
    try {
        String ip = System.getenv("MYSQL_SERVICE_HOST");
        String port = System.getenv("MYSQL_SERVICE_PORT");
        ip = (ip == null) ? "localhost" : ip;
        port = (port == null) ? "3306" : port;

        conn = DriverManager.getConnection(
            "jdbc:mysql://" + ip + ":" + port + "/HPE_APP?useSSL=false&allowPublicKeyRetrieval=true",
            "root", "123456"
        );

        stmt = conn.createStatement();
        stmt.executeUpdate(
            "INSERT INTO T_USERS(USER_NAME, LEVEL) VALUES ('" +
            userName.replace("'", "''") + "', '" +
            (level != null ? level.replace("'", "''") : "50") + "')"
        );
%>
<div class="msg success">✅ 用户 <strong><%= userName %></strong> 添加成功！</div>
<%
    } catch (SQLException e) {
%>
<div class="msg error">❌ 添加失败: <%= e.getMessage() %></div>
<%
    } finally {
        try { if (stmt != null) stmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
}
%>

<form method="post">
  <label>用户名:</label>
  <input type="text" name="user_name" placeholder="输入用户名" required>
  <label>等级:</label>
  <select name="level">
    <option value="100">100 - 管理员</option>
    <option value="80">80 - 高级用户</option>
    <option value="50">50 - 普通用户</option>
    <option value="20">20 - 访客</option>
  </select>
  <button type="submit">提交</button>
</form>

<p><a href="index.jsp">← 返回用户列表</a></p>

</body>
</html>
