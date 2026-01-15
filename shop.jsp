<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.shopping.dao.ProductDao" %>
<%@ page import="com.shopping.dao.DBConnection" %>
<%@ page import="com.shopping.model.*" %>
<%@ page import="java.util.*" %>

<%
    User auth = (User) session.getAttribute("auth");
    ProductDao pd = new ProductDao(DBConnection.getConnection());
    List<Product> products = pd.getAllProducts();
    
    String category = request.getParameter("category");
    String pageTitle = (category != null) ? category.toUpperCase() : "ALL COLLECTION";
    String subTitle = (category != null) ? "PREMIUM SELECTION / SEASON 2026" : "DISCOVER OUR FULL RANGE";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Shop <%= pageTitle %> | ModeX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>

    <style>
        :root { --accent: #d32f2f; --bg: #000; --text: #fff; --glass: rgba(255, 255, 255, 0.05); }
        
        body { background-color: var(--bg); color: var(--text); font-family: 'Inter', sans-serif; overflow-x: hidden; }
        
        /* FIX: Ensure all text is bright white */
        h1, h2, h3, h4, h5, p, span, div { color: #fff; }
        .text-muted { color: #aaa !important; } /* Lighter gray for visibility */

        body::before {
            content: ""; position: fixed; inset: 0;
            background: radial-gradient(circle at 20% 30%, #1a0505, transparent 60%),
                        radial-gradient(circle at 80% 80%, #050a1a, transparent 60%);
            z-index: -1;
        }

        h1, h2, h3, h5, .nav-link, .btn, .filter-link { font-family: 'Oswald', sans-serif; text-transform: uppercase; letter-spacing: 2px; }

        .navbar { background: rgba(0,0,0,0.8); backdrop-filter: blur(10px); border-bottom: 1px solid rgba(255,255,255,0.05); }
        .navbar-brand { font-size: 1.8rem; font-weight: 700; color: #fff !important; }
        
        .btn-back {
            color: #ccc; border: 1px solid rgba(255,255,255,0.1); padding: 10px 25px; 
            border-radius: 50px; text-decoration: none; transition: 0.3s; font-size: 0.8rem;
            display: inline-flex; align-items: center; background: rgba(0,0,0,0.3);
        }
        .btn-back:hover { color: #fff; border-color: #fff; background: rgba(255,255,255,0.05); }

        .filter-panel {
            background: var(--glass); backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.08); border-radius: 8px;
            padding: 30px; position: sticky; top: 100px;
        }
        .filter-title { font-size: 1.2rem; margin-bottom: 20px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 10px; color: #fff; }
        .filter-link {
            display: block; color: #bbb; padding: 12px 0; text-decoration: none; 
            transition: 0.3s; font-size: 1rem; border-bottom: 1px solid rgba(255,255,255,0.02);
        }
        .filter-link:hover, .filter-link.active { color: #fff; padding-left: 10px; color: var(--accent); }

        .product-card { background: transparent; border: none; margin-bottom: 50px; transition: 0.4s; cursor: pointer; }
        .img-container { position: relative; overflow: hidden; background: #111; border-radius: 2px; }
        .product-img { width: 100%; height: 400px; object-fit: cover; transition: 0.6s; }
        
        .add-overlay {
            position: absolute; bottom: -50px; left: 0; width: 100%; background: #fff; 
            color: #000 !important; text-align: center; padding: 15px; font-weight: 700; transition: 0.4s;
        }
        .product-card:hover .add-overlay { bottom: 0; }
        .product-card:hover .product-img { transform: scale(1.05); opacity: 0.8; }
        .product-card:hover { transform: translateY(-5px); }

        .price-tag { color: var(--accent) !important; font-weight: 700; font-size: 1.1rem; }

        /* --- PRODUCT QUICK VIEW MODAL CSS --- */
        .modal-content {
            background: #000;
            border: 1px solid rgba(255,255,255,0.2); 
            color: #fff; 
            border-radius: 0;
            box-shadow: 0 0 50px rgba(0,0,0,0.8);
        }
        .modal-header { border-bottom: 1px solid rgba(255,255,255,0.1); }
        .btn-close { filter: invert(1); opacity: 1; }
        .modal-img { width: 100%; height: 450px; object-fit: cover; }
        
        .modal-label {
            color: #ccc !important;
            font-size: 0.8rem;
            letter-spacing: 1px;
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
            font-family: 'Inter', sans-serif;
            text-transform: uppercase;
        }
        
        /* NEW PILL-SHAPED SIZE BUTTONS */
        .size-selector { display: flex; gap: 10px; flex-wrap: wrap; margin-bottom: 25px; }
        .size-btn {
            padding: 8px 20px;
            min-width: 60px;
            border: 1px solid rgba(255,255,255,0.4);
            border-radius: 30px;
            background: transparent; 
            color: #fff; 
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: 0.3s; 
            font-family: 'Inter', sans-serif; 
            font-weight: 600;
            font-size: 0.9rem;
        }
        .size-btn:hover { border-color: #fff; }
        .size-btn.active { 
            background: #fff; 
            color: #000 !important; 
            border-color: #fff; 
            font-weight: 800;
        }

        .qty-container {
            display: flex; align-items: center; border: 1px solid rgba(255,255,255,0.3);
            width: fit-content; margin-bottom: 30px;
            border-radius: 4px;
        }
        .qty-btn { background: transparent; border: none; color: #fff; width: 45px; height: 45px; font-size: 1.5rem; display: flex; align-items: center; justify-content: center; cursor: pointer; }
        .qty-input { background: transparent; border: none; color: #fff; width: 50px; text-align: center; font-weight: bold; font-size: 1.2rem; }
        .qty-btn:hover { color: var(--accent); background: rgba(255,255,255,0.05); }
        
        .btn-modal-add {
            background: var(--accent); color: #fff; border: none; width: 100%; padding: 18px;
            font-weight: 700; letter-spacing: 2px; transition: 0.3s; font-size: 1.1rem;
        }
        .btn-modal-add:hover { background: #b71c1c; }

        /* --- TOAST NOTIFICATION --- */
        #toast-box {
            visibility: hidden; min-width: 250px; background: rgba(20, 20, 20, 0.95);
            backdrop-filter: blur(10px); border: 1px solid var(--accent);
            color: #fff; text-align: center; border-radius: 4px; padding: 16px;
            position: fixed; z-index: 9999; right: 30px; bottom: 30px;
            font-family: 'Oswald', sans-serif; letter-spacing: 1px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5); transform: translateY(20px); transition: 0.4s;
        }
        #toast-box.show { visibility: visible; opacity: 1; transform: translateY(0); }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark sticky-top">
        <div class="container-fluid px-5">
            <a class="navbar-brand" href="index.jsp">MODE<span style="color:var(--accent)">X</span></a>
            
            <div class="d-flex align-items-center">
                <a href="cart.jsp" class="nav-link position-relative me-4 text-white">
                    <i class="fa-solid fa-bag-shopping"></i>
                    <span id="cart-badge" class="badge bg-danger rounded-pill position-absolute top-0 start-100 translate-middle" style="font-size: 0.6rem;">${cart_list.size()}</span>
                </a>
                
                <a href="<%= (auth != null) ? "profile.jsp" : "login.jsp" %>" class="nav-link text-white">
                    <i class="fa-regular fa-user"></i>
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid px-5 py-5">
        <div class="d-flex justify-content-between align-items-end mb-5 border-bottom border-secondary pb-4">
            <div>
                <h1 class="display-3 fw-bold mb-0 animate__animated animate__fadeInLeft"><%= pageTitle %></h1>
                <p class="text-muted small animate__animated animate__fadeInLeft animate__delay-1s" style="letter-spacing: 3px;"><%= subTitle %></p>
            </div>
            <a href="index.jsp" class="btn-back animate__animated animate__fadeInRight">
                <i class="fas fa-arrow-left me-2"></i> RETURN HOME
            </a>
        </div>

        <div class="row">
            <div class="col-lg-3 mb-5">
                <div class="filter-panel animate__animated animate__fadeInUp">
                    <h4 class="filter-title">FILTERS</h4>
                    <a href="shop.jsp" class="filter-link <%= (category == null) ? "active" : "" %>">VIEW ALL</a>
                    <a href="shop.jsp?category=Men" class="filter-link <%= ("Men".equals(category)) ? "active" : "" %>">MEN</a>
                    <a href="shop.jsp?category=Women" class="filter-link <%= ("Women".equals(category)) ? "active" : "" %>">WOMEN</a>
                    <a href="shop.jsp?category=Shoes" class="filter-link <%= ("Shoes".equals(category)) ? "active" : "" %>">SHOES</a>
                </div>
            </div>

            <div class="col-lg-9">
                <div class="row">
                    <% 
                    if(!products.isEmpty()) { 
                        for(Product p : products) {
                            if (category == null || category.equalsIgnoreCase(p.getCategory()) || category.equals("All Products")) {
                    %>
                    <div class="col-md-4 col-sm-6 animate__animated animate__fadeInUp">
                        <div class="product-card" 
                             onclick="openProductModal(this)"
                             data-id="<%= p.getId() %>"
                             data-name="<%= p.getName() %>"
                             data-price="<%= String.format("%,.0f", p.getPrice()) %>"
                             data-image="<%= p.getImage() %>"
                             data-category="<%= p.getCategory() %>">
                             
                            <div class="img-container">
                                <img src="<%= p.getImage() %>" class="product-img">
                                <div class="add-overlay Oswald">QUICK VIEW</div>
                            </div>
                            <div class="mt-3">
                                <h5 class="m-0 Oswald text-white"><%= p.getName() %></h5>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <span class="text-muted small"><%= p.getCategory() %></span>
                                    <span class="price-tag Oswald">LKR <%= String.format("%,.0f", p.getPrice()) %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <% 
                            }
                        }
                    } else { 
                    %>
                        <div class="col-12 text-center py-5">
                            <h3 class="text-muted">No products found.</h3>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="productModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title Oswald" style="letter-spacing: 2px;">PRODUCT DETAILS</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-0">
                    <div class="row g-0">
                        <div class="col-md-6">
                            <img src="" id="modalImg" class="modal-img">
                        </div>
                        <div class="col-md-6 p-5 d-flex flex-column justify-content-center">
                            
                            <div class="modal-label mb-1" id="modalCategory">CATEGORY</div>
                            
                            <h2 class="Oswald mb-3" style="font-size: 2.5rem;" id="modalName">PRODUCT NAME</h2>
                            <h3 class="Oswald text-danger mb-4" style="font-size: 1.8rem;" id="modalPrice">LKR 000</h3>
                            
                            <label class="modal-label" id="sizeLabel">AVAILABLE SIZE : -</label>
                            
                            <div class="size-selector" id="sizeContainer">
                                </div>

                            <label class="modal-label">QUANTITY</label>
                            <div class="qty-container">
                                <button class="qty-btn" onclick="updateQty(-1)">-</button>
                                <input type="text" id="modalQty" value="1" class="qty-input" readonly>
                                <button class="qty-btn" onclick="updateQty(1)">+</button>
                            </div>

                            <button class="btn btn-modal-add Oswald" onclick="addToCartFromModal()">
                                ADD TO BAG - <span id="modalTotal">LKR 000</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="toast-box"><i class="fas fa-check-circle me-2"></i> ITEM ADDED TO BAG</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let currentProductId = 0;
        let currentPrice = 0;

        const CLOTHING_SIZES = ['S', 'M', 'L', 'XL'];
        const SHOE_SIZES = ['EU40', 'EU41', 'EU42', 'EU43', 'EU44', 'EU45'];

        function openProductModal(element) {
            currentProductId = element.getAttribute("data-id");
            let name = element.getAttribute("data-name");
            let priceStr = element.getAttribute("data-price");
            let image = element.getAttribute("data-image");
            let category = element.getAttribute("data-category");

            currentPrice = parseInt(priceStr.replace(/,/g, ''));

            document.getElementById("modalName").innerText = name;
            document.getElementById("modalPrice").innerText = "LKR " + priceStr;
            document.getElementById("modalCategory").innerText = category;
            document.getElementById("modalImg").src = image;
            
            let sizeContainer = document.getElementById("sizeContainer");
            sizeContainer.innerHTML = "";
            
            let sizesToUse = CLOTHING_SIZES;
            if (category && category.toLowerCase().includes("shoes")) {
                sizesToUse = SHOE_SIZES;
            }

            sizesToUse.forEach((size, index) => {
                let btn = document.createElement("div");
                btn.className = "size-btn";
                btn.innerText = size;
                btn.onclick = function() { selectSize(this, size); };
                
                if (index === 0) {
                    btn.classList.add("active");
                    updateSizeLabel(size);
                }
                sizeContainer.appendChild(btn);
            });
            
            document.getElementById("modalQty").value = 1;
            updateModalTotal();

            var myModal = new bootstrap.Modal(document.getElementById('productModal'));
            myModal.show();
        }

        function selectSize(btn, sizeText) {
            let allBtns = document.getElementById("sizeContainer").children;
            for(let b of allBtns) {
                b.classList.remove("active");
            }
            btn.classList.add('active');
            updateSizeLabel(sizeText);
        }
        
        function updateSizeLabel(text) {
            document.getElementById("sizeLabel").innerText = "AVAILABLE SIZE : " + text;
        }

        function updateQty(change) {
            let input = document.getElementById("modalQty");
            let newVal = parseInt(input.value) + change;
            if(newVal >= 1) {
                input.value = newVal;
                updateModalTotal();
            }
        }

        function updateModalTotal() {
            let qty = parseInt(document.getElementById("modalQty").value);
            let total = currentPrice * qty;
            document.getElementById("modalTotal").innerText = "LKR " + total.toLocaleString();
        }

        function addToCartFromModal() {
            let qty = document.getElementById("modalQty").value;
            let sizeBtn = document.querySelector('.size-btn.active');
            let size = sizeBtn ? sizeBtn.innerText : "M";
            
            let url = "add-to-cart?id=" + currentProductId + "&quantity=" + qty + "&size=" + size;

            fetch(url)
                .then(response => {
                    if (response.url.includes("login.jsp")) {
                        window.location.href = "login.jsp";
                    } else {
                        var modalEl = document.getElementById('productModal');
                        var modal = bootstrap.Modal.getInstance(modalEl);
                        modal.hide();
                        showToast();
                        let badge = document.getElementById("cart-badge");
                        let count = parseInt(badge.innerText) || 0;
                        badge.innerText = count + 1;
                    }
                });
        }

        function showToast() {
            var x = document.getElementById("toast-box");
            x.className = "show";
            setTimeout(function(){ x.className = x.className.replace("show", ""); }, 3000);
        }
    </script>

</body>
</html>