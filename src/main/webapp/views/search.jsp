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
<!-- 顶部导航栏 -->
<div class="navbar">
    <div><strong>DST2_ICA</strong></div>
    <div>
        <a href="<c:url value='/views/index.jsp'/>">Home</a>
        <a href="<c:url value='/views/help.jsp'/>">Help</a>
        <a href="<c:url value='/views/search.jsp'/>">Search</a>
    </div>
</div>
<c:if test="${not empty relationships}">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="form-group">
            <label for="layoutSelect">Choose Layout:</label>
            <select id="layoutSelect" class="form-select">
                <option value="cose">COSE Layout</option>
                <option value="grid">Grid Layout</option>
                <option value="circle">Circle Layout</option>
                <option value="concentric">Concentric Layout</option>
                <option value="breadthfirst">Breadthfirst Layout</option>
            </select>
        </div>
        <button id="exportButton" class="btn btn-secondary">Export as PNG</button>
    </div>
    <div id="cy"></div>
</c:if>

<script>
    $(document).ready(function () {
        if (document.getElementById('cy')) {
            const elements = [];
            const nodeMap = new Map();

            <c:forEach var="relation" items="${relationships}">
            // Add Drug Node
            if ('${relation.drug_id}' && '${relation.drug_name}' && '${relation.drug_name}' !== 'null') {
                const drugId = 'drug_${relation.drug_id}';
                if (!nodeMap.has(drugId)) {
                    nodeMap.set(drugId, {
                        id: drugId,
                        name: '${relation.drug_name}',
                        type: 'Drug'
                    });
                    elements.push({
                        group: 'nodes',
                        data: nodeMap.get(drugId)
                    });
                }
            }

            // Add Gene Node
            if ('${relation.gene_id}' && '${relation.gene_symbol}' && '${relation.gene_symbol}' !== 'null') {
                const geneId = 'gene_${relation.gene_id}';
                if (!nodeMap.has(geneId)) {
                    nodeMap.set(geneId, {
                        id: geneId,
                        name: '${relation.gene_symbol}',
                        type: 'Gene'
                    });
                    elements.push({
                        group: 'nodes',
                        data: nodeMap.get(geneId)
                    });
                }
            }

            // Add Disease Node
            if ('${relation.disease_id}' && '${relation.disease_name}' && '${relation.disease_name}' !== 'null') {
                const diseaseId = 'disease_${relation.disease_id}';
                if (!nodeMap.has(diseaseId)) {
                    nodeMap.set(diseaseId, {
                        id: diseaseId,
                        name: '${relation.disease_name}',
                        type: 'Disease'
                    });
                    elements.push({
                        group: 'nodes',
                        data: nodeMap.get(diseaseId)
                    });
                }
            }

            // Add Drug-Gene Edge
            if ('${relation.drug_id}' && '${relation.gene_id}') {
                const drugId = 'drug_${relation.drug_id}';
                const geneId = 'gene_${relation.gene_id}';
                const edgeId = `dg_${relation.drug_id}_${relation.gene_id}`;

                if (nodeMap.has(drugId) && nodeMap.has(geneId)) {
                    elements.push({
                        group: 'edges',
                        data: {
                            id: edgeId,
                            source: drugId,
                            target: geneId,
                            type: 'DrugGene'
                        }
                    });
                }
            }

            // Add Gene-Disease Edge
            if ('${relation.gene_id}' && '${relation.disease_id}') {
                const geneId = 'gene_${relation.gene_id}';
                const diseaseId = 'disease_${relation.disease_id}';
                const edgeId = `gd_${relation.gene_id}_${relation.disease_id}`;

                if (nodeMap.has(geneId) && nodeMap.has(diseaseId)) {
                    elements.push({
                        group: 'edges',
                        data: {
                            id: edgeId,
                            source: geneId,
                            target: diseaseId,
                            type: 'GeneDisease'
                        }
                    });
                }
            }
            </c:forEach>

            const cy = cytoscape({
                container: document.getElementById('cy'),
                elements: elements,
                style: [
                    {
                        selector: 'node',
                        style: {
                            'label': 'data(name)',
                            'text-wrap': 'wrap',
                            'text-valign': 'center',
                            'text-halign': 'center',
                            'font-size': '12px',
                            'width': '60px',
                            'height': '60px',
                            'color': '#000000',
                            'text-outline-width': 2,
                            'text-outline-color': '#ffffff'
                        }
                    },
                    {
                        selector: 'node[type="Drug"]',
                        style: {
                            'background-color': '#6FB1FC',
                            'shape': 'hexagon',
                            'text-outline-color': '#6FB1FC'
                        }
                    },
                    {
                        selector: 'node[type="Gene"]',
                        style: {
                            'background-color': '#86B342',
                            'shape': 'rectangle',
                            'width': '80px',
                            'height': '40px',
                            'text-outline-color': '#86B342'
                        }
                    },
                    {
                        selector: 'node[type="Disease"]',
                        style: {
                            'background-color': '#FF6B6B',
                            'shape': 'diamond',
                            'text-outline-color': '#FF6B6B'
                        }
                    },
                    {
                        selector: 'edge',
                        style: {
                            'width': 2,
                            'curve-style': 'bezier',
                            'target-arrow-shape': 'triangle',
                            'arrow-scale': 1.5,
                            'line-color': '#ccc'
                        }
                    },
                    {
                        selector: 'edge[type="DrugGene"]',
                        style: {
                            'line-color': '#6FB1FC',
                            'target-arrow-color': '#6FB1FC'
                        }
                    },
                    {
                        selector: 'edge[type="GeneDisease"]',
                        style: {
                            'line-color': '#FF6B6B',
                            'target-arrow-color': '#FF6B6B'
                        }
                    }
                ],
                layout: {
                    name: 'cose',
                    padding: 50,
                    nodeRepulsion: 8000,
                    idealEdgeLength: 100,
                    animate: false,
                    randomize: true
                }
            });

            // Layout change
            document.getElementById('layoutSelect').addEventListener('change', function () {
                const selectedLayout = this.value;
                cy.layout({ name: selectedLayout }).run();
            });

            // Export graph
            document.getElementById('exportButton').addEventListener('click', function () {
                const pngData = cy.png();
                const link = document.createElement('a');
                link.href = pngData;
                link.download = 'graph.png';
                link.click();
            });
        }
    });
</script>
    <c:if test="${not empty results}">
    <div class="result-count">Found ${fn:length(results)} results</div>
    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
            <tr>
                <th>Drug ID</th>
                <th>Drug Name</th>
                <th>Gene Symbol</th>
                <th>Disease Name</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="row" items="${results}">
                <tr>
                    <td>${fn:escapeXml(row['Drug ID'])}</td>
                    <td>${fn:escapeXml(row['Drug Name'])}</td>
                    <td>${fn:escapeXml(row['Gene Symbol'])}</td>
                    <td>${fn:escapeXml(row['Disease Name'])}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    </c:if>

    <!-- 修改可视化图的显示条件 -->
    <c:if test="${not empty relationships}">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <div class="form-group">
            <label for="layoutSelect">Choose Layout:</label>
            <select id="layoutSelect" class="form-select">
                <option value="cose">COSE Layout</option>
                <option value="grid">Grid Layout</option>
                <option value="circle">Circle Layout</option>
                <option value="concentric">Concentric Layout</option>
                <option value="breadthfirst">Breadthfirst Layout</option>
            </select>
        </div>
        <button id="exportButton" class="btn btn-secondary">Export as PNG</button>
    </div>
    <div id="cy"></div>
    </c:if>
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