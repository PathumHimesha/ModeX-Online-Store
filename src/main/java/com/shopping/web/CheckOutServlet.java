package com.shopping.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.shopping.dao.DBConnection;
import com.shopping.dao.OrderDao;
import com.shopping.model.Cart;
import com.shopping.model.Order;
import com.shopping.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/cart-check-out")
public class CheckOutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date date = new Date();
            
            // Retrieve session data
            ArrayList<Cart> cart_list = (ArrayList<Cart>) request.getSession().getAttribute("cart_list");
            User auth = (User) request.getSession().getAttribute("auth");
            
            // Retrieve detailed shipping and payment info from the checkout form
            String firstName = request.getParameter("fname");
            String lastName = request.getParameter("lname");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String phone = request.getParameter("phone");
            String paymentMethod = request.getParameter("payment_method");
            
            if(cart_list != null && auth != null) {
                for(Cart c : cart_list) {
                    Order order = new Order();
                    order.setId(c.getId());
                    order.setUid(auth.getId());
                    order.setQuantity(c.getQuantity());
                    order.setDate(formatter.format(date));
                    
                    // IMPORTANT: Save the Size from the Cart object
                    order.setSize(c.getSize()); 
                    
                    // Set the premium checkout fields
                    order.setFirstName(firstName);
                    order.setLastName(lastName);
                    order.setAddress(address);
                    order.setCity(city);
                    order.setPhone(phone);
                    order.setPaymentMethod(paymentMethod);
                    
                    OrderDao oDao = new OrderDao(DBConnection.getConnection());
                    boolean result = oDao.insertOrder(order);
                    if(!result) break;
                }
                
                // Reset cart after successful database insertion
                cart_list.clear();
                request.getSession().setAttribute("cart_list", null); // Ensure session is cleared
                response.sendRedirect("orders.jsp");
                
            } else {
                if(auth == null) {
                    response.sendRedirect("login.jsp");
                } else {
                    response.sendRedirect("cart.jsp");
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
            response.sendRedirect("cart.jsp");
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}