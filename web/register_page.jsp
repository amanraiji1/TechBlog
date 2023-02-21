<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--favicon-->
        <link rel="icon" href="img/bulb">

        <!--bootstrap-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 92%, 70% 100%, 29% 91%, 0 100%, 0 0);
            }
        </style>


        <title>Register</title>
    </head>
    <body>

        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>

        <main class="primary-background banner-background" style="padding-bottom : 80px">

            <div class="container">
                <div class="col-md-6 offset-md-3">
                    <div class="card">

                        <div class="card-header primary-background text-center text-white">
                            <span class="fa fa-3x fa-user-plus"></span>
                            <p>Register here</p>
                        </div>
                        <div class="card-body" >
                            <form id="reg-form" action="RegisterServlet" method="POST" >
                                <div class="form-group">
                                    <label for="user_name">User Name</label>
                                    <input required name="user_name" type="text" class="form-control" id="user-name" aria-describedby="emailHelp" placeholder="Enter name">
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputEmail1">Email address</label>
                                    <input required name="user_email" type="email" class="form-control" id="user-email" aria-describedby="emailHelp" placeholder="Enter email">
                                    <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                </div>
                                <div class="form-group">
                                    <label for="exampleInputPassword1">Password</label>
                                    <input required name="user_password" type="password" class="form-control" id="user_password" placeholder="Password">
                                </div>

                                <div class="form-group">
                                    <label for="exampleInputPassword1">Select Gender</label>
                                    <br>
                                    <input required type="radio" name="user_gender" id="gender" value="male" > Male
                                    <input required type="radio" name="user_gender" id="gender" value="female" > Female
                                </div>

                                <div class="form-group">
                                    <textarea name="user_about" class="form-control" type="text" cols="10" rows="5" placeholder="Enter something about you.."></textarea>
                                </div>

                                <div class="form-check">
                                    <input name="user_check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                    <label class="form-check-label" for="exampleCheck1">Agree Terms and Condition</label>
                                </div>
                                <br>
                                <div class="container text-center" id="loader" style="display : none" >
                                    <span class="fa fa-refresh fa-4x fa-spin"></span>
                                    <br>
                                    <h4>Please Wait..</h4>
                                </div>
                                <button id="submit-btn" type="submit" class="btn btn-outline-light primary-background">Submit</button>
                            </form>

                        </div>
                        <div class="card-footer">
                            <div class="container text-center">

                                Already Registered? 
                                <a href="login" style="text-decoration: none" class="text-">Login Here...</a>
                            </div>
                        </div>
                    </div>

                </div>

            </div>

        </main>


        <!--bootstrap + jquery(ajax  enabled)-->
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#reg-form').on('submit', function (event) {
                    event.preventDefault();
                    $('#loader').show();
                    $('#submit-btn').hide();
                    let form = new FormData(this);
                    $.ajax({
                        url: 'RegisterServlet',
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                            $('#loader').hide();
                            $('#submit-btn').show();

                            if (data.trim() === 'Success') {

                                swal("Registered successfully!", "redirecting to login page", "success").then((value) => {
                                    window.location = "login"
                                });
                            } else {
                                swal(data,"","warning");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            $('#loader').hide();
                            $('#submit-btn').show();

                            swal("Error!", "Something went wrong...", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                })

            })
        </script>

    </body>
</html>
