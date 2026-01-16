package com.shopping.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    
    private static final String URL = "jdbc:mysql://localhost:3306/online_store";
    
    
    private static final String USER = "root"; 
    

    private static final String PASSWORD = "12345"; 

    public static Connection getConnection() {
        Connection connection = null;
        try {
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database Connected Successfully!");
        } catch (ClassNotFoundException e) {
            System.out.println("Error: MySQL Driver not found.");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("Error: Could not connect to the database.");
            System.out.println("Check your DB URL, Username, or Password in DBConnection.java");
            e.printStackTrace();
        }
        return connection;
    }
}