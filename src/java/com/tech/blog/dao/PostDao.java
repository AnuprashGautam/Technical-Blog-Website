package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {

    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> list = new ArrayList<>();

        try {
            String query = "SELECT * FROM categories";

            Statement stmt = this.con.createStatement();
            ResultSet set = stmt.executeQuery(query);

            while (set.next()) {
                int cid = set.getInt("cid");
                String name = set.getString("name");
                String description = set.getString("description");

                Category c = new Category(cid, name, description);

                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Method to save the post in the databse.
    public boolean savePost(Post p) {
        boolean f = false;
        try {
            String query = "INSERT INTO posts(pTitle,pContent,pCode,pPic,catId,userId) VALUES (?,?,?,?,?,?)";

            PreparedStatement pstmt = con.prepareStatement(query);

            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCatId());
            pstmt.setInt(6, p.getUserId());

            pstmt.executeUpdate();

            f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Method to get all the posts in the form of a list.
    public List<Post> getAllPosts() {
        List<Post> list = new ArrayList<>();

        // Fetch all the posts.
        try {
            String query = "SELECT * FROM posts ORDER BY pid DESC";

            PreparedStatement pstmt = con.prepareStatement(query);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int catId = set.getInt("catId");
                int userId = set.getInt("userId");

                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Method to get all the posts by category.
    public List<Post> getPostsByCatId(int catId) {
        List<Post> list = new ArrayList<>();

        // Fetch all the posts by id.
        try {
            String query = "SELECT * FROM posts WHERE catId=? ORDER BY pid DESC";

            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, catId);
            ResultSet set = pstmt.executeQuery();

            while (set.next()) {
                int pid = set.getInt("pid");
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userId = set.getInt("userId");

                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Method to get the post with post id.
    public Post getPostById(int postid) {
        Post post = null;
        String query = "SELECT * FROM posts WHERE pid=?";

        try {
            // Fetching the post from the db.

            PreparedStatement pstmt = this.con.prepareStatement(query);
            pstmt.setInt(1, postid);

            ResultSet set = pstmt.executeQuery();

            if (set.next()) {
                
                // Getting the details from the fetched post.
                
                String pTitle = set.getString("pTitle");
                String pContent = set.getString("pContent");
                String pCode = set.getString("pCode");
                String pPic = set.getString("pPic");
                Timestamp date = set.getTimestamp("pDate");
                int userId = set.getInt("userId");
                int catId = set.getInt("catId");

                // Setting the fatched data in the Post object.
                post = new Post(postid, pTitle, pContent, pCode, pPic, date, catId, userId);
            }

        } catch (SQLException e) {
        }
        return post;
    }
}
