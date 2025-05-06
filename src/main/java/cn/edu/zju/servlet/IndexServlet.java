package cn.edu.zju.servlet;

import cn.edu.zju.dao.DiseaseDao;
import cn.edu.zju.dao.DosingDao;
import cn.edu.zju.dao.GeneDao;
import cn.edu.zju.filter.AuthenticationFilter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Enumeration;

@WebServlet(name = "IndexServlet", urlPatterns = {"/index"})
public class IndexServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 暂不处理 POST
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 打印 Session 用户信息
        Enumeration<String> attributeNames = request.getSession().getAttributeNames();
        System.out.println("print session");
        System.out.println(request.getSession().getAttribute(AuthenticationFilter.USERNAME));
        while (attributeNames.hasMoreElements()) {
            System.out.println(attributeNames.nextElement());
        }

        // ==== 数据库查询统计 ====
        GeneDao geneDao = new GeneDao();
        DosingDao dosingDao = new DosingDao();
        DiseaseDao diseaseDao = new DiseaseDao();

        int geneCount = geneDao.getGeneCount();  // 从 gene_info 表获取基因数
        int dosingCount = dosingDao.getDosageCount();  // 从 dosing_guideline 表获取行数
        int diseaseCount = diseaseDao.getDiseaseCount();  // 从 disease_info 表获取行数

        request.setAttribute("geneCount", geneCount);
        request.setAttribute("dosingCount", dosingCount);
        request.setAttribute("diseaseCount", diseaseCount);

        // 跳转到 index.jsp 展示页面
        request.getRequestDispatcher("/views/index.jsp").forward(request, response);
    }
}
