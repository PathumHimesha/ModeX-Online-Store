<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="com.shopping.dao.OrderDao" %>
<%@ page import="com.shopping.dao.DBConnection" %>
<%@ page import="com.shopping.model.Order" %>
<%@ page import="com.shopping.model.User" %>
<%@ page import="java.util.*" %>

<%
    DecimalFormat dcf = new DecimalFormat("#,###");
    User auth = (User) request.getSession().getAttribute("auth");
    List<Order> orders = null;
    
    if (auth != null) {
        OrderDao orderDao = new OrderDao(DBConnection.getConnection());
        orders = orderDao.userOrders(auth.getId());
    } else {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Orders | ModeX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { --accent: #d32f2f; --glass: rgba(255, 255, 255, 0.03); --border: rgba(255, 255, 255, 0.08); }
        
        body { font-family: 'Inter', sans-serif; background-color: #000; color: #fff; min-height: 100vh; overflow-x: hidden; }
        
        /* Premium Background with Depth */
        body::before {
            content: ""; position: fixed; inset: 0;
            background: radial-gradient(circle at top right, #1a0505, #000);
            z-index: -1;
        }

        .Oswald { font-family: 'Oswald'; text-transform: uppercase; letter-spacing: 2px; }
        
        /* Modern Navbar */
        .navbar { background: rgba(0,0,0,0.8); backdrop-filter: blur(10px); border-bottom: 1px solid var(--border); }
        .navbar-brand { font-size: 1.5rem; font-weight: 700; color: #fff !important; }

        /* Modern Order Card Layout instead of Table Rows */
        .order-card {
            background: var(--glass);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        .order-card:hover { 
            border-color: rgba(211, 47, 47, 0.4);
            transform: translateY(-3px);
            background: rgba(255, 255, 255, 0.05);
        }

        .label-muted { color: #666; font-size: 0.7rem; text-transform: uppercase; font-weight: 700; margin-bottom: 5px; }
        
        .status-pill {
            background: rgba(211, 47, 47, 0.1);
            color: var(--accent);
            border: 1px solid var(--accent);
            padding: 4px 12px;
            font-size: 0.75rem;
            border-radius: 20px;
            font-weight: 700;
        }

        .product-name { font-size: 1.2rem; font-weight: 700; margin-bottom: 0; color: #fff; }
        .price-tag { color: var(--accent); font-size: 1.4rem; font-weight: 700; }
        
        .empty-state { padding: 100px 0; opacity: 0.5; }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark sticky-top">
        <div class="container px-4">
            <a class="navbar-brand Oswald" href="index.jsp">MODE<span style="color:var(--accent)">X</span></a>
            <a class="nav-link text-white small Oswald" href="index.jsp">
                <i class="fas fa-arrow-left me-2"></i> Shop
            </a>
        </div>
    </nav>

    <div class="container py-5">
        <header class="text-center mb-5">
            <h1 class="Oswald fw-bold" style="font-size: 3rem; letter-spacing: 15px;">HISTORY</h1>
            <p class="text-muted small">Tracking your latest acquisitions</p>
        </header>

        <div class="row justify-content-center">
            <div class="col-lg-10">
                <% if(orders != null && !orders.isEmpty()){ 
                    for(Order o : orders){ %>
                    
                    <div class="order-card d-flex flex-wrap align-items-center">
                        <div class="col-md-2 mb-3 mb-md-0">
                            <div class="label-muted">Order Date</div>
                            <div class="Oswald" style="color: #888;"><%= o.getDate() %></div>
                        </div>

                        <div class="col-md-4 mb-3 mb-md-0">
                            <div class="label-muted">Item</div>
                            <div class="product-name Oswald"><%= o.getName() %></div>
                            <div class="text-muted small"><%= o.getCategory() %> • Qty: <%= o.getQuantity() %></div>
                        </div>

                        <div class="col-md-3 mb-3 mb-md-0">
                            <div class="label-muted">Shipping To</div>
                            <div class="small text-white">
                                <% if(o.getFirstName() != null) { %>
                                    <%= o.getFirstName() %> <%= o.getLastName() %><br>
                                    <span class="text-muted" style="font-size: 0.8rem;"><%= o.getCity() %></span>
                                <% } else { %>
                                    <span class="text-muted italic">No address provided</span>
                                <% } %>
                            </div>
                        </div>

                        <div class="col-md-3 text-md-end">
                            <div class="mb-2">
                                <span class="status-pill Oswald"><%= (o.getPaymentMethod() != null) ? o.getPaymentMethod() : "PENDING" %></span>
                            </div>
                            <div class="price-tag Oswald">LKR <%= dcf.format(o.getPrice()) %></div>
                        </div>
                    </div>

                <% } } else { %>
                    <div class="empty-state text-center">
                        <i class="fa-solid fa-ghost fa-3x mb-4"></i>
                        <h4 class="Oswald">Nothing to show here</h4>
                        <a href="index.jsp" class="btn btn-outline-danger mt-3 Oswald">Go Shopping</a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

</body>
</html>