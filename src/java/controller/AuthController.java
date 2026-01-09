package controller;

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) session.invalidate(); 
            response.sendRedirect("index.jsp");
        } 
        else if ("register".equals(action)) {
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        } 
        else {
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            User user = userDAO.login(u, p);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user); 

                // Redirect Sesuai Role
                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect("admin");
                } else {
                    response.sendRedirect("menu");
                }
            } else {
                request.setAttribute("error", "Username/Password salah!");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        } 
        else if ("register".equals(action)) {
            String u = request.getParameter("username");
            String p = request.getParameter("password");
            
            User newUser = new User();
            newUser.setUsername(u);
            newUser.setPassword(p);
            
            userDAO.register(newUser);
            response.sendRedirect("auth?action=login&msg=Daftar berhasil, silakan login!");
        }
    }
}