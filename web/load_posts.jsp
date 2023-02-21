<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.User"%>

<%@page import="java.util.List"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>

<div class="row ">

    <%

        Thread.sleep(500);//to show loader
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));

        List<Post> posts = null;
        if (cid == 0) {
            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }

        if (posts.size() == 0) {
            out.println("<h3 class='display-3 text-center'>No posts in this category...</h3>");
            return;
        }
        for (Post p : posts) {
    %>

    <div class="col-md-6 d-flex align-items-stretch">
        <div class="card  mt-2">
            <div class="card-body">
                <img class="card-img-top img-fluid" src="blog_pics/<%= p.getpPic()%>" alt="card-image" style="width: 100%; height: 50vh; object-fit: cover ">
                <b> <%= p.getpTitle()%></b>
                <p> <%= p.getpContent()%> </p>
            </div>
            <div class="card-footer text-center primary-background">

                <a href="show_blog_page.jsp?post_id=<%= p.getpId()%>" class="btn btn-outline-light btn-sm">Read more...</a>
            </div>
        </div>
    </div>

    <%
        }
    %>
</div>
