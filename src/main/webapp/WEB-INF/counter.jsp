<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>Visitor Counter</title>
    <!-- Bootstrap CSS -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <style>
        .counter-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8f9fa;
        }
        .counter-card {
            text-align: center;
            padding: 2rem;
            border-radius: 1rem;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            background-color: white;
        }
        .counter-number {
            font-size: 4rem;
            font-weight: bold;
            color: #007bff;
            margin: 1rem 0;
        }
    </style>
</head>
<body>
<div class="container-fluid counter-container">
    <div class="counter-card">
        <h2>Welcome to Our Website</h2>
        <div class="counter-number">${visitCount}</div>
        <p class="lead">Total Visits</p>
    </div>
</div>

<!-- Bootstrap JS=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>