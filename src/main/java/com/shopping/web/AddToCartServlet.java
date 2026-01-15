package com.shopping.web;

public package com.shopping.web;

import java.io.IOException;
import java.util.ArrayList;

import com.shopping.model.Cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-to-cart")
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // 1. Get Product ID
            int id = Integer.parseInt(request.getParameter("id"));
            
            // 2. Get Quantity (Default to 1 if missing) int quantity = 1;
            String qtyParam = request.getParameter("quantity");
            if(qtyParam != null && !qtyParam.isEmpty()) {
                quantity = Integer.parseInt(qtyParam);
            }

            // 3. Get Size (Default to "M" if missing)
            String size = request.getParameter("size");
            if(size == null || size.isEmpty()) {
                size = "M"; 
            }

            // Create Cart Object
            Cart cm = new Cart();
            cm.setId(id);
            cm.setQuantity(quantity);
            cm.setSize(size); // Store the size!

            // Get Session
            HttpSession session = request.getSession();
            ArrayList<Cart> cartList = (ArrayList<Cart>) session.getAttribute("cart_list");

            if (cartList == null) {
                // First time adding to cart
                cartList = new ArrayList<>();
                cartList.add(cm);
                session.setAttribute("cart_list", cartList);
                response.sendRedirect("shop.jsp");
            } else {
                // Check if product already exists
                boolean exist = false;
                for (Cart c : cartList) {
                    // Match by ID
                    if (c.getId() == id) {
                        // OPTIONAL: If same size, just update quantity
                        // If different size, you might want to treat as new item (logic depends on preference)
                        // For now, let's stop duplicates based on ID only for simplicity
                        exist = true;
                        response.sendRedirect("cart.jsp"); // Item already in cart
                        return;
                    }
                }

                if (!exist) {
                    cartList.add(cm);
                    response.sendRedirect("shop.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("shop.jsp");
        }
    }
}{
    
}
