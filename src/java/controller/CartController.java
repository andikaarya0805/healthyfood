package com.healthycuy.controller; // PACKAGE HARUS INI

import com.healthycuy.dao.ProductDAO;
import com.healthycuy.model.Order;
import com.healthycuy.model.Product;
import dao.OrderDAO;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import model.User;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        // 1. CEK LOGIN
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("auth?action=login&error=Harus login dulu bos!");
            return;
        }

        List<Product> cart = (List<Product>) session.getAttribute("cart");
        if (cart == null) cart = new ArrayList<>();

        if ("add".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product p = productDAO.getProductById(id);
            if (p != null) {
                cart.add(p);
                session.setAttribute("cart", cart);
            }
            response.sendRedirect("menu");
        } 
        else if ("checkout".equals(action)) {
            String customerName = request.getParameter("customerName");
            double total = 0;
            StringBuilder details = new StringBuilder();
            
            for (Product p : cart) {
                total += p.getPrice();
                details.append(p.getName()).append(", ");
            }

            Order order = new Order();
            // Simpan nama pelanggan (Nama Form + Username Akun)
            order.setCustomerName(customerName + " (" + user.getUsername() + ")");
            order.setTotalAmount(total);
            order.setOrderDetails(details.toString());

            // --- PERBAIKAN VITAL DISINI ---
            // Kita simpan ID User ke database biar Notifnya nyampe ke orang yang tepat!
            // Pastikan method saveOrder di OrderDAO sudah terima parameter (Order, int)!
            orderDAO.saveOrder(order, user.getId()); 
            // -----------------------------

            session.removeAttribute("cart");
            response.sendRedirect("menu?status=success");
        }
    }
}