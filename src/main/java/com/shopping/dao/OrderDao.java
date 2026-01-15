package com.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.shopping.model.Order;
import com.shopping.model.Product;

public class OrderDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;
    
    public OrderDao(Connection con) {
        this.con = con;
    }

    public boolean insertOrder(Order model) {
        boolean result = false;
        try {
            // MERGED QUERY: Includes 'size' AND the new address fields
            query = "insert into orders (p_id, u_id, o_quantity, o_date, size, first_name, last_name, address, city, phone, payment_method) values(?,?,?,?,?,?,?,?,?,?,?)";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, model.getId());
            pst.setInt(2, model.getUid());
            pst.setInt(3, model.getQuantity());
            pst.setString(4, model.getDate());
            pst.setString(5, model.getSize()); // Added Size back
            
            // Address & Payment Fields
            pst.setString(6, model.getFirstName());
            pst.setString(7, model.getLastName());
            pst.setString(8, model.getAddress());
            pst.setString(9, model.getCity());
            pst.setString(10, model.getPhone());
            pst.setString(11, model.getPaymentMethod());
            
            pst.executeUpdate();
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    // Fetch orders for a specific user
    public List<Order> userOrders(int id) {
        List<Order> list = new ArrayList<>();
        try {
            query = "select * from orders where u_id=? order by o_id desc";
            pst = this.con.prepareStatement(query);
            pst.setInt(1, id);
            rs = pst.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                ProductDao productDao = new ProductDao(this.con);
                int pId = rs.getInt("p_id");
                
                Product product = productDao.getSingleProduct(pId);
                
                order.setOrderId(rs.getInt("o_id"));
                order.setId(pId);
                order.setName(product.getName());
                order.setCategory(product.getCategory());
                
                // Calculate total price based on DB quantity
                order.setPrice(product.getPrice() * rs.getInt("o_quantity"));
                order.setQuantity(rs.getInt("o_quantity"));
                order.setDate(rs.getString("o_date"));
                
                // RETRIEVE ALL SAVED DATA
                order.setSize(rs.getString("size")); // Get the size back
                
                order.setFirstName(rs.getString("first_name"));
                order.setLastName(rs.getString("last_name"));
                order.setAddress(rs.getString("address"));
                order.setCity(rs.getString("city"));
                order.setPhone(rs.getString("phone"));
                order.setPaymentMethod(rs.getString("payment_method"));
                
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}