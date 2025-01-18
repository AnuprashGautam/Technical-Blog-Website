<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>

<%
    // Validation
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }

    // Retriving the post_id from the load_posts.jsp page.
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());
    Post p = d.getPostById(postId);
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%=p.getpTitle()%></title>
        <!--CSS-->        
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style:italic;
            }
            .post-user-info{
                font-size: 20px;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
            body{
                background: url(img/bg.jpg);
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"><span class="fa fa-xing"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"><span class="fa fa-bell-o"></span> LearnCode with Durgesh <span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class="fa fa-check-square-o"></span> Categories
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project Implementation</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"><span class="fa fa-address-book-o"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#add-post-modal"><span class="fa fa-pencil-square-o"></span> Do Post</a>
                    </li>


                </ul>

                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link active" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user"></span> <%= user.getName()%></a>
                    </li>

                    <li class="nav-item active">
                        <a class="nav-link" href="LogoutServlet"><span class="fa fa-user-times"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
        <!-- End of navbar -->

        <!-- Main body of the page. -->

        <div class="container">
            <div class="row my-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center">
                            <h4 class="post-title"><%=p.getpTitle()%></h4>
                        </div>

                        <div class="card-body">

                            <img class="img-fluid card-img-top my-2" src="blog_pics/<%=p.getpPic()%>" alt="Card image cap" >

                            <div class="row my-3 row-user">
                                <div class="col-md-8">
                                    <% 
                                        UserDao ud=new UserDao(ConnectionProvider.getConnection()); 
                                        
                                        User u=ud.getUserByPostId(postId);
                                    %>
                                    <p class="post-user-info"><a href="#"><%=u.getName()%></a> has posted:</p>
                                </div>
                                <div class="col-md-4">
                                    <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                                </div>
                            </div>

                            <p class="post-content"><%=p.getpContent()%></p>
                            <br>
                            <br>
                            <div class="post-code"> 
                                <pre><%=p.getpCode()%></pre>
                            </div>
                        </div>

                        <div class="card-footer primary-background text-white">
                            <a href="#!" onclick="doLike(<%=p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light primary-background btn-sm"><i class="fa fa-thumbs-o-up"></i><span> 10</span></a>
                            <a href="#!" class="btn btn-outline-light primary-background btn-sm"><i class="fa fa-commenting"></i><span> 20</span></a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- End of the main body of the page. -->

            <!-- Start of Profile Modal -->

            <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header primary-background text-white text-center">
                            <h5 class="modal-title" id="exampleModalLabel">Tech Blog</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="container text-center">
                                <img src="pics/<%=user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 100px"/>
                                <br>
                                <h5 class="modal-title mt-3" id="exampleModalLabel"><%=user.getName()%></h5>

                                <!--Details-->

                                <div id="profile-details">
                                    <table class="table">

                                        <tbody>
                                            <tr>
                                                <th scope="row">ID :</th>
                                                <td><%= user.getId()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row">Email :</th>
                                                <td><%= user.getEmail()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row"> Gender :</th>
                                                <td><%= user.getGender().toUpperCase()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row"> Status :</th>
                                                <td><%= user.getAbout()%></td>

                                            </tr>
                                            <tr>
                                                <th scope="row"> Registered on :</th>
                                                <td><%= user.getRdate().toString()%></td>

                                            </tr>
                                        </tbody>
                                    </table>
                                </div>

                                <!--profile edit-->  

                                <div id="profile-edit" style="display: none;">
                                    <h3 class="mt-2">Please Edit Carefully</h3>
                                    <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                        <table class="table">
                                            <tr>
                                                <td>ID :</td>
                                                <td><%= user.getId()%></td>
                                            </tr>
                                            <tr>
                                                <td>Email :</td>
                                                <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail()%>"></td>
                                            </tr>
                                            <tr>
                                                <td>Name :</td>
                                                <td><input type="text" name="user_name" class="form-control" value="<%= user.getName()%>"></td>
                                            </tr>
                                            <tr>
                                                <td>Password :</td>
                                                <td><input type="password" name="user_password" class="form-control" value="<%= user.getPassword()%>"></td>
                                            </tr>
                                            <tr>
                                                <td>Gender :</td>
                                                <td><%= user.getGender().toUpperCase()%></td>
                                            </tr>
                                            <tr>
                                                <td>Status :</td>
                                                <td>
                                                    <textarea rows=3 class="form-control" name="user_about"><%=user.getAbout()%>
                                                    </textarea>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>New Profile:</td>
                                                <td>
                                                    <input type="file" name="image" class="form-control">
                                                </td>
                                            </tr>
                                        </table>

                                        <div class="container">
                                            <button type="submit" class="btn btn-outline-primary">Save</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="button" id="edit-profile-button" class="btn btn-primary">Edit</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- End of Profile Modal -->

            <!--Start of Post modal-->

            <!-- Modal -->
            <div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel">Provide the post details.</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <form id="add-post-form" action="AddPostServlet" method="POST" enctype="multipart/form-data">
                                <div class="form-group">
                                    <select name="cid" class="form-control">
                                        <option selected disabled>---Select Category---</option>
                                        <%
                                            PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                            ArrayList<Category> l = postd.getAllCategories();
                                            for (Category c : l) {
                                        %>
                                        <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input name="pTitle" type="text" placeholder="Enter post Title" class="form-control">
                                </div>
                                <div class="form-group">
                                    <textarea name="pContent" class="form-control" style="height:200px;" placeholder="Enter your content" ></textarea>
                                </div>
                                <div class="form-group">
                                    <textarea name="pCode" class="form-control" style="height:100px;" placeholder="Enter your program (if any)" ></textarea>
                                </div>
                                <div class="form-group">
                                    <label>Select your pic</label>
                                    <br>
                                    <input name="pic" type="file" class="form-control">
                                </div>
                                <div class="container text-center">
                                    <button type="submit" class="btn btn-outline-primary">Post</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!--End of Post modal-->

            <!--JavaScript-->
            <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
            <script src="./js/myjs.js"></script>

            <script>
                $(document).ready(function () {
                    let editStatus = false;

                    $('#edit-profile-button').click(function () {
                        if (editStatus == false)
                        {
                            $('#profile-details').hide();
                            $('#profile-edit').show();
                            editStatus = true;
                            $(this).text("Back");
                        } else
                        {
                            $('#profile-details').show();
                            $('#profile-edit').hide();
                            editStatus = false;
                            $(this).text("Edit");
                        }
                    });
                });
            </script>

            <!--Now add post js-->
            <script>
                $(document).ready(function (e) {
                    // Attach a submit event listener to the form
                    $("#add-post-form").on("submit", function (event) {
                        // Prevent the default form submission behavior
                        event.preventDefault();

                        // Log a message to the console to confirm the event handler is working
                        console.log("You have clicked the submit button.");

                        // Create a FormData object with the form's data
                        let form = new FormData(this);

                        // Make an AJAX request to submit the form data to the server
                        $.ajax({
                            url: "AddPostServlet", // Server-side endpoint
                            type: 'POST', // HTTP method
                            data: form, // Form data
                            success: function (data, textStatus, jqXHR) {
                                // Log a success message if the request is successful
                                console.log(data);
                                if (data.trim() == "done")
                                {
                                    swal("Good job!", "Saved successfully!", "success");
                                } else {
                                    swal("Error !", "Something went wrong!", "error");

                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                // Log an error message if the request fails
                                console.log("Error in submission:", errorThrown);
                            },
                            processData: false, // Prevent automatic processing of data
                            contentType: false // Prevent automatic setting of content type
                        });
                    });
                });
            </script>
    </body>
</html>
