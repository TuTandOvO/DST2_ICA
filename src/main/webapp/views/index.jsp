<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Dashboard Template · Bootstrap</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom styles for this template -->
    <link href="<%=request.getContextPath()%>/static/css/app.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>
</head>
<body>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Precision Medicine Matching System</a>

</nav>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="nav.jsp" >
            <jsp:param name="active" value="dashboard" />
        </jsp:include>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Dashboard</h2>
                <a href="${pageContext.request.contextPath}/help" class="btn btn-outline-info btn-sm">
                    Help
                </a>
            </div>

            <!-- ✅ 统计卡片展示区 -->
            <div class="row text-center mb-4">
                <div class="col-md-4">
                    <div class="card shadow-sm border-primary">
                        <div class="card-body">
                            <i class="bi bi-diagram-3 display-4 text-primary"></i>
                            <h5 class="card-title mt-2">Involved Genes</h5>
                            <p class="card-text display-4 text-primary">${geneCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm border-success">
                        <div class="card-body">
                            <i class="bi bi-capsule display-4 text-success"></i>
                            <h5 class="card-title mt-2">Dosing Guidelines</h5>
                            <p class="card-text display-4 text-success">${dosingCount}</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card shadow-sm border-danger">
                        <div class="card-body">
                            <i class="bi bi-heart-pulse display-4 text-danger"></i>
                            <h5 class="card-title mt-2">Diseases</h5>
                            <p class="card-text display-4 text-danger">${diseaseCount}</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 欢迎词 -->
            <div class="table-responsive">
                Welcome to use Precision Medicine Matching System
            </div>
        </main>
    </div>
</div>
</body>
</html>
