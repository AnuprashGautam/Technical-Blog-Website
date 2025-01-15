<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<div class="row">
<%
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    List<Post> posts = d.getAllPosts();
    for (Post p : posts) {
%>

<div class="col-md-6 mt-4">
    <div class="card">
        <div class="card-body">
            <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
            <b><%= p.getpTitle()%></b>
            <p><%= p.getpContent()%></p>
            <pre><%=p.getpCode()%></pre>
        </div>
    </div>
</div>

<%
    }
%>
</div>