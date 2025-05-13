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
    <script src="https://cdn.jsdelivr.net/npm/qtip2@3.0.3/dist/jquery.qtip.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/qtip2@3.0.3/dist/jquery.qtip.min.css" rel="stylesheet">
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
        #floating-buttons {
            position: fixed;
            bottom: 20px;
            right: 20px;
            display: flex;
            flex-direction: column;
            gap: 10px;
            z-index: 1000;
        }

        #floating-buttons.btn {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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
<!-- 两个按钮，一个用于滚动到顶部，一个用于滚动到底部 -->
<div id="floating-buttons">
    <button id="scrollToTop" class="btn btn-primary"><i class="bi bi-arrow-up"></i></button>
    <button id="scrollToBottom" class="btn btn-primary"><i class="bi bi-arrow-down"></i></button>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const scrollToTop = document.getElementById("scrollToTop");
        const scrollToBottom = document.getElementById("scrollToBottom");

        scrollToTop.addEventListener("click", function () {
            window.scrollTo({ top: 0, behavior: "smooth" });
        });

        scrollToBottom.addEventListener("click", function () {
            window.scrollTo({ top: document.body.scrollHeight, behavior: "smooth" });
        });
    });
</script>

<div class="container">
    <div class="search-container">
        <h1 class="search-title"><i class="bi bi-search"></i> Database Search</h1>
        <form method="get" action="<%=request.getContextPath()%>/search" class="search-form">
            <div class="form-floating">
                <select id="table" name="table" class="form-select">
                    <option value="drug">Drug</option>
                    <option value="gene_info">Gene</option>
                    <option value="disease_info">Disease</option>
                </select>
                <label for="table">Search Table</label>
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
            console.log("Starting visualization...");
            const elements = [];
            const nodeMap = new Map();

            <c:forEach var="relation" items="${relationships}">
            // 添加药物节点（如果存在）
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

            // 添加基因节点（如果存在）
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

            // 添加疾病节点（如果存在）
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

            // 添加药物-基因关系（如果两端节点都存在）
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

            // 添加基因-疾病关系（如果两端节点都存在）
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

            console.log("Elements to render:", elements);

            if (elements.length > 0) {
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

                // 添加鼠标悬停事件
                cy.on('mouseover', 'node', function (event) {
                    const node = event.target;
                    node.qtip({
                        content: `Type:` + node.data('type') + `<br>Name: ` + node.data('name'),
                        show: { event: event.type, ready: true },
                        hide: { event: 'mouseout' },
                        style: {
                            classes: 'qtip-bootstrap',
                            tip: { width: 10, height: 10 }
                        }
                    });
                });

                // 添加点击删除节点功能
                cy.on('tap', 'node', function (event) {
                    const node = event.target;
                    const nodeName = node.data('name') || 'Unknown';
                    const confirmDelete = confirm(`Are you sure you want to delete the node: `+ nodeName + ` ?`);
                    if (confirmDelete) {
                        // 删除节点及其相关的边
                        node.remove();

                        // 检查并删除没有边连接的节点
                        cy.nodes().forEach(n => {
                            if (n.degree() === 0) {
                                n.remove();
                            }
                        });

                        alert(`Node ` + nodeName +` and any disconnected nodes have been deleted.`);
                    }
                });

                // 添加布局切换功能
                document.getElementById('layoutSelect').addEventListener('change', function () {
                    const selectedLayout = this.value;
                    cy.layout({ name: selectedLayout }).run();
                });

                // 添加导出功能
                document.getElementById('exportButton').addEventListener('click', function () {
                    const pngData = cy.png();
                    const link = document.createElement('a');
                    link.href = pngData;
                    link.download = 'graph.png';
                    link.click();
                });
            } else {
                console.log("No elements to display");
                document.getElementById('cy').innerHTML = '<div style="text-align: center; padding: 20px;">No relationships found to visualize</div>';
            }
        }
    });
</script>
</body>
</html>