<%--
  Created by IntelliJ IDEA.
  User: 20538
  Date: 2025/4/1
  Time: 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<sql:setDataSource var="db"
                   driver="com.mysql.cj.jdbc.Driver"
                   url="jdbc:mysql://localhost:3306/biomed?serverTimezone=Asia/Shanghai&;useSSL=false"
                   user="biomed" password="biomed"/>
<sql:query dataSource="${db}" var="dataList">
    SELECT * from drug;
</sql:query>
<!DOCTYPE html>
<html>
<head>
    <title>Database Query Result</title>
    <!-- Bootstrap core CSS -->
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <h1 class="mt-5">Database Query Result</h1>
    <c:choose>
        <c:when test="${not empty dataList}">
            <table class="table table-striped table-bordered mt-3">
                <thead class="thead-dark">
                <tr>
                    <c:forEach var="columnName" items="${dataList[0].keySet()}">
                        <th>${columnName}</th>
                    </c:forEach>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="row" items="${dataList}">
                    <tr>
                        <c:forEach var="row" items="${dataList}">
                            <c:forEach var="column" items="${row}">
                                ${column}
                            </c:forEach>
                        </c:forEach>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p>No data found</p>
        </c:otherwise>
    </c:choose>
</div>
<!-- Bootstrap core JavaScript -->
<script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>
