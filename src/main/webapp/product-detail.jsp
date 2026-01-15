<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.dao.ProductDao" %>
<%@ page import="com.shopping.dao.DBConnection" %>
<%@ page import="com.shopping.model.Product" %>
<%
    String id = request.getParameter("id");
    ProductDao pd = new ProductDao(DBConnection.getConnection());
    Product p = pd.getSingleProduct(Integer.parseInt(id));
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= p.getName() %> | MODEX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400&display=swap" rel="stylesheet">
    <style>
        body { background-color: #000; color: #fff; font-family: 'Inter', sans-serif; }
        .product-container { margin-top: 100px; }
        .product-img { width: 100%; border-radius: 5px; }
        .product-title { font-family: 'Oswald', sans-serif; font-size: 3rem; text-transform: uppercase; }
        .price { font-size: 1.5rem; color: #888; margin-bottom: 20px; }
        .btn-add { background: #fff; color: #000; border: none; padding: 15px 40px; font-weight: 700; width: 100%; }
        .btn-add:hover { background: #d32f2f; color: #fff; }
    </style>
</head>
<body>
    <div class="container product-container">
        <div class="row">
            <div class="col-md-6">
                <img src="<%= p.getImage() %>" class="product-img">
            </div>
            <div class="col-md-6 px-5">
                <h1 class="product-title"><%= p.getName() %></h1>
                <p class="text-muted"><%= p.getCategory() %></p>
                <div class="price">LKR <%= String.format("%,.0f", p.getPrice()) %></div>
                <hr style="border-color: #333;">
                <p>This premium garment is engineered for high-performance training and lifestyle wear.</p>
                <a href="add-to-cart?id=<%= p.getId() %>" class="btn btn-add mt-4">ADD TO CART</a>
                <a href="index.jsp" class="btn btn-link text-white mt-3 d-block text-center">Back to Shop</a>
            </div>
        </div>
    </div>
</body>
</html>