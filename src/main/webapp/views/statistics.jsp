<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Visit Statistics - Precision Medicine Matching System</title>

    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- Custom styles -->
    <link href="<%=request.getContextPath()%>/static/css/app.css" rel="stylesheet">
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

        .nav-tabs {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="head.jsp" />

<div class="container-fluid">
    <div class="row">
        <jsp:include page="nav.jsp">
            <jsp:param name="active" value="statistics" />
        </jsp:include>

        <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
            <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
                <h2>Visit Statistics</h2>
                <div class="btn-toolbar mb-2 mb-md-0">
                    <div class="btn-group mr-2">
                        <button type="button" class="btn btn-sm btn-outline-secondary" id="refreshBtn">Refresh</button>
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title">Total Visits</h5>
                            <p class="card-text display-4">${totalVisits}</p>
                        </div>
                    </div>
                </div>
            </div>

            <ul class="nav nav-tabs" id="myTab" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" id="page-stats-tab" data-toggle="tab" href="#page-stats" role="tab"
                       aria-controls="page-stats" aria-selected="true">Page Visit Stats</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="recent-visits-tab" data-toggle="tab" href="#recent-visits" role="tab"
                       aria-controls="recent-visits" aria-selected="false">Recent Visits</a>
                </li>
            </ul>

            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="page-stats" role="tabpanel" aria-labelledby="page-stats-tab">
                    <div class="table-responsive">
                        <table class="table table-striped table-sm">
                            <thead>
                            <tr>
                                <th>Page Path</th>
                                <th>Visit Count</th>
                                <th>Percentage</th>
                                <th>Last Visit Time</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="pageVisit" items="${pageVisits}">
                                <tr>
                                    <td>${pageVisit.pagePath}</td>
                                    <td>${pageVisit.visitCount}</td>
                                    <td>
                                        <c:if test="${totalVisits > 0}">
                                            <fmt:formatNumber value="${pageVisit.visitCount * 100.0 / totalVisits}" maxFractionDigits="2"/>%
                                        </c:if>
                                        <c:if test="${totalVisits == 0}">0.00%</c:if>
                                    </td>
                                    <td><fmt:formatDate value="${pageVisit.lastVisitTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="tab-pane fade" id="recent-visits" role="tabpanel" aria-labelledby="recent-visits-tab">
                    <div class="table-responsive">
                        <table class="table table-striped table-sm">
                            <thead>
                            <tr>
                                <th>Page Path</th>
                                <th>IP Address</th>
                                <th>Visit Time</th>
                                <th>User</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="log" items="${recentLogs}">
                                <tr>
                                    <td>${log.pagePath}</td>
                                    <td>${log.ipAddress}</td>
                                    <td><fmt:formatDate value="${log.visitTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td>${log.username != null ? log.username : 'Guest'}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Refresh button click event
        $('#refreshBtn').click(function() {
            location.reload();
        });
    });
</script>
</body>
</html>
