package com.healthycuy.controller; // PACKAGE HARUS INI


import com.healthycuy.dao.ProductDAO;
import com.healthycuy.model.Product;
import dao.OrderDAO;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.User;

@WebServlet("/admin")
@MultipartConfig
public class AdminController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private OrderDAO orderDAO = new OrderDAO();

    // Cek apakah user adalah ADMIN
    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            User user = (User) session.getAttribute("user");
            return user != null && "ADMIN".equals(user.getRole());
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) { response.sendRedirect("auth"); return; }

        // Ambil Data Menu & Data Pesanan buat Admin Panel
        request.setAttribute("productList", productDAO.getAllProducts());
        request.setAttribute("orderList", orderDAO.getAllOrders());

        request.getRequestDispatcher("/views/admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) { response.sendRedirect("auth"); return; }

        String action = request.getParameter("action");

        if ("insert".equals(action)) {
            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String category = request.getParameter("category");
            String imageUrl = request.getParameter("imageUrl");
            
            if(imageUrl == null || imageUrl.isEmpty()) imageUrl = "https://placehold.co/600x400";
            
            Product p = new Product(0, name, desc, price, imageUrl, category);
            productDAO.insertProduct(p);
        }
        else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteProduct(id);
        }
        else if ("updateStatus".equals(action)) {
            // Admin mengubah status pesanan (PENDING -> COMPLETED)
            int id = Integer.parseInt(request.getParameter("id"));
            String status = request.getParameter("status"); 
            
            orderDAO.updateStatus(id, status);
        }

        response.sendRedirect("admin");
    }
}