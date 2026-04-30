package com.example;

import java.sql.*;

public class DBUtil {
    // 数据库连接配置（请根据你的 MySQL 修改密码）
    private static final String URL = "jdbc:mysql://localhost:3306/test?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "yhnt";
    private static final String PWD = "123456"; // 改成你的 MySQL root 密码

    // 1. 加载驱动（静态代码块，只执行一次）
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    // 2. 获取数据库连接
    public static Connection getConn() throws SQLException {
        return DriverManager.getConnection(URL, USER, PWD);
    }

    // 3. 释放资源
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}