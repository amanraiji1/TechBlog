<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.entities.Category"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.entities.Message"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage = "error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Page</title>
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
        </style>

    </head>
    <body>
        <%@include file="admin_navbar.jsp" %>

        <%            Message m = (Message) session.getAttribute("msg");

            if (m != null) {
        %>

        <div class="alert <%= m.getCssClass()%> text-center" role="alert">
            <%= m.getContent()%>
        </div>
        <%
                session.removeAttribute("msg");
            }
        %>
        <!--main page of the profile start-->
        <main>
            <div class="container">
                <div class="row mt-4">
                    <!--first col-->
                    <div class="col-md-4">
                        <!--categories-->
                        <div class="list-group">
                            <a  href="#" onclick="getPosts(0, this)" class="c-link list-group-item list-group-item-action primary-background">
                                All Posts
                            </a>

                            <%
                                PostDao postdao = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = postdao.getAllCategories();

                                for (Category cc : list1) {
                            %>

                            <a href="#" onclick="getPosts(<%= cc.getCid()%>, this)" class="c-link list-group-item list-group-item-action"><%= cc.getName()%></a>

                            <%
                                }
                            %>
                        </div>
                    </div>
                    <!--second column-->

                    <div class="col-md-8">
                        <!--posts-->
                        <div class="container text-center" id="loader">
                            <i class="fa fa-refresh fa-4x fa-spin"></i>

                            <h3 class="mt-2">Loading...</h3>
                        </div>
                        <div class="container-fluid"  id="post-container">

                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!--main page of profile ends-->



        <!--bootstrap + jquery(ajax  enabled)-->
        <script src="js/myjs.js" type="text/javascript"></script>
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
                                                    $('#loader').hide();
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

        <!--load all post ajax-->
        <script>
            function getPosts(catId, temp) {
                $("#loader").show();
                $("#post-container").hide();

                $(".c-link").removeClass("active primary-background");
                $(temp).addClass("active primary-background");

                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: catId},
                    success: function (data, textStatus, jqXHR) {
                        $("#loader").hide();
                        $("#post-container").show();
                        $("#post-container").html(data);
                    },
                    error: function (jqXHR, textStatus, errorThrown) {

                    }
                });
            }
            $(document).ready(function (e) {
//                initially we needed to allpost to be active it is at first
                let allPostRef = $(".c-link")[0];
                getPosts(0, allPostRef);
            });
        </script>
    </body>
</html>
