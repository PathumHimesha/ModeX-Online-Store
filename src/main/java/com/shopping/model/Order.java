package com.shopping.model;

public class Order extends Product {
    private int orderId;
    private int uid;
    private int quantity;
    private String date;
    
    // 1. IMPORTANT: Added Size Field so it can be saved to the database
    private String size; 
    
    // 2. NEW FIELDS FOR PREMIUM CHECKOUT
    private String firstName;
    private String lastName;
    private String address;
    private String city;
    private String phone;
    private String paymentMethod;

    public Order() {}

    // --- GETTER AND SETTER FOR SIZE ---
    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    // --- GETTERS AND SETTERS FOR CHECKOUT FIELDS ---
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPaymentMethod() { return paymentMethod; }
    public void setPaymentMethod(String paymentMethod) { this.paymentMethod = paymentMethod; }

    // --- EXISTING FIELDS ---
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getUid() { return uid; }
    public void setUid(int uid) { this.uid = uid; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}