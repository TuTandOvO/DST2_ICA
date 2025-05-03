<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <title>Diseases Overview</title>
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
      min-height: 250px; /* 设置最小高度统一布局 */
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
        float: left; /* 确保在小屏幕下也强制左浮动排版 */
      }
    }
  </style>
</head>
<body>
<div class="container mt-4">
  <h1>Diseases Overview</h1>
  <p class="text-lg leading-relaxed mb-4 text-center">
    Our system currently covers 564 diseases. Understanding these diseases from a precision medicine
    perspective is key to providing targeted prevention, diagnosis, and treatment strategies.
  </p>
  <div class="row">
    <div class="col-md-6">
      <div class="overview-section">
        <h2><i class="fa-solid fa-heartbeat"></i> Disease Count</h2>
        <p class="text-lg">
          The figure 564 represents the total number of diseases included in our precision medicine
          framework. It showcases the extensive scope of our research and data collection efforts.
        </p>
      </div>
    </div>
    <div class="col-md-6">
      <div class="overview-section">
        <h2><i class="fa-solid fa-stethoscope"></i> Precision Medicine Approach</h2>
        <p class="text-lg">
          For these 564 diseases, we apply a precision medicine approach. This involves analyzing genetic
          factors, environmental influences, and other individual - specific variables to develop
          personalized treatment plans, improving the prognosis and quality of life for patients.
        </p>
      </div>
    </div>
  </div>
</div>
</body>
</html>