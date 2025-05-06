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
    <link href="<%=request.getContextPath()%>/static/css/app.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
        .border-bottom {
            border-bottom: none;
        }
    </style>
</head>
<body>
<jsp:include page="head.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="nav.jsp" >
            <jsp:param name="active" value="dashboard" />
        </jsp:include>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Dashboard</h2>
                <div>
                    <a href="${pageContext.request.contextPath}/views/search.jsp" class="btn btn-outline-info btn-sm">
                        Search
                    </a>
                    <a href="${pageContext.request.contextPath}/help" class="btn btn-outline-info btn-sm">
                        Help
                    </a>
                </div>
            </div>

            <!-- ✅ 统计卡片展示区 -->
            <div class="row text-center mb-4">
                <div class="col-md-4">
                    <a href="views/involvedGenesOverview.jsp" style="text-decoration: none;">
                        <div class="card shadow-sm border-primary"
                             style="transition: all 0.3s ease; cursor: pointer;"
                             onmouseover="this.style.transform='scale(1.03)'; this.style.boxShadow='0 0 15px rgba(0, 123, 255, 0.2)';"
                             onmouseout="this.style.transform='scale(1)'; this.style.boxShadow=''; ">
                            <div class="card-body">
                                <i class="bi bi-diagram-3 display-4 text-primary"></i>
                                <h5 class="card-title mt-2">Involved Genes</h5>
                                <p class="card-text display-4 text-primary">${geneCount}</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="views/dosingGuidelines.jsp" style="text-decoration: none;">
                        <div class="card shadow-sm border-success"
                             style="transition: all 0.3s ease; cursor: pointer;"
                             onmouseover="this.style.transform='scale(1.03)'; this.style.boxShadow='0 0 15px rgba(40, 167, 69, 0.2)';"
                             onmouseout="this.style.transform='scale(1)'; this.style.boxShadow=''; ">
                            <div class="card-body">
                                <i class="bi bi-capsule display-4 text-success"></i>
                                <h5 class="card-title mt-2">Dosing Guidelines</h5>
                                <p class="card-text display-4 text-success">${dosingCount}</p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-4">
                    <a href="views/diseases.jsp" style="text-decoration: none;">
                        <div class="card shadow-sm border-danger"
                             style="transition: all 0.3s ease; cursor: pointer;"
                             onmouseover="this.style.transform='scale(1.03)'; this.style.boxShadow='0 0 15px rgba(220, 53, 69, 0.2)';"
                             onmouseout="this.style.transform='scale(1)'; this.style.boxShadow=''; ">
                            <div class="card-body">
                                <i class="bi bi-heart-pulse display-4 text-danger"></i>
                                <h5 class="card-title mt-2">Diseases</h5>
                                <p class="card-text display-4 text-danger">${diseaseCount}</p>
                            </div>
                        </div>
                    </a>
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