package controller;

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
        // 1. Ambil semua data produk dari database
        request.setAttribute("productList", productDAO.getAllProducts());
        
        // 2. Lempar ke tampilan JSP
        // Pake '/views/' biar path-nya absolut
        request.getRequestDispatcher("/views/menu.jsp").forward(request, response);
    }
}