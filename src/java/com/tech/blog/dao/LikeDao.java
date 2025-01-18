package com.tech.blog.dao;

import java.sql.*;

public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con=con;
    }
    
    // Method to insert the like in the database.
    public boolean insertLike(int pid, int uid)
    {
        boolean f=false;
        try {
            String query="INSERT INTO like_table(pid,uid) VALUES (?,?)";
            PreparedStatement p=this.con.prepareStatement(query);
            
            p.setInt(1,pid);
            p.setInt(2,uid);
            
            p.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    // Method to count the like on the post.
    public int countLikeOnPost(int pid){
        int count=0;
        try {
            String query="SELECT count(*) FROM like_table WHERE pid=?";
        
            PreparedStatement p=this.con.prepareStatement(query);
            p.setInt(1,pid);
            
            ResultSet set=p.executeQuery();
            
            if(set.next())
            {
                //count=set.getInt(1);
                count=set.getInt("count(*)");
            }
        } catch (Exception e) {
        }
        return count;
    }
    
    // To check whether the logged in user liked the post or not.
    public boolean isLikedByUser(int pid, int uid){
        boolean f=false;
        try {
            String query="SELECT * FROM like_table WHERE pid=? AND uid=?";
        
            PreparedStatement p=this.con.prepareStatement(query);
            p.setInt(1,pid);
            p.setInt(2,uid);
            
            ResultSet set=p.executeQuery();
            
            if(set.next())
            {
                f=true;
            }
        } catch (Exception e) {
        }
        return f;
    }
    
    // Method to work as like the dislike button.
    public boolean deleteLike(int pid, int uid){
        boolean f=false;
        try {
            String query="DELETE FROM like_table WHERE pid=? AND uid=?";
        
            PreparedStatement p=this.con.prepareStatement(query);
            p.setInt(1,pid);
            p.setInt(2,uid);
            
            p.executeUpdate();
            f=true;
        } catch (Exception e) {
        }
        return f;
    }
}
