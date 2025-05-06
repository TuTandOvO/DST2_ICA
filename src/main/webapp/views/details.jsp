<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Detail</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Detail Information</h1>
    <c:if test="${not empty detail}">
        <table class="table table-striped">
            <c:forEach var="entry" items="${detail.entrySet()}">
                <tr>
                    <th>${fn:escapeXml(entry.key)}</th>
                    <td>${fn:escapeXml(entry.value)}</td>
                </tr>
            </c:forEach>
        </table>
    </c:if>
    <c:if test="${empty detail}">
        <p>No detail found for the given ID.</p>
    </c:if>
</div>
</body>
</html>