<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, com.example.DBUtil" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作结果</title>
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
            max-width: 600px;
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
        <h2>操作结果</h2>
        <a href="index.jsp">返回主页面</a>
        <hr>

    <%
        // 1. 设置请求编码
        request.setCharacterEncoding("UTF-8");

        // 2. 获取参数
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");

        Connection conn = null;
        PreparedStatement pstmt = null;
        int rows = 0;

        try {
            conn = DBUtil.getConn();
            String sql = "";

            // 3. 根据操作类型选择 SQL
            if ("add".equals(action)) {
                // 添加用户
                sql = "INSERT INTO user(name, age) VALUES(?, ?)";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setInt(2, Integer.parseInt(ageStr));
            } else if ("update".equals(action)) {
                // 修改用户
                sql = "UPDATE user SET name=?, age=? WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, name);
                pstmt.setInt(2, Integer.parseInt(ageStr));
                pstmt.setInt(3, Integer.parseInt(idStr));
            } else if ("delete".equals(action)) {
                // 删除用户
                sql = "DELETE FROM user WHERE id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(idStr));
            }

            // 4. 执行 SQL
            if (pstmt != null) {
                rows = pstmt.executeUpdate();
            }

            // 5. 输出结果
            if (rows > 0) {
    %>
                <div class="result success">
                    <h3>操作成功！</h3>
                    <p>成功影响 <%= rows %> 行数据</p>
                </div>
    <%
            } else {
    %>
                <div class="result error">
                    <h3>操作失败！</h3>
                    <p>请检查输入的参数是否正确（如 ID 是否存在）</p>
                </div>
    <%
            }
        } catch (SQLException e) {
    %>
            <div class="result error">
                <h3>操作失败！</h3>
                <p>错误信息：<%= e.getMessage() %></p>
            </div>
    <%
            e.printStackTrace();
        } finally {
            DBUtil.close(conn, pstmt, null);
        }
    %>
    </div>
</body>
</html>