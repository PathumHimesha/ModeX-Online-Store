<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.shopping.dao.ProductDao" %>
<%@ page import="com.shopping.dao.DBConnection" %>
<%@ page import="com.shopping.model.*" %>
<%@ page import="java.util.*" %>

<%
    ProductDao pd = new ProductDao(DBConnection.getConnection());
    List<Product> products = pd.getAllProducts();
    User auth = (User) session.getAttribute("auth");

    // REVERSE LIST to show newest first
    if(products != null && !products.isEmpty()) {
        Collections.reverse(products);
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>MODEX | Premium Performance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        :root { --accent: #d32f2f; --bg: #000; --text: #fff; --border: rgba(255, 255, 255, 0.1); }
        
        body { background-color: var(--bg); color: var(--text); font-family: 'Inter', sans-serif; overflow-x: hidden; }
        h1, h2, h3, h4, .nav-link, .btn, .dropdown-item, .footer-title { font-family: 'Oswald', sans-serif; text-transform: uppercase; letter-spacing: 2px; }

        /* --- NAVIGATION --- */
        .navbar { padding: 25px 0; transition: all 0.4s ease; background: transparent; z-index: 1000; }
        .navbar.scrolled { background: rgba(0,0,0,0.95); padding: 15px 0; backdrop-filter: blur(10px); }
        .navbar-brand { font-size: 2rem; font-weight: 700; color: #fff !important; }
        .nav-link { color: #eee !important; font-size: 0.95rem; margin: 0 15px; position: relative; }
        .nav-link:hover { color: var(--accent) !important; }
        
        /* Profile Menu */
        .profile-glass-menu {
            background: rgba(15, 15, 15, 0.9) !important;
            backdrop-filter: blur(20px); border: 1px solid var(--border) !important;
            border-radius: 4px; min-width: 250px; box-shadow: 0 10px 30px rgba(0,0,0,0.5); margin-top: 15px;
        }

        /* --- HERO --- */
        .hero {
            height: 100vh;
            background: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=1920&auto=format&fit=crop');
            background-size: cover; background-position: center;
            display: flex; flex-direction: column; justify-content: center; align-items: center; text-align: center;
        }
        .hero-title-container { position: relative; cursor: default; }
        .hero-popup {
            position: absolute; top: -60px; left: 50%; transform: translateX(-50%) translateY(20px);
            background: rgba(255, 255, 255, 0.1); backdrop-filter: blur(15px); border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 10px 25px; border-radius: 50px; font-family: 'Inter', sans-serif; font-size: 0.8rem; font-weight: 600;
            color: #fff; letter-spacing: 1px; text-transform: uppercase; white-space: nowrap;
            opacity: 0; visibility: hidden; transition: all 0.4s; pointer-events: none;
        }
        .hero-title-container:hover .hero-popup { opacity: 1; visibility: visible; transform: translateX(-50%) translateY(0); }
        .hero-popup::after {
            content: ''; position: absolute; bottom: -6px; left: 50%; transform: translateX(-50%);
            border-width: 6px 6px 0; border-style: solid; border-color: rgba(255, 255, 255, 0.1) transparent transparent transparent;
        }

        .btn-modern {
            background: transparent; color: #fff; border: 1px solid #fff; padding: 15px 50px;
            font-size: 1.2rem; font-weight: 700; letter-spacing: 3px; transition: all 0.4s ease; position: relative; overflow: hidden; z-index: 1;
        }
        .btn-modern::before {
            content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%; background: #fff; transition: 0.4s; z-index: -1;
        }
        .btn-modern:hover { color: #000; border-color: #fff; }
        .btn-modern:hover::before { left: 0; }

        /* --- CATEGORIES --- */
        .category-box { height: 80vh; overflow: hidden; position: relative; cursor: pointer; }
        .category-img { width: 100%; height: 100%; object-fit: cover; transition: 1.2s cubic-bezier(0.19, 1, 0.22, 1); filter: brightness(0.6); }
        .category-box:hover .category-img { transform: scale(1.1); filter: brightness(0.8); }
        .category-overlay {
            position: absolute; inset: 0; display: flex; flex-direction: column; justify-content: flex-end; padding: 60px;
            background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.2) 50%, transparent 100%);
        }
        .category-title { font-size: 8rem; font-weight: 700; margin: 0; line-height: 0.9; transition: 0.5s; text-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .category-box:hover .category-title { color: var(--accent); transform: translateY(-10px); }
        .category-subtitle { letter-spacing: 5px; color: #ccc; text-transform: uppercase; font-size: 1rem; margin-top: 15px; font-weight: 600; }

        /* --- PRODUCT GRID --- */
        .product-card { background: transparent; border: none; margin-bottom: 60px; transition: 0.4s; cursor: pointer; }
        .img-container { position: relative; overflow: hidden; background: #111; }
        .product-img { width: 100%; height: 500px; object-fit: cover; transition: 0.6s; }
        .add-overlay {
            position: absolute; bottom: -50px; left: 0; width: 100%; background: #fff; 
            color: #000; text-align: center; padding: 15px; font-weight: 700; transition: 0.4s;
        }
        .product-card:hover .add-overlay { bottom: 0; }
        .product-card:hover { transform: translateY(-10px); }

        /* --- MODERN FOOTER --- */
        .modern-footer {
            background-color: #050505;
            border-top: 1px solid var(--border);
            padding-top: 80px;
            margin-top: 100px;
        }
        .footer-title { font-size: 1.2rem; margin-bottom: 25px; color: #fff; }
        /* VISIBILITY FIX: Changed to #ccc (light gray) instead of dark gray */
        .footer-text { color: #ccc; font-size: 0.9rem; line-height: 1.8; margin-bottom: 20px; }
        .footer-link { display: block; color: #999; text-decoration: none; margin-bottom: 15px; transition: 0.3s; font-size: 0.9rem; }
        .footer-link:hover { color: #fff; padding-left: 5px; }
        
        .social-icon { 
            width: 40px; height: 40px; border: 1px solid rgba(255,255,255,0.2); 
            display: inline-flex; align-items: center; justify-content: center; 
            color: #fff; text-decoration: none; margin-right: 10px; transition: 0.3s; 
        }
        .social-icon:hover { background: var(--accent); border-color: var(--accent); }
        .footer-bottom { border-top: 1px solid rgba(255,255,255,0.1); padding: 30px 0; margin-top: 60px; }
        
        /* Updated Visibility for Contact Info */
        .contact-info { color: #ddd !important; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top navbar-dark" id="mainNav">
        <div class="container">
            <a class="navbar-brand animate__animated animate__fadeInDown" href="index.jsp">MODE<span style="color:var(--accent)">X</span></a>
            
            <div class="collapse navbar-collapse justify-content-center">
                <ul class="navbar-nav animate__animated animate__fadeInDown">
                    <li class="nav-item"><a class="nav-link" href="index.jsp">HOME</a></li>
                    <li class="nav-item"><a class="nav-link" href="shop.jsp?category=Men">MEN</a></li>
                    <li class="nav-item"><a class="nav-link" href="shop.jsp?category=Women">WOMEN</a></li>
                    <li class="nav-item"><a class="nav-link" href="#contact-section">CONTACT</a></li>
                </ul>
            </div>

            <div class="d-flex align-items-center animate__animated animate__fadeInDown">
                <a href="cart.jsp" class="nav-link position-relative me-3">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span class="badge bg-danger rounded-pill position-absolute top-0 start-100 translate-middle" style="font-size: 0.6rem;">${cart_list.size()}</span>
                </a>

                <% if (auth != null) { %>
                    <div class="dropdown">
                        <a href="#" class="nav-link p-0 dropdown-toggle no-caret" id="userMenu" data-bs-toggle="dropdown">
                            <i class="fa-regular fa-user" style="font-size: 1.2rem;"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end profile-glass-menu animate__animated animate__fadeIn">
                            <li class="px-4 py-3 border-bottom border-secondary mb-2 text-start">
                                <div class="text-muted" style="font-size: 0.65rem; letter-spacing: 1px;">AUTHENTICATED USER</div>
                                <div class="fw-bold text-white Oswald" style="font-size: 1.1rem;"><%= auth.getName() %></div>
                                <div class="text-muted small" style="font-family: 'Inter'; text-transform: none; letter-spacing: 0;"><%= auth.getEmail() %></div>
                            </li>
                            <li><a class="dropdown-item" href="orders.jsp"><i class="fas fa-box-open me-2"></i> ORDER HISTORY</a></li>
                            <li><a class="dropdown-item" href="profile.jsp"><i class="fas fa-cog me-2"></i> ACCOUNT SETTINGS</a></li>
                            <li><hr class="dropdown-divider border-secondary"></li>
                            <li><a class="dropdown-item text-danger" href="log-out"><i class="fas fa-sign-out-alt me-2"></i> SIGN OUT</a></li>
                        </ul>
                    </div>
                <% } else { %>
                    <a href="login.jsp" class="nav-link"><i class="fa-regular fa-user"></i></a>
                <% } %>
            </div>
        </div>
    </nav>

    <header class="hero">
        <div class="hero-title-container animate__animated animate__fadeInUp">
            <h1 class="Oswald" style="font-size: 4rem;">ESTABLISHED<br>TO ENDURE</h1>
            <div class="hero-popup">
                <i class="fas fa-medal me-2" style="color: var(--accent);"></i> Premium Quality Since 2026
            </div>
        </div>
        <a href="shop.jsp" class="btn btn-modern animate__animated animate__fadeInUp animate__delay-1s Oswald mt-4">EXPLORE SHOP</a>
    </header>

    <div class="container-fluid px-0">
        <div class="row g-0">
            <div class="col-md-6 category-box" onclick="location.href='shop.jsp?category=Men'">
                <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=1200&auto=format&fit=crop" class="category-img">
                <div class="category-overlay">
                    <h2 class="category-title Oswald">MEN</h2>
                    <p class="category-subtitle">Performance Engineered</p>
                </div>
            </div>
            <div class="col-md-6 category-box" onclick="location.href='shop.jsp?category=Women'">
                <img src="https://images.unsplash.com/photo-1571731956672-f2b94d7dd0cb?q=80&w=1200&auto=format&fit=crop" class="category-img">
                <div class="category-overlay">
                    <h2 class="category-title Oswald">WOMEN</h2>
                    <p class="category-subtitle">Unrivaled Comfort</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-5 pt-5">
        <h2 class="text-center mb-5 Oswald" style="font-size: 3rem; font-weight: 700; letter-spacing: 10px;">LATEST DROPS</h2>
        <div class="row">
            <% 
            if(!products.isEmpty()) { 
                int count = 0; 
                for(Product p : products) { 
                    if(count >= 3) break; 
            %>
            <div class="col-lg-4 col-md-6">
                <div class="product-card" onclick="location.href='shop.jsp'">
                    <div class="img-container">
                        <img src="<%= p.getImage() %>" class="product-img">
                        <div class="add-overlay Oswald">View Details</div>
                    </div>
                    <div class="text-center mt-3">
                        <h5 class="m-0 Oswald"><%= p.getName() %></h5>
                        <p class="text-muted" style="color:#aaa !important;">LKR <%= String.format("%,.0f", p.getPrice()) %></p>
                    </div>
                </div>
            </div>
            <% 
                    count++;
                }
            } 
            %>
        </div>
    </div>

    <footer class="modern-footer" id="contact-section">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 mb-5 mb-lg-0">
                    <h4 class="footer-title">MODE<span style="color:var(--accent)">X</span></h4>
                    <p class="footer-text">
                        Engineered for those who demand excellence. ModeX combines high-performance materials with cutting-edge streetwear aesthetics. Established in 2026 to endure the toughest conditions.
                    </p>
                    <div class="mt-4">
                        <a href="https://www.instagram.com/modex.lk?igsh=MWVpcmFuaGdmNW12dw%3D%3D&utm_source=qr" target="_blank" class="social-icon">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="https://www.facebook.com/share/1DVZoQszjn/?mibextid=wwXIfr" target="_blank" class="social-icon">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 offset-lg-1 mb-5 mb-lg-0">
                    <h4 class="footer-title">DISCOVER</h4>
                    <a href="shop.jsp?category=Men" class="footer-link">Men's Collection</a>
                    <a href="shop.jsp?category=Women" class="footer-link">Women's Collection</a>
                    <a href="shop.jsp" class="footer-link">New Arrivals</a>
                    <a href="cart.jsp" class="footer-link">My Cart</a>
                </div>

                <div class="col-lg-4">
                    <h4 class="footer-title">CONTACT US</h4>
                    <p class="footer-text mb-4">Have questions? Our support team is ready to assist you 24/7.</p>
                    
                    <div class="d-flex align-items-start mb-3">
                        <i class="fas fa-map-marker-alt mt-1 me-3" style="color:var(--accent)"></i>
                        <span class="contact-info">8901 Marmora Road, Colombo 07, Sri Lanka</span>
                    </div>
                    <div class="d-flex align-items-center mb-3">
                        <i class="fas fa-phone-alt me-3" style="color:var(--accent)"></i>
                        <span class="contact-info">+94 77 123 4567</span>
                    </div>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-envelope me-3" style="color:var(--accent)"></i>
                        <a href="mailto:prasadhphs@gmail.com" class="contact-info" style="text-decoration:none;">prasadhphs@gmail.com</a>
                    </div>

                    <a href="mailto:prasadhphs@gmail.com" class="btn btn-outline-light rounded-0 mt-4 px-4" style="font-size: 0.8rem; letter-spacing: 2px;">SEND EMAIL</a>
                </div>
            </div>

            <div class="footer-bottom text-center">
                <p class="text-muted small mb-0" style="color:#666 !important;">&copy; 2026 MODEX INC. ALL RIGHTS RESERVED.</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://unpkg.com/scrollreveal"></script>
    <script>
        window.onscroll = function() {
            var nav = document.getElementById('mainNav');
            if (window.pageYOffset > 50) { nav.classList.add("scrolled"); } 
            else { nav.classList.remove("scrolled"); }
        };

        ScrollReveal().reveal('.category-box', { delay: 200, distance: '50px', origin: 'bottom', duration: 1000 });
        ScrollReveal().reveal('.product-card', { interval: 100, origin: 'bottom', distance: '30px' });
    </script>
</body>
</html>