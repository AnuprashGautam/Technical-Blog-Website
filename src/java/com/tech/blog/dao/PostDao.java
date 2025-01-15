package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;

public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list=new ArrayList<>();
        
        try {
            String query="SELECT * FROM categories";
            
            Statement stmt=this.con.createStatement();
            ResultSet set=stmt.executeQuery(query);
            
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                
                Category c=new Category(cid,name,description);
                
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    // Method to save the post in the databse.
    
    public boolean savePost(Post p)
    {
        boolean f=false;
        try {
            String query="INSERT INTO posts(pTitle,pContent,pCode,pPic,catId,userId) VALUES (?,?,?,?,?,?)";
            
            PreparedStatement pstmt=con.prepareStatement(query);
            
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());
            
            pstmt.executeUpdate();
            
            f=true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
}
