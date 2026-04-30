<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>查询结果</title>
    <style>
        body {
            font-family: "Microsoft YaHei", "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.1);
            max-width: 800px;
            width: 100%;
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            background: linear-gradient(45deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }
        hr {
            border: none;
            height: 2px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            margin: 20px 0;
        }
        .result {
            margin: 20px 0;
            padding: 25px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            background: #f9f9f9;
            transition: all 0.3s ease;
        }
        .result:hover {
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        .success {
            color: #28a745;
            font-weight: bold;
        }
        .error {
            color: #dc3545;
            font-weight: bold;
        }
        a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
            padding: 10px 20px;
            background: #f0f0f0;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: inline-block;
            margin-bottom: 20px;
        }
        a:hover {
            background: #667eea;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        h3 {
            color: #555;
            margin-bottom: 15px;
            font-size: 1.4em;
        }
        p {
            margin: 10px 0;
            line-height: 1.6;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>查询结果</h2>
        <a href="index.jsp">返回主页面</a>
        <hr>

    <%
        // 1. 设置请求编码，避免中文乱码
        request.setCharacterEncoding("UTF-8");

        // 2. 获取用户输入的 ID
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        Connection conn = null;
        ResultSet rs = null;
    %>

    <!-- 方式1：使用 Statement（SQL 拼接，存在注入风险，仅作对比） -->
    <div class="result">
        <h3>Statement</h3>
        <%
            Statement stmt = null;
            try {
                conn = DBUtil.getConn();
                stmt = conn.createStatement();

                // ❌ SQL 拼接（不安全，如输入 1 OR 1=1 会查询所有数据）
                String sql = "SELECT * FROM user WHERE id = " + id;
                rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    out.println("<p class='success'>查询成功！</p>");
                    out.println("<p>ID: " + rs.getInt("id") + "</p>");
                    out.println("<p>姓名: " + rs.getString("name") + "</p>");
                    out.println("<p>年龄: " + rs.getInt("age") + "</p>");
                } else {
                    out.println("<p class='error'>未找到 ID 为 " + id + " 的用户</p>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>查询失败：" + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                DBUtil.close(conn, stmt, rs);
            }
        %>
    </div>

    <!-- 方式2：使用 PreparedStatement（预编译，防注入，推荐） -->
    <div class="result">
        <h3>PreparedStatement</h3>
        <%
            PreparedStatement pstmt = null;
            try {
                conn = DBUtil.getConn();

                // ✅ 使用 ? 占位符，预编译 SQL，安全且性能高
                String sql = "SELECT * FROM user WHERE id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id); // 设置第一个 ? 的值为 id
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    out.println("<p class='success'>查询成功！</p>");
                    out.println("<p>ID: " + rs.getInt("id") + "</p>");
                    out.println("<p>姓名: " + rs.getString("name") + "</p>");
                    out.println("<p>年龄: " + rs.getInt("age") + "</p>");
                } else {
                    out.println("<p class='error'>未找到 ID 为 " + id + " 的用户</p>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>查询失败：" + e.getMessage() + "</p>");
                e.printStackTrace();
            } finally {
                DBUtil.close(conn, pstmt, rs);
            }
        %>
    </div>
    </div>
</body>
</html>