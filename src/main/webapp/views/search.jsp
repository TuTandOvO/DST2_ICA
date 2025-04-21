<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<html>
<head>
    <title>Search</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Search Database</h1>
    <!-- Search Form -->
    <form method="get" action="<%=request.getContextPath()%>/search" class="form-inline">
        <div class="form-group">
            <label for="keyword" class="sr-only">Keyword</label>
            <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Enter keyword">
        </div>
        <button type="submit" class="btn btn-primary ml-2">Search</button>
    </form>

    <hr>

    <!-- Display Search Results -->
    <c:choose>
        <c:when test="${not empty results}">
            <h2>Search Results:</h2>
            <table class="table table-striped">
                <thead>
                <tr>
                    <c:forEach var="columnName" items="${results[0].keySet()}">
                        <th>${fn:escapeXml(columnName)}</th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${results}">
                    <tr>
                        <c:forEach var="value" items="${row.values()}">
                            <td>${fn:escapeXml(value)}</td>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>No results found for "<strong>${fn:escapeXml(param.keyword)}</strong>".</p>
            <p>Keyword: ${param.keyword}</p>
            <p>Escaped Keyword: ${fn:escapeXml(param.keyword)}</p>
            <p>Keyword: ${param.keyword}</p>
            <p>Debug: Keyword is <c:out value="${param.keyword}" default="not set" /></p>
        </c:otherwise>
    </c:choose>
</div>
<script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>