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
    
    // Get user by useremail and userpassword.
    
    public User getUserByEmailAndPassword (String email, String password){
        User user=null;
        
        try {
            String query="SELECT *FROM user WHERE email=? AND password=?";
            
            PreparedStatement pstmt=this.con.prepareStatement(query);
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            ResultSet set=pstmt.executeQuery();
            
            
            if(set.next())
            {
                user=new User();
                
                String name=set.getString("name");      // Getting the details from the database.
                user.setName(name);                     // Setting the details in the user object.
                
                user.setId(set.getInt("id"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
                user.setAbout(set.getString("about"));
                user.setRdate(set.getTimestamp("rdate"));
                user.setProfile(set.getString("profile"));
            }else{
                
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return user;
    }

    // Method to update the details of the user.
    
    public boolean updateUser(User user)
    {
        boolean f=false;
        
        try {
            String query="UPDATE user SET name=? , email=? , password=? , about=? , profile=? WHERE id=?";
            
            PreparedStatement pstmt=con.prepareStatement(query);
            
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getAbout());
            pstmt.setString(5, user.getProfile());
            pstmt.setInt(6, user.getId());
            
            pstmt.executeUpdate();
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    // Method to get the username by post id.
    public User getUserByPostId(int postId) {
        User user=null;
        String query = "SELECT * FROM user INNER JOIN posts ON posts.userId=user.id WHERE pid=?";
        
        // Fetch the user by post id.
        try {
            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, postId);
            
            ResultSet set = pstmt.executeQuery();
            
            if (set.next()) {
                int id = set.getInt("id");
                String name = set.getString("name");
                String email = set.getString("email");
                String password = set.getString("password");
                String gender = set.getString("gender");
                String about = set.getString("about");                
                Timestamp rdate = set.getTimestamp("rdate");
                
                user =new User(id,name,email,password,gender,about,rdate);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
