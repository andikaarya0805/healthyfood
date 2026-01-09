package com.healthycuy.controller; // WAJIB INI

import com.healthycuy.dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/menu")
public class MenuController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Ambil data dan kirim ke JSP
        request.setAttribute("productList", productDAO.getAllProducts());
        request.getRequestDispatcher("/views/menu.jsp").forward(request, response);
    }
}