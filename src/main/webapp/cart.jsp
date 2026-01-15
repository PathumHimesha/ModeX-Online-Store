<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.shopping.dao.ProductDao" %>
<%@ page import="com.shopping.dao.DBConnection" %>
<%@ page import="com.shopping.model.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    DecimalFormat dcf = new DecimalFormat("#,###");
    request.setAttribute("dcf", dcf);
    User auth = (User) session.getAttribute("auth");
    
    // Initialize Cart List
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart_list");
    List<Cart> cartProduct = null;
    double total = 0;
    
    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DBConnection.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        total = pDao.getTotalCartPrice(cart_list);
        request.setAttribute("cart_list", cart_list);
        request.setAttribute("total", total);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shopping Bag | ModeX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        :root { --accent: #d32f2f; --bg: #000; --text: #fff; --glass: rgba(255, 255, 255, 0.03); --border: rgba(255, 255, 255, 0.1); }
        
        body { background-color: var(--bg); color: var(--text); font-family: 'Inter', sans-serif; overflow-x: hidden; min-height: 100vh; display: flex; flex-direction: column; }
        
        /* Atmospheric Background */
        body::before {
            content: ""; position: fixed; inset: 0;
            background: radial-gradient(circle at 50% 50%, #111 0%, #000 70%);
            z-index: -1;
        }

        h1, h2, h3, h4, .nav-link, .btn, .table-header { font-family: 'Oswald', sans-serif; text-transform: uppercase; letter-spacing: 2px; }

        /* --- VISIBILITY FIXES --- */
        /* Make muted text lighter so it is visible on black */
        .text-muted { color: #bbb !important; }
        /* Ensure table text is always white */
        .table { color: #fff !important; --bs-table-bg: transparent; vertical-align: middle; }
        .table td { color: #fff !important; border-bottom: 1px solid rgba(255,255,255,0.02); padding: 20px 0; }
        .table th { border-bottom: 1px solid var(--border); color: #888; font-weight: 400; font-size: 0.8rem; padding-bottom: 15px; }

        /* --- NAVIGATION --- */
        .navbar { background: rgba(0,0,0,0.8); backdrop-filter: blur(10px); border-bottom: 1px solid var(--border); }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; color: #fff !important; }

        /* --- EMPTY CART STATE --- */
        .empty-cart-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 100px 20px;
        }
        
        .floating-icon {
            font-size: 5rem;
            color: #222;
            margin-bottom: 30px;
            animation: float 4s ease-in-out infinite;
            text-shadow: 0 20px 30px rgba(0,0,0,0.5);
        }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }

        .empty-title { font-size: 3rem; font-weight: 700; margin-bottom: 15px; color: #fff; }
        .empty-subtitle { color: #666; font-size: 1rem; margin-bottom: 40px; letter-spacing: 1px; }

        /* --- MODERN BUTTON --- */
        .btn-modern {
            background: transparent; color: #fff; border: 1px solid #fff; padding: 12px 40px;
            font-size: 1rem; font-weight: 700; letter-spacing: 2px; transition: all 0.4s ease; position: relative; overflow: hidden; text-decoration: none;
        }
        .btn-modern::before {
            content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: #fff; transition: 0.4s; z-index: -1;
        }
        .btn-modern:hover { color: #000; border-color: #fff; }
        .btn-modern:hover::before { left: 0; }

        /* --- CART TABLE (If items exist) --- */
        .glass-panel {
            background: var(--glass); backdrop-filter: blur(10px); border: 1px solid var(--border);
            border-radius: 4px; padding: 30px; margin-top: 40px;
        }
        
        .cart-product-img { width: 80px; height: 80px; object-fit: cover; border-radius: 4px; filter: brightness(0.9); }
        
        .quantity-controls a {
            color: #fff; text-decoration: none; width: 30px; height: 30px; display: inline-flex;
            align-items: center; justify-content: center; border: 1px solid var(--border); transition: 0.3s;
        }
        .quantity-controls a:hover { background: #fff; color: #000; }
        .quantity-input {
            width: 40px; text-align: center; background: transparent; border: none; color: #fff; font-weight: 700;
        }
        
        .btn-remove { color: #666; font-size: 0.8rem; text-decoration: none; transition: 0.3s; }
        .btn-remove:hover { color: var(--accent); }
        
        .total-section { text-align: right; margin-top: 30px; padding-top: 20px; border-top: 1px solid var(--border); }
        .total-price { font-size: 2rem; color: var(--accent); font-weight: 700; }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark">
        <div class="container px-4">
            <a class="navbar-brand" href="index.jsp">MODE<span style="color:var(--accent)">X</span></a>
            <a href="shop.jsp" class="nav-link text-white small" style="letter-spacing: 1px;">
                <i class="fas fa-arrow-left me-2"></i> CONTINUE SHOPPING
            </a>
        </div>
    </nav>

    <div class="container mb-5">
        <% if (cart_list != null && cartProduct != null && !cartProduct.isEmpty()) { %>
            
            <h2 class="mt-5 mb-0 animate_animated animate_fadeInLeft">YOUR BAG</h2>
            <p class="text-muted small animate_animated animate_fadeInLeft"><%= cart_list.size() %> Items ready for checkout</p>
            
            <div class="glass-panel animate_animated animate_fadeInUp">
                <table class="table">
                    <thead>
                        <tr>
                            <th width="45%">PRODUCT</th>
                            <th width="15%">PRICE</th>
                            <th width="20%">QUANTITY</th>
                            <th width="20%" class="text-end">TOTAL</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Cart c : cartProduct) { %>
                        <tr>
                            <td>
                                <div class="d-flex align-items-center">
                                    <img src="<%= c.getImage() %>" class="cart-product-img me-3">
                                    <div>
                                        <div class="fw-bold Oswald" style="font-size: 1.1rem;"><%= c.getName() %></div>
                                        
                                        <div class="small text-muted mb-2">
                                            <%= c.getCategory() %>
                                            <% if(c.getSize() != null) { %>
                                                <span class="ms-2 text-white" style="opacity:0.8;">| SIZE: <%= c.getSize() %></span>
                                            <% } %>
                                        </div>
                                        
                                        <a href="remove-from-cart?id=<%= c.getId() %>" class="btn-remove">REMOVE</a>
                                    </div>
                                </div>
                            </td>
                            <td class="Oswald">LKR <%= dcf.format(c.getPrice()) %></td>
                            <td>
                                <div class="quantity-controls">
                                    <a href="quantity-inc-dec?action=dec&id=<%= c.getId() %>"><i class="fas fa-minus small"></i></a>
                                    <input type="text" value="<%= c.getQuantity() %>" class="quantity-input" readonly>
                                    <a href="quantity-inc-dec?action=inc&id=<%= c.getId() %>"><i class="fas fa-plus small"></i></a>
                                </div>
                            </td>
                            <td class="text-end fw-bold Oswald">LKR <%= dcf.format(c.getPrice() * c.getQuantity()) %></td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>

                <div class="total-section">
                    <div class="text-muted small mb-1">SUBTOTAL</div>
                    <div class="total-price Oswald mb-4">LKR <%= dcf.format(total) %></div>
                    <a href="checkout.jsp" class="btn btn-modern">PROCEED TO CHECKOUT</a>
                </div>
            </div>

        <% } else { %>
            
            <div class="empty-cart-container animate_animated animate_fadeIn">
                <i class="fa-solid fa-bag-shopping floating-icon"></i>
                
                <h1 class="empty-title Oswald">YOUR BAG IS EMPTY</h1>
                <p class="empty-subtitle">Looks like you haven't made your choice yet.</p>
                
                <a href="shop.jsp" class="btn btn-modern">
                    BROWSE COLLECTION
                </a>
            </div>
            
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>