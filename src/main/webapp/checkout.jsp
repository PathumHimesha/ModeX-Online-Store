<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.shopping.model.*" %>
<%@ page import="com.shopping.dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>

<%
    User auth = (User) session.getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    DecimalFormat dcf = new DecimalFormat("#,###");
    ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart_list");
    List<Cart> cartProduct = null;
    double total = 0;

    if (cart_list != null) {
        ProductDao pDao = new ProductDao(DBConnection.getConnection());
        cartProduct = pDao.getCartProducts(cart_list);
        total = pDao.getTotalCartPrice(cart_list);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Checkout | ModeX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body { background-color: #000; color: #fff; font-family: 'Inter', sans-serif; }
        .checkout-container { max-width: 1100px; margin: 0 auto; padding-top: 50px; }
        
        .section-title { font-size: 1.2rem; font-weight: 600; margin-bottom: 20px; margin-top: 30px; color: #ffffff !important; }
        .form-section { border-right: 1px solid #333; padding-right: 50px; }
        
        .form-control, .form-select {
            background-color: transparent; border: 1px solid #333; color: #fff;
            border-radius: 4px; padding: 12px; margin-bottom: 15px;
        }
        .form-control:focus { background-color: rgba(255,255,255,0.05); color: #fff; border-color: #d32f2f; box-shadow: none; }
        .form-control::placeholder { color: #666; }
        
        .secure-text { color: #888 !important; font-size: 0.9rem; margin-bottom: 20px; display: block; }

        .payment-box {
            border: 1px solid #333; border-radius: 6px; margin-bottom: 15px;
            transition: 0.3s; cursor: pointer; display: block; overflow: hidden;
            background: #050505;
        }
        
        .payment-box:hover { border-color: #555; }

        .payment-box.active {
            border-color: #d32f2f;
            background: #0a0a0a;
        }
        
        .payment-header { padding: 20px; display: flex; align-items: center; width: 100%; }
        
        input[type='radio'] { 
            accent-color: #d32f2f; width: 20px; height: 20px; margin-right: 15px; cursor: pointer;
        }

        .card-icons i { margin-left: 8px; font-size: 1.5rem; color: #fff; }

        #card-details {
            display: none;
            padding: 0 20px 20px 20px;
            animation: slideDown 0.3s ease-out;
        }
        
        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .summary-sidebar { padding-left: 50px; }
        .product-item { display: flex; align-items: center; margin-bottom: 20px; position: relative; }
        .product-img-wrapper { position: relative; width: 64px; height: 64px; border: 1px solid #333; border-radius: 8px; background: #111; }
        .product-img { width: 100%; height: 100%; object-fit: contain; padding: 5px; }
        
        .product-qty {
            position: absolute; top: -10px; right: -10px; background: #d32f2f;
            color: #fff; border-radius: 50%; width: 22px; height: 22px;
            font-size: 11px; display: flex; align-items: center; justify-content: center; font-weight: bold;
        }
        
        .btn-pay-now {
            background-color: #ffffff; color: #000000; border: none; font-weight: 700;
            padding: 20px; width: 100%; border-radius: 4px; margin-top: 30px; 
            text-transform: uppercase; letter-spacing: 2px; transition: 0.3s;
        }
        .btn-pay-now:hover { background-color: #d32f2f; color: #fff; }
    </style>
</head>
<body>

<div class="checkout-container">
    <div class="text-center mb-5">
        <h2 style="letter-spacing: 5px; font-weight: 700; color: #fff;">MODE<span style="color: #d32f2f;">X</span></h2>
    </div>

    <form action="cart-check-out" method="post">
        <div class="row g-0">
            <div class="col-lg-7 form-section">
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <span class="section-title m-0">Contact</span>
                    <span style="color: #aaa;" class="small">Logged in as <%= auth.getName() %></span>
                </div>
                <input type="email" class="form-control" name="email" value="<%= auth.getEmail() %>" readonly>

                <div class="section-title">Delivery</div>
                <select class="form-select mb-3" name="country">
                    <option selected>Sri Lanka</option>
                </select>
                
                <div class="row">
                    <div class="col"><input type="text" name="fname" class="form-control" placeholder="First name" required></div>
                    <div class="col"><input type="text" name="lname" class="form-control" placeholder="Last name" required></div>
                </div>
                <input type="text" name="address" class="form-control" placeholder="Shipping Address" required>
                <input type="text" name="city" class="form-control" placeholder="City" required>
                <input type="text" name="phone" class="form-control" placeholder="Mobile Number" required>

                <div class="section-title">Payment Method</div>
                <span class="secure-text">All transactions are secure and encrypted.</span>
                
                <div class="payment-box active" id="box-cod" onclick="selectPayment('cod')">
                    <div class="payment-header">
                        <input type="radio" name="payment_method" value="COD" id="radio-cod" checked>
                        <span style="color: #ffffff; font-weight: 600; font-size: 1.1rem;">Cash on Delivery (COD)</span>
                    </div>
                </div>

                <div class="payment-box" id="box-card" onclick="selectPayment('card')">
                    <div class="payment-header">
                        <input type="radio" name="payment_method" value="CARD" id="radio-card">
                        <span style="color: #ffffff; font-weight: 600; font-size: 1.1rem;">Credit / Debit Card</span>
                        
                        <div class="ms-auto card-icons">
                            <i class="fa-brands fa-cc-visa"></i>
                            <i class="fa-brands fa-cc-mastercard"></i>
                        </div>
                    </div>
                    
                    <div id="card-details">
                        <input type="text" class="form-control mb-3" placeholder="Card number">
                        <div class="row">
                            <div class="col-6"><input type="text" class="form-control" placeholder="Expiration (MM / YY)"></div>
                            <div class="col-6"><input type="text" class="form-control" placeholder="Security code"></div>
                        </div>
                        <input type="text" class="form-control mt-3" placeholder="Name on card">
                        
                        <div class="form-check mt-2">
                            <input class="form-check-input" type="checkbox" checked style="background-color: #d32f2f; border-color: #d32f2f;">
                            <label class="form-check-label small text-muted">Use shipping address as billing address</label>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn-pay-now">Complete My Order</button>
            </div>

            <div class="col-lg-5 summary-sidebar">
                <% if(cartProduct != null) { 
                    for(Cart c : cartProduct) { %>
                    <div class="product-item">
                        <div class="product-img-wrapper">
                            <img src="<%= c.getImage() %>" class="product-img">
                            <span class="product-qty"><%= c.getQuantity() %></span>
                        </div>
                        <div class="ms-3 flex-grow-1">
                            <div class="small fw-bold" style="color: #fff;"><%= c.getName() %></div>
                            <div class="text-muted small">
                                <%= c.getCategory() %>
                                <% if(c.getSize() != null) { %> | <%= c.getSize() %> <% } %>
                            </div>
                        </div>
                        <div class="small fw-bold" style="color: #fff;">LKR <%= dcf.format(c.getPrice()) %></div>
                    </div>
                <% } } %>

                <hr class="my-4" style="border-color: #444;">
                <div class="d-flex justify-content-between mb-2 small">
                    <span style="color: #bbb;">Subtotal</span>
                    <span style="color: #fff;">LKR <%= dcf.format(total) %></span>
                </div>
                <div class="d-flex justify-content-between mb-4 small">
                    <span style="color: #bbb;">Shipping</span>
                    <span class="text-success fw-bold">FREE</span>
                </div>
                <div class="d-flex justify-content-between align-items-center">
                    <span class="fw-bold text-white" style="font-size: 1.1rem;">Order Total</span>
                    <div class="d-flex align-items-center">
                        <span style="color: #bbb;" class="small me-2">LKR</span>
                        <h4 class="m-0 fw-bold" style="color: #ffffff; font-size: 1.8rem;">LKR <%= dcf.format(total) %></h4>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    function selectPayment(type) {
        document.getElementById('box-cod').classList.remove('active');
        document.getElementById('box-card').classList.remove('active');
        document.getElementById('card-details').style.display = 'none';

        if(type === 'card') {
            document.getElementById('box-card').classList.add('active');
            document.getElementById('radio-card').checked = true;
            document.getElementById('card-details').style.display = 'block';
        } else {
            document.getElementById('box-cod').classList.add('active');
            document.getElementById('radio-cod').checked = true;
        }
    }
</script>

</body>
</html>