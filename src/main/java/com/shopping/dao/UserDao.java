package com.shopping.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.shopping.model.User;

public class UserDao {
	private Connection con;
	private String query;
	private PreparedStatement pst;
	private ResultSet rs;

	public UserDao(Connection con) {
		this.con = con;
	}

	public boolean userRegister(User user) {
		boolean result = false;
		try {
			query = "insert into users (name, email, password) values(?,?,?)";
			pst = this.con.prepareStatement(query);
			pst.setString(1, user.getName());
			pst.setString(2, user.getEmail());
			pst.setString(3, user.getPassword());
			
			pst.executeUpdate();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}