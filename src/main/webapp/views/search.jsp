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
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- Cytoscape.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cytoscape/3.26.0/cytoscape.min.js"></script>
    <style>
        body {
            background-color: #f8f9fa;
        }
        .search-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-top: 2rem;
        }
        .form-control, .btn {
            border-radius: 8px;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.2rem rgba(0,123,255,0.25);
        }
        .search-title {
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        #cy {
            width: 100%;
            height: 600px;
            border-radius: 15px;
            border: none;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 2rem;
            background-color: #ffffff;
        }
        .table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            margin-top: 2rem;
        }
        .table thead {
            background-color: #f8f9fa;
        }
        .table th {
            border-top: none;
            font-weight: 600;
            color: #2c3e50;
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 0.5rem 1.5rem;
        }
        .btn-primary:hover {
            background-color: #0b5ed7;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        .search-form {
            display: flex;
            gap: 1rem;
            align-items: flex-end;
            flex-wrap: wrap;
        }
        .form-floating {
            flex: 1;
            min-width: 200px;
        }
        .result-count {
            color: #6c757d;
            font-size: 0.9rem;
            margin-top: 1rem;
        }
        .navbar {
            background-color: #2196f3;
            padding: 15px 30px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }
    </style>
    <%String column = request.getParameter("column");%>
</head>
<body>
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