package com.tech.blog.helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {
        
        try {
            if (con == null) {          // Same connection will be reused everytime, so the resources will be saved.

                // Driver class loading
                Class.forName("com.mysql.jdbc.Driver");

                // Create a connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "haveaniceday");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
