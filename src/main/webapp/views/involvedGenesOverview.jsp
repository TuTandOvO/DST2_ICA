<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Involved Genes Overview</title>
  <!-- 引入项目已有的 Bootstrap 样式（确保路径正确） -->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
  <style>
    body {
      background: linear-gradient(to bottom right, #f0f0f0, #ffffff);
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    h1 {
      text-align: center;
      color: #2c3e50;
      font-weight: 700;
      margin-bottom: 20px;
    }

    p {
      line-height: 1.6;
      letter-spacing: 0.5px;
      color: #555;
    }

    .overview-section {
      margin: 15px 0;
      padding: 20px;
      background-color: #f8f9fa;
      border: 1px solid #e0e0e0;
      border-radius: 8px;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
      transition: box-shadow 0.3s ease;
      min-height: 250px;
    }

    .overview-section:hover {
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
    }

    h2 {
      color: #2c3e50;
      border-bottom: 2px solid #3498db;
      padding-bottom: 10px;
      margin-bottom: 15px;
      display: flex;
      align-items: center;
    }

    h2 i {
      margin-right: 10px;
    }

    @media (min-width: 0px) {
      .col-md-6 {
        flex: 0 0 auto;
        width: 50%;
        float: left;
      }
    }
  </style>
</head>
<body>
<div class="container mt-4">
  <h1 class="text-center mb-4">Involved Genes Overview</h1>
  <p class="text-lg leading-relaxed mb-4 text-center">
    It currently contains 1,437 genes that play a central role in key aspects of precision medicine such as
    disease diagnosis and drug response prediction, and is an important entry point for understanding
    individual medical differences.
  </p>
  <div class="row">
    <div class="col-md-6">
      <div class="overview-section">
        <h2><i class="fa-solid fa-dna"></i> Gene Count Statistics</h2>
        <p class="text-lg">
          This number (1,437) represents the total count of genes currently included in our precision medicine
          research framework. It reflects the extensive scope of genetic factors we analyze to tailor medical
          approaches to individual patients.
        </p>
      </div>
    </div>
    <div class="col-md-6">
      <div class="overview-section">
        <h2><i class="fa-solid fa-flask"></i> Functional Brief Introduction</h2>
        <p class="text-lg">
          These genes are actively involved in multiple biological processes critical to precision medicine.
          For example, some govern drug metabolism pathways, determining how patients respond to specific
          medications. Others influence disease susceptibility, helping identify individuals at higher risk
          for certain conditions, enabling earlier intervention and personalized prevention strategies.
        </p>
      </div>
    </div>
  </div>
</div>
</body>
</html>