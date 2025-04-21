<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<html>
<head>
    <title>Search</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1>Search Database</h1>
    <form method="get" action="<%=request.getContextPath()%>/search" class="form-inline">
        <div class="form-group">
            <label for="database" class="sr-only">Database</label>
            <select id="database" name="database" class="form-control">
                <option value="drug">Drug Database</option>
                <option value="gene_info">Gene Database</option>
                <option value="disease_info">Disease Database</option>
            </select>
        </div>
        <div class="form-group ml-2">
            <label for="table" class="sr-only">Table</label>
            <select id="table" name="table" class="form-control">
                <option value="">All Tables</option>
            </select>
        </div>
        <div class="form-group ml-2">
            <label for="keyword" class="sr-only">Keyword</label>
            <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Enter keyword" required>
        </div>
        <button type="submit" class="btn btn-primary ml-2">Search</button>
    </form>

    <hr>

    <c:choose>
        <c:when test="${not empty results}">
            <h2>Search Results in <strong>${fn:escapeXml(database)}</strong>
                <c:if test="${not empty table}"> - Table: <strong>${fn:escapeXml(table)}</strong></c:if>:
            </h2>
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
        </c:otherwise>
    </c:choose>
</div>
<script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.min.js"></script>
<script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
<script>
    $(document).ready(function () {
        $('#database').change(function () {
            const selectedDatabase = $(this).val();
            if (selectedDatabase) {
                $.ajax({
                    url: '<%=request.getContextPath()%>/getTables', // 修改为获取表名的Servlet
                    method: 'GET',
                    data: { database: selectedDatabase },
                    success: function (data) {
                        const tableSelect = $('#table');
                        tableSelect.empty();
                        tableSelect.append('<option value="">All Tables</option>');
                        data.forEach(function (table) {
                            tableSelect.append('<option value="' + table + '">' + table + '</option>');
                        });
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX request failed:", status, error);
                        alert('Failed to load tables.');
                    }
                });
            }
        });
    });
</script>
</body>
</html>