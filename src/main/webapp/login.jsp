<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Online Store</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <style>
        html, body { height: 100%; margin: 0; padding: 0; width: 100%; }
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #000000;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            background-color: #121212;
            border: 1px solid #333;
            border-radius: 15px;
            box-shadow: 0 0 40px rgba(255, 255, 255, 0.05);
            width: 100%;
            max-width: 400px;
        }
        .card-header { background-color: transparent; border-bottom: none; padding-top: 30px; text-align: center; }
        .card-header h3 { font-weight: 600; color: #ffffff; margin-bottom: 5px; }
        .input-group-text { background-color: #1f1f1f; border: 1px solid #333; border-right: none; color: #fff; }
        .form-control { background-color: #1f1f1f; border: 1px solid #333; border-left: none; color: #fff; padding: 12px; }
        .form-control:focus { background-color: #1f1f1f; color: #fff; border-color: #555; box-shadow: none; }
        ::placeholder { color: #666 !important; opacity: 1; }
        .btn-login {
            background-color: #ffffff; color: #000000; border: none; border-radius: 10px; padding: 12px; font-weight: 600;
            transition: all 0.3s ease;
        }
        .btn-login:hover { background-color: #e0e0e0; transform: scale(1.02); }
        .register-link a { color: #ffffff; text-decoration: none; font-weight: 600; }
        .register-link a:hover { text-decoration: underline; color: #cccccc; }
        .text-muted { color: #aaaaaa !important; }
    </style>
</head>
<body>

    <div class="card p-4">
        <div class="card-header">
            <h3>Welcome Back</h3>
            <p class="text-muted small">Please login to continue</p>
        </div>
        
        <div class="card-body">
            <% if(request.getParameter("status") != null && request.getParameter("status").equals("success")) { %>
                <div class="alert alert-success text-center">Account Created! Please Login.</div>
            <% } %>
            
             <% if(request.getParameter("status") != null && request.getParameter("status").equals("failed")) { %>
                <div class="alert alert-danger text-center">Invalid Email or Password</div>
            <% } %>

            <form action="user-login" method="post">
                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="Email Address" required>
                </div>

                <div class="mb-3 input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-primary w-100 btn-login mt-3">LOGIN</button>
            </form>
        </div>

        <div class="card-footer text-center border-0 pb-3" style="background: transparent;">
            <p class="small mb-0 text-muted register-link">New here? <a href="register.jsp">Create Account</a></p>
        </div>
    </div>

</body>
</html>