package com.tech.blog.dao;

import java.sql.*;

import com.tech.blog.entities.User;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // Method to insert user to data base.
    public boolean saveUser(User user) {
        // This method will save the details of user object to the database.
        boolean f=false;
        
        try {
            String query = "INSERT INTO user(name,email,password,gender,about) VALUES (?,?,?,?,?)";
            PreparedStatement pstmt = this.con.prepareStatement(query);

            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
        }
        return f;
    }

}
