<%@page import="com.tech.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> TechBlog </title>
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

        <!--navbar-->
        <%@include file="normal_navbar.jsp" %>

        <!--banner-->

        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background">
                <div class="container">
                    <h3 class="display-3">Welcome to TechBlog</h3>
                    <p>
                        Welcome to TechBlog, A programming language is a type of written language that tells computers what to do. Programming languages are used to write all computer programs and computer software.
                    </p>
                    <p>
                        The description of a programming language is usually split into the two components of syntax (form) and semantics (meaning), which are usually defined by a formal language. A programming language is like a set of instructions that the computer follows to do something.
                    </p>
                    <a href="register" class="btn btn-outline-light btn-lg"> <span class="fa fa-paper-plane fa-shake"></span> Start! Its free</a>
                    <a href="login" class="btn btn-outline-light btn-lg"> <span class="fa fa-user-circle-o fa-spin"></span> Login</a>

                </div>
            </div>
        </div>
        <div class="container">
            <div class="row">

                <%
                    PostDao dao = new PostDao(ConnectionProvider.getConnection());
                    ArrayList<Category> list = dao.getAllCategories();

                    for (Category c : list) {

                %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-header text-center bg-white">
                            <h5 class="card-title"><%= c.getName()%></h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><%= c.getDescription()%></p>
                        </div>
                        <div class="card-footer primary-background text-center text-white">
                            <a href="profile" class="btn btn-outline-light">Explore</a>
                        </div>
                    </div>
                </div>


                <%                    }
                %>
            </div>
        </div>

        <!--bootstrap + jquery(ajax  enabled)-->
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
    </body>
</html>
