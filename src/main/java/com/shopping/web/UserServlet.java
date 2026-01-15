package com.shopping.web;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.shopping.dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user-register")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get data from the form
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // 2. Connect to Database
            Connection con = DBConnection.getConnection();
            
            // 3. Create SQL Query (Insert data)
            String query = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(query);
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            
            // 4. Run the Query
            int rowCount = pst.executeUpdate();
            
            if (rowCount > 0) {
                // Success! Send them to login page
                response.sendRedirect("login.jsp?status=success");
            } else {
                // Failed
                response.sendRedirect("register.jsp?status=failed");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?status=error");
        }
    }
}