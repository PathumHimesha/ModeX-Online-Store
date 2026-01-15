package com.shopping.model;

public class Cart extends Product {
    private int quantity;
    private String size; 

    public Cart() { }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    
    public String getSize() { return size; }
    public void setSize(String size) { this.size = size; }
}