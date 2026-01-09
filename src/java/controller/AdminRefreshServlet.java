package com.healthycuy.controller;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebServlet("/admin-refresh")
public class AdminRefreshServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cek Login Admin (Keamanan)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            return; // Kalau gak login, diam aja
        }
        User user = (User) session.getAttribute("user");
        if (!"ADMIN".equals(user.getRole())) return;

        // 1. Ambil Data Terbaru dari Database
        request.setAttribute("orderList", orderDAO.getAllOrders());

        // 2. Kirim ke Fragment JSP (Bukan halaman full)
        request.getRequestDispatcher("/views/admin-order-rows.jsp").forward(request, response);
    }
}
