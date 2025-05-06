package cn.edu.zju.servlet;

import cn.edu.zju.controller.IndexController;
import cn.edu.zju.controller.KnowledgeBaseController;
import cn.edu.zju.controller.MatchingController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

public class DispatchServlet extends HttpServlet {

    private static final Logger log = LoggerFactory.getLogger(DispatchServlet.class);

    private ConcurrentHashMap<String, HttpConsumer<HttpServletRequest, HttpServletResponse>> getRequestMapping;
    private ConcurrentHashMap<String, HttpConsumer<HttpServletRequest, HttpServletResponse>> postRequestMapping;

    private HttpConsumer<HttpServletRequest, HttpServletResponse> notFound = (request, response) -> {
        try {
            response.getWriter().write("Not Found");
        } catch (IOException e) {
            log.info("", e);
        }
    };

    public class Dispatcher {
        public void registerGetMapping(String path, HttpConsumer<HttpServletRequest, HttpServletResponse> consumer) {
            getRequestMapping.put(path, consumer);
        }
        public void registerPostMapping(String path, HttpConsumer<HttpServletRequest, HttpServletResponse> consumer) {
            postRequestMapping.put(path, consumer);
        }
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        this.getRequestMapping = new ConcurrentHashMap<>();
        this.postRequestMapping = new ConcurrentHashMap<>();

        Dispatcher dispatcher = new Dispatcher();
        IndexController indexController = new IndexController();
        indexController.register(dispatcher);

        KnowledgeBaseController knowledgeBaseController = new KnowledgeBaseController();
        knowledgeBaseController.register(dispatcher);

        MatchingController matchingController = new MatchingController();
        matchingController.register(dispatcher);

    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = req.getPathInfo();
        log.info("{}: {}", req.getMethod(), pathInfo);
        super.service(req, resp);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = getPathInfo(req);
        HttpConsumer<HttpServletRequest, HttpServletResponse> consumer = getRequestMapping.getOrDefault(pathInfo, notFound);
        consumer.accept(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String pathInfo = getPathInfo(req);
        HttpConsumer<HttpServletRequest, HttpServletResponse> consumer = postRequestMapping.getOrDefault(pathInfo, notFound);
        consumer.accept(req, resp);
    }

    private String getPathInfo(HttpServletRequest req) {
        String pathInfo = req.getPathInfo();
        if (pathInfo == null) {
            pathInfo = "/";
        }
        return pathInfo;
    }
}
