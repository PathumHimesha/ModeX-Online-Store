package com.shopping.web;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Change the mapping to "/log-out" to match your index.jsp
 */
@WebServlet("/log-out")
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Destroy the session (Remove user login)
        if(request.getSession().getAttribute("auth") != null) {
            request.getSession().removeAttribute("auth");
            request.getSession().invalidate(); // Kill the session completely
        }
        
        // 2. Send back to Login Page
        response.sendRedirect("login.jsp");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}