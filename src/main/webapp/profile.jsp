<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ page import="com.shopping.model.User" %>
<%
    User auth = (User) session.getAttribute("auth");
    if (auth == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Profile | ModeX</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500;700&family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root { --accent: #d32f2f; --glass: rgba(255, 255, 255, 0.03); --border: rgba(255, 255, 255, 0.1); }
        body { font-family: 'Inter', sans-serif; background-color: #000; color: #fff; min-height: 100vh; }
        
        .Oswald { font-family: 'Oswald'; text-transform: uppercase; letter-spacing: 3px; }
        
        /* Glassmorphism Profile Card */
        .profile-container {
            max-width: 800px; margin: 100px auto;
            background: var(--glass);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border);
            border-radius: 4px;
            padding: 60px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }

        .profile-header { border-bottom: 1px solid var(--border); padding-bottom: 30px; margin-bottom: 40px; }
        .user-avatar { 
            width: 100px; height: 100px; background: #111; border: 1px solid var(--accent);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 2.5rem; color: var(--accent); margin-bottom: 20px;
        }

        .info-group { margin-bottom: 30px; }
        .info-label { color: #666; font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; margin-bottom: 8px; }
        .info-value { font-size: 1.2rem; font-weight: 400; color: #fff; }
        
        .badge-status { 
            display: inline-block; padding: 5px 15px; background: rgba(211, 47, 47, 0.1);
            color: var(--accent); border: 1px solid var(--accent); font-size: 0.7rem; font-weight: 700; border-radius: 2px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-dark py-4 fixed-top">
        <div class="container px-5">
            <a class="navbar-brand Oswald fw-bold text-white" href="index.jsp" style="text-decoration: none; font-size: 1.5rem;">
                MODE<span style="color:var(--accent)">X</span>
            </a>
            <a href="index.jsp" class="text-white small Oswald" style="text-decoration: none;"><i class="fas fa-chevron-left me-2"></i> Back</a>
        </div>
    </nav>

    <div class="container">
        <div class="profile-container animate__animated animate__fadeIn">
            <div class="profile-header text-center">
                <div class="d-flex justify-content-center">
                    <div class="user-avatar"><i class="fa-regular fa-user"></i></div>
                </div>
                <h2 class="Oswald fw-bold"><%= auth.getName() %></h2>
                <div class="badge-status Oswald">Verified Account</div>
            </div>

            <div class="row">
                <div class="col-md-6 info-group">
                    <div class="info-label">Full Identity</div>
                    <div class="info-value Oswald"><%= auth.getName() %></div>
                </div>
                <div class="col-md-6 info-group">
                    <div class="info-label">Contact Email</div>
                    <div class="info-value" style="color: #888;"><%= auth.getEmail() %></div>
                </div>
                <div class="col-md-6 info-group">
                    <div class="info-label">Account ID</div>
                    <div class="info-value">#MODEX-<%= auth.getId() %></div>
                </div>
                <div class="col-md-6 info-group">
                    <div class="info-label">Membership Tier</div>
                    <div class="info-value text-success Oswald" style="font-size: 1rem;">Premium Core</div>
                </div>
            </div>

            <div class="mt-5 pt-4 border-top border-secondary text-center">
                <a href="orders.jsp" class="btn btn-outline-light Oswald px-5 py-3" style="font-size: 0.8rem;">
                    View Order Records <i class="fas fa-arrow-right ms-2"></i>
                </a>
            </div>
        </div>
    </div>

</body>
</html>