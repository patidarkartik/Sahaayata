<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Sahaayata</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .login-card { margin-top: 100px; border: none; border-radius: 12px; }
        .card-header { background-color: #4F46E5; color: white; border-radius: 12px 12px 0 0 !important; }
        .btn-custom { background-color: #4F46E5; color: white; }
        .btn-custom:hover { background-color: #4338CA; color: white; }
    </style>
</head>
<body>

<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-5">
            <div class="card shadow login-card">
                <div class="card-header text-center py-3">
                    <h3 class="mb-0">Login</h3>
                </div>
                <div class="card-body p-4">

                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger text-center">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                    <form action="/login" method="post">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label fw-bold">Password</label>
                            <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
                        </div>

                        <div class="d-grid">
                            <button type="submit" class="btn btn-custom btn-lg">Login</button>
                        </div>
                    </form>

                </div>
                <div class="card-footer text-center py-3 bg-white">
                    <small class="text-muted">Don't have an account? <a href="/register" style="color: #4F46E5; text-decoration: none; font-weight: 600;">Register Here</a></small>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>