<%--
  Created by IntelliJ IDEA.
  User: hello
  Date: 2019-12-3
  Time: 17:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Navigation Sidebar</title>
    <!-- 引入 Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <!-- 引入 Font Awesome 图标库 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <style>
        /* 为导航链接添加过渡动画 */
        .sidebar .nav-link {
            transition: all 0.3s ease;
        }
        /* 导航链接悬停时的样式 */
        .sidebar .nav-link:hover {
            background-color: #e9ecef;
            transform: translateX(5px);
        }
    </style>
</head>
<body>
<nav class="col-md-2 d-none d-md-block bg-light sidebar">
    <div class="sidebar-sticky">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class='nav-link ${param.active == "dashboard" ? "active" : ""}' href="<%=request.getContextPath()%>/">
                    <i class="fa-solid fa-house me-2"></i>
                    Dashboard <span class="sr-only">(current)</span>
                </a>
            </li>
            <li class="nav-item">
                <a class='nav-link ${param.active == "matching_index" ? "active" : ""}' href="<%=request.getContextPath()%>/matchingIndex">
                    <i class="fa-solid fa-file me-2"></i>
                    Matching
                </a>
            </li>
            <li class="nav-item">
                <a class='nav-link ${param.active == "samples" ? "active" : ""}' href="<%=request.getContextPath()%>/samples">
                    <i class="fa-solid fa-file me-2"></i>
                    Samples
                </a>
            </li>
            <li class="nav-item">
                <a class='nav-link ${param.active == "statistics" ? "active" : ""}' href="<%=request.getContextPath()%>/statistics">
                    <i class="fa-solid fa-chart-bar me-2"></i>
                    Query Summary
                </a>
            </li>
        </ul>
        <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
            <span>Precision Medicine Knowledge Base</span>
            <a class="d-flex align-items-center text-muted" href="#">
                <i class="fa-solid fa-circle-plus"></i>
            </a>
        </h6>
        <ul class="nav flex-column mb-2">
            <li class="nav-item">
                <a class='nav-link ${param.active == "drugs" ? "active" : ""}' href="<%=request.getContextPath()%>/drugs">
                    <i class="fa-solid fa-pills me-2"></i>
                    Drugs
                </a>
            </li>
            <li class="nav-item">
                <a class='nav-link ${param.active == "drug_labels" ? "active" : ""}' href="<%=request.getContextPath()%>/drugLabels">
                    <i class="fa-solid fa-file-medical me-2"></i>
                    Drug Labels
                </a>
            </li>
            <li class="nav-item">
                <a class='nav-link ${param.active == "dosing_guideline" ? "active" : ""}' href="<%=request.getContextPath()%>/dosingGuideline">
                    <i class="fa-solid fa-prescription-bottle me-2"></i>
                    Dosing Guideline
                </a>
            </li>
        </ul>
    </div>
</nav>
</body>
</html>