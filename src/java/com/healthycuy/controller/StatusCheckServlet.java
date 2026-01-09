package com.healthycuy.controller;

import com.healthycuy.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.healthycuy.model.User;

@WebServlet("/check-status")
public class StatusCheckServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            if (user != null) {
                // Cek status terakhir di DB
                String status = orderDAO.getLatestStatus(user.getId());
                response.setContentType("text/plain");
                response.getWriter().write(status); // Kirim text "PENDING" atau "COMPLETED"
            }
        }
    }
}