package com.shopping.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.shopping.dao.UserDao;
import com.shopping.model.User;
import com.shopping.dao.DBConnection;

@WebServlet("/register-servlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String password = request.getParameter("password");

			User user = new User();
			user.setName(name);
			user.setEmail(email);
			user.setPassword(password);

			UserDao udao = new UserDao(DBConnection.getConnection());
			boolean result = udao.userRegister(user);

			if(result) {
				response.sendRedirect("login.jsp");
			} else {
				out.print("Registration Failed");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
