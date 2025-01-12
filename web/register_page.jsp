<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <!--CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" 
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
              crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <title>Home Page</title>

        <style>
            .banner-background {
                clip-path: polygon(50% 0%, 100% 0, 100% 35%, 99% 100%, 87% 95%, 57% 100%, 16% 93%, 0 100%, 0% 35%, 0 0);
            }
        </style>
    </head>
    <body>
        <!--Navbar-->
        <%@include file="normal_navbar.jsp" %>

        <main class="primary-background p-5 banner-background" style="padding-bottom: 80px">
            <div class="container">
                <div class="col-md-6 offset-3">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center">
                            <span class="fa fa-user-plus fa-3x"></span>
                            <br>
                            <p>Register here</p>
                        </div>
                        <div class="card-body">
                            <form id="reg-form" action="RegisterServlet" method="post">
                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input name="user_name" type="text" class="form-control" id="user_name" placeholder="Enter name">
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" 
                                           aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Password">
                                </div>

                                <div class="form-group">
                                    <label for="gender">Select Gender</label>
                                    <br>
                                    <input type="radio" id="gender" name="gender" value="male"> Male&nbsp;
                                    <input type="radio" id="gender" name="gender" value="female"> Female
                                </div>

                                <div class="form-group">
                                    <textarea class="form-control" name="about" rows="5" placeholder="Enter something about yourself"></textarea>
                                </div>

                                <div class="form-check">
                                    <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree terms and conditions</label>
                                </div>

                                <br>

                                <div class="container text-center" id="loader" style="display: none">
                                    <span class="fa fa-spinner fa-4x fa-spin"></span>
                                    <h4>Please wait...</h4>
                                </div>
                                <div class="text-center">
                                    <button id="submit-btn" type="submit" class="btn btn-primary primary-background">Register</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--JavaScript-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" 
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" 
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" 
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>"
        <script>
            $(document).ready(function () {
                console.log("loaded...");

                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();

                    let form = new FormData(this);

                    $("#loader").show();
                    $("#submit-btn").hide();

                    $.ajax({
                        url: "RegisterServlet",
                        type: "POST",
                        data: form,
                        success: function (data) {
                            console.log(data);
                            $("#loader").hide();
                            $("#submit-btn").show();

                            if (data.trim() === 'done')
                            {
                                swal("Registered successfully. We are redirecting to Login page.")
                                        .then((value) => {
                                            window.location = "login_page.jsp";
                                        });
                            } else
                            {
                                swal("Already an account exists with this email. Try another email.");
                            }

                        },
                        error: function (jqXHR) {
                            console.log(jqXHR);
                            $("#loader").hide();
                            $("#submit-btn").show();
                            swal("Somwthing went wrong. Try again...");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });
        </script>
    </body>
</html>
