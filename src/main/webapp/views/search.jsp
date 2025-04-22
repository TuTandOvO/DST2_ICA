<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <title>Search</title>
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
</head>
<body>
<!-- 顶部导航栏 -->
<div class="navbar">
    <div><strong>DST2_ICA</strong></div>
    <div>
        <a href="<c:url value='/views/index.jsp'/>">Home</a>
        <a href="<c:url value='/views/help.jsp'/>">Help</a>
        <a href="<c:url value='/views/search.jsp'/>">Search</a>
    </div>
</div>
<div class="container">
    <div class="search-container">
        <h1 class="search-title"><i class="bi bi-search"></i> Database Search</h1>
        <form method="get" action="<%=request.getContextPath()%>/search" class="search-form">
            <div class="form-floating">
                <select id="database" name="database" class="form-select">
                    <option value="drug">Drug Database</option>
                    <option value="gene_info">Gene Database</option>
                    <option value="disease_info">Disease Database</option>
                </select>
                <label for="database">Database</label>
            </div>
            <div class="form-floating">
                <select id="table" name="table" class="form-select">
                    <option value="">All Tables</option>
                </select>
                <label for="table">Table</label>
            </div>
            <div class="form-floating">
                <input type="text" id="keyword" name="keyword" class="form-control" placeholder="Enter keyword" required>
                <label for="keyword">Search Keyword</label>
            </div>
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-search"></i> Search
            </button>
        </form>
    </div>

    <c:if test="${not empty results}">
        <div class="result-count">Found ${fn:length(results)} results</div>
        <div class="table-responsive">
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
        </div>
    </c:if>

    <c:if test="${not empty results && (database eq 'drug' || table eq 'drug' || table eq 'dosing_guideline' || table eq 'drug_label')}">
        <div id="cy"></div>
    </c:if>
</div>

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
<script>
    $(document).ready(function() {
        if (document.getElementById('cy')) {
            const elements = [];
            const nodeMap = new Map();

            // 添加药物节点
            <c:forEach var="row" items="${results}">
            const drugId = '${row.id}';
            if (!nodeMap.has(drugId)) {
                nodeMap.set(drugId, {
                    id: drugId,
                    name: '${row.name}',
                    type: 'Drug'
                });
                elements.push({
                    group: 'nodes',
                    data: nodeMap.get(drugId)
                });
            }
            </c:forEach>

            // 添加基因节点和关系
            <c:forEach var="relation" items="${drugGeneRelations}">
            const geneId = '${relation.gene_id}';
            if (!nodeMap.has(geneId)) {
                nodeMap.set(geneId, {
                    id: geneId,
                    name: '${relation.gene_name}',
                    type: 'Gene'
                });
                elements.push({
                    group: 'nodes',
                    data: nodeMap.get(geneId)
                });
            }

            // 添加药物-基因关系边
            elements.push({
                group: 'edges',
                data: {
                    id: '${relation.drug_id}_${relation.gene_id}',
                    source: '${relation.drug_id}',
                    target: geneId,
                    type: 'DrugGene'
                }
            });
            </c:forEach>

            const cy = cytoscape({
                container: document.getElementById('cy'),
                elements: elements,
                style: [
                    {
                        selector: 'node',
                        style: {
                            'label': 'data(name)',
                            'text-valign': 'center',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'text-wrap': 'wrap',
                            'text-max-width': '80px'
                        }
                    },
                    {
                        selector: 'node[type="Drug"]',
                        style: {
                            'background-color': '#6FB1FC',
                            'shape': 'hexagon'
                        }
                    },
                    {
                        selector: 'node[type="Gene"]',
                        style: {
                            'background-color': '#86B342',
                            'shape': 'rectangle'
                        }
                    },
                    {
                        selector: 'edge',
                        style: {
                            'width': 2,
                            'line-color': '#ccc',
                            'curve-style': 'bezier'
                        }
                    },
                    {
                        selector: 'edge[type="DrugGene"]',
                        style: {
                            'line-color': '#86B342',
                            'line-style': 'dashed'
                        }
                    }
                ],
                layout: {
                    name: 'cose',
                    padding: 50,
                    nodeRepulsion: 8000,
                    idealEdgeLength: 100,
                    animate: false
                }
            });
        }
    });
</script>
</body>
</html>