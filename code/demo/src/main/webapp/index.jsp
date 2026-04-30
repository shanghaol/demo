<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理系统</title>
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
        .section {
            margin-bottom: 30px;
            padding: 25px;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            background: #f9f9f9;
            transition: all 0.3s ease;
        }
        .section:hover {
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
            transform: translateY(-2px);
        }
        h3 {
            color: #555;
            margin-bottom: 20px;
            font-size: 1.4em;
        }
        input, select {
            padding: 12px;
            margin: 8px 0;
            width: 100%;
            border: 2px solid #ddd;
            border-radius: 8px;
            font-size: 16px;
            transition: border-color 0.3s ease;
            box-sizing: border-box;
        }
        input:focus, select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
        }
        button {
            padding: 12px 30px;
            background: linear-gradient(45deg, #667eea, #764ba2);
            color: white;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s ease;
            width: 100%;
            margin-top: 10px;
        }
        button:hover {
            background: linear-gradient(45deg, #5a6fd8, #6a4190);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>用户管理系统</h2>
        <hr>

        <!-- 1. 带变量查询（分别用 Statement 和 PreparedStatement） -->
        <div class="section">
            <h3>1. 按 ID 查询用户</h3>
            <form action="query.jsp" method="post">
                <div class="form-group">
                    <label for="query-id">用户 ID:</label>
                    <input type="text" id="query-id" name="id" required placeholder="请输入用户ID">
                </div>
                <button type="submit">查询</button>
            </form>
        </div>

        <!-- 2. 增删改功能 -->
        <div class="section">
            <h3>2. 数据操作</h3>
            <form action="update.jsp" method="post">
                <div class="form-group">
                    <label for="action">操作类型:</label>
                    <select id="action" name="action">
                        <option value="add">添加用户</option>
                        <option value="update">修改用户</option>
                        <option value="delete">删除用户</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="user-id">用户 ID:</label>
                    <input type="text" id="user-id" name="id" placeholder="删除/修改时必填">
                </div>
                <div class="form-group">
                    <label for="user-name">用户姓名:</label>
                    <input type="text" id="user-name" name="name" placeholder="添加/修改时必填">
                </div>
                <div class="form-group">
                    <label for="user-age">用户年龄:</label>
                    <input type="text" id="user-age" name="age" placeholder="添加/修改时必填">
                </div>
                <button type="submit">执行操作</button>
            </form>
        </div>
    </div>
</body>
</html>