
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<!--navbar-->
<nav class="navbar navbar-expand-lg navbar-dark primary-background">
    <a class="navbar-brand" href="index"> <span class="fa fa-lightbulb-o"></span> TechBlog</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="#"  data-toggle="modal" data-target="#add-post-modal"> <span class="fa fa-book"></span> AddBlog</a>
            </li>
            

        </ul>
        <ul class="navbar-nav mr-right">
            
            
            <li class="nav-item">
                <a class="nav-link"  data-toggle="modal" data-target="#profile-modal" style=" cursor: pointer "> <img class="img-fluid" style="width:20px; height:20px; border-radius: 100%;" src="pics/<%= user.getProfile()%>">  <%= user.getName()%> </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#"> <span class="fa fa-address-card-o"></span> Contact</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="LogoutServlet"> <span class="fa fa-share-square-o "></span> Logout</a>
            </li>


        </ul>
    </div>
</nav>

<!--end of navbar-->


<!--start of profile modal-->

<div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel">Account</h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="container text-center">
                    <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius : 100%; width: 200px; height: 200px; object-fit: cover">
                    <h5 class="mt-3"> <%= user.getName()%> </h5>

                    <!--user details table-->
                    <div id="profile-details">
                        <table class="table">

                            <tbody>
                                <tr>
                                    <th scope="row">ID </th>
                                    <td> <%=user.getId()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row">Email </th>
                                    <td> <%= user.getEmail()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row">Gender </th>
                                    <td> <%= user.getGender().toUpperCase()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row">Status </th>
                                    <td> <%= user.getAbout()%> </td>
                                </tr>
                                <tr>
                                    <th scope="row">Registered on  </th>
                                    <td> <%= DateFormat.getDateTimeInstance().format(user.getDateTime()) %> </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!--edit profile-->
                    <div id="profile-edit" style="display : none">
                        <h5 class="mt-2">Update Profile</h5>

                        <form action="EditServlet" method="POST" enctype="multipart/form-data" >
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID </th>
                                        <td> <%=user.getId()%> </td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Name </th>
                                        <td> <input type="text" name="user_name" class="form-control" value="<%=user.getName()%>" > </td>
                                    </tr>

                                    <tr>
                                        <th scope="row">Gender </th>
                                        <td> <%= user.getGender().toUpperCase()%> </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email </th>
                                        <td> <%= user.getEmail()%> </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Password </th>
                                        <td> <input type="password" name="user_password" class="form-control" value="<%=user.getPassword()%>" >  </td>
                                    </tr>

                                    <tr>
                                        <th scope="row">About </th>
                                        <td>
                                            <textarea rows="3" class="form-control" name="user_about">
                                                <%= user.getAbout()%>
                                            </textarea>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th scope="row">New Profile </th>
                                        <td>
                                            <input required type="file" name="image" class="form-control">
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="container">
                                <button class="btn btn-outline-light primary-background">Save</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button id="edit-profile-btn" type="button" class="btn btn-outline-light primary-background">Edit</button>
            </div>
        </div>
    </div>
</div>

<!--end of profile modal-->

<!--add post modal-->

<div class="modal fade" id="add-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header primary-background text-white">
                <h5 class="modal-title" id="exampleModalLabel">Add Blog</h5>
                <button id="close-btn" type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="AddPostServlet" method="POST" id="add-post-form">

                    <div class="form-group">
                        <select class="form-control" name="cid">
                            <option selected disabled>---Select Category---</option>

                            <%
                                PostDao dao = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list = dao.getAllCategories();

                                for (Category c : list) {
                            %>
                            <option value="<%= c.getCid()%>"><%= c.getName()%></option>
                            <%
                                }
                            %>

                        </select>
                    </div>

                    <div class="form-group">
                        <input name="pTitle" type="text" placeholder="Enter post title" class="form-control">
                    </div>

                    <div class="form-group">
                        <textarea name="pContent" class="form-control" placeholder="Enter your content" style="height:200px"></textarea>
                    </div>

                    <div class="form-group">
                        <textarea name="pCode" class="form-control" placeholder="Enter your code(if any)" style="height:200px"></textarea>
                    </div>

                    <div class="form-group">
                        <label for="picture">Select your pic</label>
                        <input name="pic" class="form-control" id="picture" type="file" >
                    </div>

                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-light primary-background">Post</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<!--end of post modal-->
