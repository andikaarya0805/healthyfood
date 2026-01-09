package com.healthycuy.dao;

import com.healthycuy.model.Product;
import com.healthycuy.config.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    // 1. Ambil Semua Menu (Buat Halaman Menu)
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY category DESC"; // Makanan dulu baru minum
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setImageUrl(rs.getString("image_url"));
                p.setCategory(rs.getString("category"));
                list.add(p);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // 2. Ambil 1 Produk by ID (Buat Masuk Keranjang)
    public Product getProductById(int id) {
        Product p = null;
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                p = new Product(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("image_url"),
                    rs.getString("category")
                );
            }
        } catch (Exception e) { e.printStackTrace(); }
        return p;
    }

    // 3. Tambah Produk (Buat Admin)
    public void insertProduct(Product p) {
        String sql = "INSERT INTO products (name, description, price, image_url, category) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, p.getName());
            ps.setString(2, p.getDescription());
            ps.setDouble(3, p.getPrice());
            ps.setString(4, p.getImageUrl());
            ps.setString(5, p.getCategory());
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 4. Hapus Produk (Buat Admin)
    public void deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}