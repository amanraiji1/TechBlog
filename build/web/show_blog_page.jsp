<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage = "error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login");
    }
%>


<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);
%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> - TechBlog</title>
        <!--favicon-->
        <link rel="icon" href="img/bulb">


        <!--bootstrap-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 89%, 70% 100%, 31% 90%, 0 100%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }

        </style>

    </head>
    <body>

        <%@include file="admin_navbar.jsp" %>
        <!--main content-->

        <div class="container">
            <div class="row mt-4">
                <div class="col-md-8 offset-md-2">
                    <div class="card">
                        <div class="card-header primary-background text-white">

                            <h4 class="post-title"><a href="profile"><span class="fa fa-arrow-left text-white mr-2"></span></a><%= p.getpTitle()%></h4>
                        </div>
                        <div class="card-body">
                            <img class="card-img-top mt-2" src="blog_pics/<%= p.getpPic()%>" alt="card-image">

                            <div class="row my-2" style="border-bottom: 2px solid #e2e2e2; border-top : 2px solid #e2e2e2 ; padding: 5px">
                                <div class="col-md-8">
                                    <%
                                        UserDao udao = new UserDao(ConnectionProvider.getConnection());
                                        User u = udao.getUserByUserId(p.getUserId());
                                    %>
                                    <h6><a class="text-primary" style="font-size:20px; cursor: default; text-decoration: none; "><%= u.getName()%></a> posted on :</h6>
                                </div>
                                <div class="col-md-4">
                                    <h6 style="font-style:italic"> <%= DateFormat.getDateTimeInstance().format(p.getpDate())%> </h6>
                                </div>
                            </div>

                            <p class="post-content"> <%= p.getpContent()%> </p>
                            <br>
                            <br>
                            <div class="post-code">
                                <pre><%= p.getpCode()%></pre>
                            </div>
                        </div>
                        <div class="card-footer text-center primary-background">
                            <%
                                LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
                            %>
                            <button onclick="doLike(<%= p.getpId()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up" id="like-button"></i><span class="like-counter"><%= ldao.countLikeOnPost(p.getpId())%></span></button>
                            <!--<a href="#" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i><span>10</span></a>-->
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!--main content ends-->



        <script src="js/myjs.js" type="text/javascript"></script>
        <!--bootstrap + jquery(ajax  enabled)-->
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


        <!--edit profile ajax-->
        <script>
                                $(document).ready(function () {

                                    let editStatus = false;
                                    $('#edit-profile-btn').click(function () {
                                        if (editStatus === false) {
                                            $('#profile-details').hide();
                                            $('#profile-edit').show();
                                            $(this).text("Back");
                                            editStatus = true;
                                        } else {
                                            $('#profile-details').show();
                                            $('#profile-edit').hide();
                                            $(this).text("Edit");
                                            editStatus = false;
                                        }
                                    });
                                });
        </script>

        <!--add post ajax-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
                                $(document).ready(function (e) {

                                    $("#add-post-form").on("submit", function (event) {
                                        //this code execute when form is submitted for the post
                                        event.preventDefault();
                                        $('#loader').show();
                                        $('#submit-btn').hide();

                                        let form = new FormData(this);
                                        $.ajax({
                                            url: 'AddPostServlet',
                                            type: 'POST',
                                            data: form,
                                            success: function (data, textStatus, jqXHR) {
                                                if (data.trim() === 'Success') {

                                                    swal("Good job!", "Post added successfully...", "success").then((value) => {
                                                        window.location = "profile";
                                                    });
                                                    ;
                                                } else {
                                                    swal("Error!", "Please fill all the fields...", "warning");
                                                }
                                            },
                                            error: function (jqXHR, textStatus, errorThrown) {
                                                swal("Error!", "Something went wrong...", "error");
                                            },
                                            processData: false,
                                            contentType: false
                                        });
                                    });
                                });
        </script>
    </body>
</html>
