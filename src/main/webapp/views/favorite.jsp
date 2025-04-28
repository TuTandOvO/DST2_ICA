<%--
  Created by IntelliJ IDEA.
  User: 30504
  Date: 2025/4/27
  Time: 19:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorites</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
<jsp:include page="head.jsp" />

<div class="container">
    <h2>Your Favorites</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>#</th>
            <th>Drug Name</th>
            <th>Drug URL</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${favorites}" var="favorite">
            <tr>
                <td>${favorite.id}</td>
                <td>${favorite.drugId}</td> <!-- Assuming you have a mapping for drugId -->
                <td>${favorite.createdAt}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
</html>
