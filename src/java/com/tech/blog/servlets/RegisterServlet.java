package com.tech.blog.servlets;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class RegisterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String check = request.getParameter("check");

            if (check == null) {
                out.println("Box not checked.");
            } else {
                // Fetching the parameters.

                String name = request.getParameter("user_name");
                String email = request.getParameter("user_email");
                String password = request.getParameter("user_password");
                String gender = request.getParameter("gender");
                String about = request.getParameter("about");

                // Making a User class object for the UserDao class.
                User user = new User(name, email, password, gender, about);

                // Making the object of UserDao class to save these details.
                UserDao userDao = new UserDao(ConnectionProvider.getConnection());
                boolean flag = userDao.saveUser(user);

                if (flag == true) {
                    out.println("done");
                } else {
                    out.println("error");
                }
            }
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}
