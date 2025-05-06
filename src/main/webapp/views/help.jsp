<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Help - DST2_ICA Project</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f9f9f9;
            margin: 0;
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
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 800px;
            margin: 40px auto;
        }
        h1, h2 {
            text-align: center;
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #e0e0e0;
        }
        .section {
            margin-top: 30px;
        }
        .highlight {
            background: #e8f4ff;
            padding: 10px;
            border-left: 5px solid #2196f3;
        }
        img.avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            vertical-align: middle;
            margin-right: 10px;
        }
    </style>
</head>
<body>

<!-- 🔵 顶部导航栏 -->
<div class="navbar">
    <div><strong>DST2_ICA</strong></div>
    <div>
        <a href="<c:url value='/views/index.jsp'/>">Home</a>
        <a href="<c:url value='/views/help.jsp'/>">Help</a>
        <a href="<c:url value='/views/search.jsp'/>">Search</a>
    </div>
</div>

<div class="container">
    <h1>📘 Help - DST2_ICA Project</h1>

    <div class="section">
        <h2>🧪 Project Founder</h2>
        <div class="highlight">
            <img class="avatar" src="https://avatars.githubusercontent.com/simonchen79" />
            <a href="https://github.com/simonchen79" target="_blank">Chen Xin (simonchen79)</a>
        </div>
    </div>

    <div class="section">
        <h2>👑 Group Leader</h2>
        <div class="highlight">
            <img class="avatar" src="https://avatars.githubusercontent.com/TuTandOvO" />
            <a href="https://github.com/TuTandOvO" target="_blank">Ren Yixiang (TuTandOvO)</a>
        </div>
    </div>

    <div class="section">
        <h2>🤝 Collaborators</h2>
        <table>
            <tr>
                <th>Avatar</th>
                <th>Name</th>
                <th>GitHub</th>
            </tr>
            <tr>
                <td><img class="avatar" src="https://avatars.githubusercontent.com/CATbutNotCatalyzer" /></td>
                <td>Zhu Yichen</td>
                <td><a href="https://github.com/CATbutNotCatalyzer" target="_blank">CATbutNotCatalyzer</a></td>
            </tr>
            <tr>
                <td><img class="avatar" src="https://avatars.githubusercontent.com/IrisAugustus" /></td>
                <td>Jiang Ruiying</td>
                <td><a href="https://github.com/IrisAugustus" target="_blank">IrisAugustus</a></td>
            </tr>
            <tr>
                <td><img class="avatar" src="https://avatars.githubusercontent.com/Chen3142" /></td>
                <td>Chen Shutong</td>
                <td><a href="https://github.com/Chen3142" target="_blank">Chen3142</a></td>
            </tr>
            <tr>
                <td><img class="avatar" src="https://avatars.githubusercontent.com/sijunpeng123" /></td>
                <td>Peng Sijun</td>
                <td><a href="https://github.com/sijunpeng123" target="_blank">sijunpeng123</a></td>
            </tr>
        </table>
    </div>

    <div class="section">
        <h2>📂 Source Code</h2>
        <p class="highlight">
            <a href="https://github.com/TuTandOvO/DST2_ICA" target="_blank">https://github.com/TuTandOvO/DST2_ICA</a>
        </p>
    </div>

    <div class="section">
        <h2>🧬 Database Source</h2>
        <p class="highlight">
            <a href="https://www.pharmgkb.org" target="_blank">https://www.pharmgkb.org</a>
        </p>
    </div>
</div>
</body>
</html>