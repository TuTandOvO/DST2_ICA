package cn.edu.zju.controller;

import cn.edu.zju.dao.DiseaseDao;
import cn.edu.zju.dao.DosingDao;
import cn.edu.zju.dao.GeneDao;
import cn.edu.zju.servlet.DispatchServlet;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class IndexController {

    private static final Logger log = LoggerFactory.getLogger(IndexController.class);

    public void register(DispatchServlet.Dispatcher dispatcher) {
        dispatcher.registerGetMapping("/", this::index);
    }

    public void index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        GeneDao geneDao = new GeneDao();
        DosingDao dosingDao = new DosingDao();
        DiseaseDao diseaseDao = new DiseaseDao();

        int geneCount = geneDao.getGeneCount();  // 从 gene_info 表获取基因数
        int dosingCount = dosingDao.getDosageCount();  // 从 dosing_guideline 表获取行数
        int diseaseCount = diseaseDao.getDiseaseCount();  // 从 disease_info 表获取行数

        request.setAttribute("geneCount", geneCount);
        request.setAttribute("dosingCount", dosingCount);
        request.setAttribute("diseaseCount", diseaseCount);
        request.getRequestDispatcher("/views/index.jsp").forward(request, response);

    }
}
