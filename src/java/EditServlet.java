
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
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class EditServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            // Fetching the updated data.

            String userEmail = request.getParameter("user_email");
            String userName = request.getParameter("user_name");
            String userAbout = request.getParameter("user_about");
            String userPassword = request.getParameter("user_password");
            Part part = request.getPart("image");
            String imageName = part.getSubmittedFileName();

            // Get the user form the session.
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            user.setEmail(userEmail);
            user.setName(userName);
            user.setPassword(userPassword);
            user.setAbout(userAbout);
            user.setProfile(imageName);

            // Updating the details in the database.
            UserDao userDao = new UserDao(ConnectionProvider.getConnection());
            boolean b = userDao.updateUser(user);

            if (b == true) {
                String path = request.getRealPath("/") + "pics" + File.separator + user.getProfile();

                Helper.deleteFile(path);
                if (Helper.saveFile(part.getInputStream(), path)) {
                    Message msg = new Message("Profile updated successfully.","success","alert-success");
                    session.setAttribute("msg", msg);
                } else {
                    out.println("New profile not updated.");
                }
            } else {
                out.println("Details not updated.");
                Message msg = new Message("Something went wrong ...","error","alert-danger");
                session.setAttribute("msg", msg);
            }
            
            response.sendRedirect("profile.jsp");
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
