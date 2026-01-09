package dao;

import com.healthycuy.model.Order;
import config.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // Simpan Order dengan User ID
    public void saveOrder(Order order, int userId) {
        String sql = "INSERT INTO orders (customer_name, total_amount, order_details, status, user_id) VALUES (?, ?, ?, 'PENDING', ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, order.getCustomerName());
            ps.setDouble(2, order.getTotalAmount());
            ps.setString(3, order.getOrderDetails());
            ps.setInt(4, userId); // Masukin ID User
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // Ambil Status Terakhir User Ini (Buat Notifikasi)
    public String getLatestStatus(int userId) {
        String status = "";
        String sql = "SELECT status FROM orders WHERE user_id = ? ORDER BY id DESC LIMIT 1";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                status = rs.getString("status");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return status;
    }

    // Ambil Semua Order (Buat Admin)
    public List<Order> getAllOrders() {
        List<Order> list = new ArrayList<>();
        String sql = "SELECT * FROM orders ORDER BY order_date DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Order o = new Order();
                o.setId(rs.getInt("id"));
                o.setCustomerName(rs.getString("customer_name"));
                o.setTotalAmount(rs.getDouble("total_amount"));
                o.setOrderDetails(rs.getString("order_details"));
                o.setStatus(rs.getString("status"));
                o.setOrderDate(rs.getTimestamp("order_date"));
                list.add(o);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Update Status
    public void updateStatus(int id, String status) {
        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}