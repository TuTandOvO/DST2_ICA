<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Search</title>
    <link href="<%=request.getContextPath()%>/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <script src="<%=request.getContextPath()%>/static/jquery/jquery-3.4.1.js"></script>
    <script src="<%=request.getContextPath()%>/static/bootstrap/js/bootstrap.bundle.min.js"></script>
    <%String column = request.getParameter("column");%>
    <script>
        $(document).ready(function () {
            $('#table').change(function () {
                const selectedTable = $(this).val();
                if (selectedTable) {
                    $.ajax({
                        url: '<%=request.getContextPath()%>/getColumn', // 确保 URL 正确
                        method: 'GET',
                        data: { table: selectedTable },
                        success: function (data) {
                            console.log(data); // 打印从服务器返回的数据
                            const columnSelect = $('#column');
                            columnSelect.empty();
                            columnSelect.append('<option value="">All Columns</option>');
                            data.forEach(function (column) {
                                columnSelect.append('<option value="' + column + '">' + column + '</option>');
                            });
                        },
                        error: function (xhr, status, error) {
                            console.error("AJAX request failed:", status, error);
                            alert('Failed to load columns.');
                        }
                    });
                }
            });
        });
    </script>
</head>
<body>
<div class="container mt-5">
    <h1>Search Table</h1>
    <form method="get" action="<%=request.getContextPath()%>/search" class="form-inline">
        <div class="form-group">
            <label for="table" class="sr-only">Table</label>
            <select id="table" name="table" class="form-control">
                <option value="">Select Table</option>
                <option value="drug">Drug Table</option>
                <option value="gene_info">Gene Table</option>
                <option value="disease_info">Disease Table</option>
                <option value="disease_gene">Disease-Gene Table</option>
                <option value="drug_label">Drug Label Table</option>
                <option value="gene_drug">Gene-Drug Table</option>
                <option value="dosing_guideline">Dosing Guideline Table</option>

            </select>
        </div>
        <div class="form-group ml-2">
            <label for="column" class="sr-only">Column</label>
            <select id="column" name="column" class="form-control">
                <option value="">All Columns</option>
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
            <h2>Search Results in <strong>${fn:escapeXml(table)}</strong> - Column: <strong>${fn:escapeXml(column)}</strong>:</h2>
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
            <p>No results found for "<strong>${fn:escapeXml(keyword)}</strong>".</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>