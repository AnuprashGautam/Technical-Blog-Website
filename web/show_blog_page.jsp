<%
    int postId=Integer.parseInt(request.getParameter("post_id"));
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello this is the blog page to show the specific blog with the help of post id.</h1>
        <h2>Your post id is:<%=postId%></h2>
    </body>
</html>
