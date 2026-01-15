package com.shopping.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.shopping.dao.DBConnection;
import com.shopping.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/user-login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                Connection con = DBConnection.getConnection();
                String query = "SELECT * FROM users WHERE email=? AND password=?";
                PreparedStatement pst = con.prepareStatement(query);
                pst.setString(1, email);
                pst.setString(2, password);
                
                ResultSet rs = pst.executeQuery();
                
                if (rs.next()) {
                    // 1. Create a User Object
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    
                    // 2. SAVE the user to the Session (Memory)
                    request.getSession().setAttribute("auth", user);
                    
                    // 3. Send to Home Page
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("login.jsp?status=failed");
                }
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}