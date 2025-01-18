<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>

<div class="row">
    <%
        PostDao d = new PostDao(ConnectionProvider.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostsByCatId(cid);
        }
        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'> No post in this category...</h3>");
            return;
        }
        for (Post p : posts) {
    %>

    <div class="col-md-6 mt-4">
        <div class="card">
            <div class="card-body" style="max-height: 300px; overflow: hidden;">
                <img class="card-img-top" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap">
                <b><%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>
                <pre><%=p.getpCode()%></pre>
            </div>

            <div class="card-footer d-flex justify-content-between">
                <!-- Left section with like and comment buttons -->
                <div>
                    <a href="#!" class="btn btn-outline-light primary-background btn-sm"><i class="fa fa-thumbs-o-up"></i><span> 10</span></a>
                    <a href="#!" class="btn btn-outline-light primary-background btn-sm"><i class="fa fa-commenting"></i><span> 20</span></a>
                </div>

                <!-- Right section with Read more button -->
                <div>
                    <a href="show_blog_page.jsp?post_id=<%=p.getPid()%>" class="btn btn-outline-light primary-background btn-sm">Read more</a>
                </div>
            </div>

        </div>
    </div>

    <%
        }
    %>
</div>