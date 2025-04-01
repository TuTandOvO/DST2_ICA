<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List,java.util.Map" %>
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
    <%
        List<Map<String, String>> dataList = (List<Map<String, String>>) request.getAttribute("dataList");
        System.out.println("DataList size in JSP: " + (dataList != null ? dataList.size() : "null"));
    %>
    <table class="table table-striped table-bordered mt-3">
        <thead class="thead-dark">
        <tr>
            <%
                if (dataList != null && !dataList.isEmpty()) {
                    Map<String, String> firstRow = dataList.get(0);
                    for (String columnName : firstRow.keySet()) {
            %>
            <th><%= columnName %></th>
            <%
                    }
                }
            %>
        </tr>
        </thead>
        <tbody>
        <%
            if (dataList != null) {
                for (Map<String, String> row : dataList) {
        %>
        <tr>
            <%
                for (String value : row.values()) {
            %>
            <td><%= value %></td>
            <%
                }
            %>
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="<%= dataList != null && !dataList.isEmpty() ? dataList.get(0).size() : 1 %>">No data found</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
<!-- Bootstrap core JavaScript -->
<script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
</body>
</html>