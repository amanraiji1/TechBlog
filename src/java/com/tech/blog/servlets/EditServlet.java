/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author hp
 */
@MultipartConfig
public class EditServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String userName = request.getParameter("user_name");
            String userPassword = request.getParameter("user_password");
            String userAbout = request.getParameter("user_about");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();
//            fetch current user
            HttpSession s = request.getSession();
            User user = (User) s.getAttribute("currentUser");
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            String oldProfile = user.getProfile();
            user.setProfile(imageName);

//            update user to db
            UserDao dao = new UserDao(ConnectionProvider.getConnection());
            if (dao.updateUser(user)) {
                //update successful
                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

//                delete code

                String oldProfilePath = request.getRealPath("/") + "pics" + File.separator + oldProfile;
                if(!oldProfile.equals("default.png")){
                    Helper.deleteFile(oldProfilePath);
                }

                if (Helper.saveFile(part.getInputStream(), path)) {
                    Message m = new Message("Profile Updated Successfully...", "success", "alert-success");

                    s.setAttribute("msg", m);

                } else {
                    Message m = new Message("Something went wrong..try again!", "error", "alert-danger");

                    s.setAttribute("msg", m);
                }
            } else {
                //error

                Message m = new Message("Something went wrong..try again!", "error", "alert-danger");

                s.setAttribute("msg", m);
            }

            response.sendRedirect("profile");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
