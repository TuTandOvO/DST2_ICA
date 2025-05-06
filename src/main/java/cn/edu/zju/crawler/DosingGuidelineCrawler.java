package cn.edu.zju.crawler;

import cn.edu.zju.bean.DosingGuideline;
import cn.edu.zju.dao.DosingGuidelineDao;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.Map;

public class DosingGuidelineCrawler extends BaseCrawler {

    private static final Logger log = LoggerFactory.getLogger(DosingGuidelineCrawler.class);

    public static final String URL_BASE = "https://api.pharmgkb.org/v1/data%s";
    public static final String URL_GUIDELINES = "https://api.pharmgkb.org/v1/site/guidelinesByDrugs";

    private DosingGuidelineDao dosingGuidelineDao = new DosingGuidelineDao();

    public void doCrawlerDosingGuidelineList() {
        String content = this.getURLContent(URL_GUIDELINES);
        Gson gson = new Gson();
        Map drugLabels = gson.fromJson(content, Map.class);
        List<Map> data = (List<Map>) drugLabels.get("data");
        data.stream().forEach(x -> {
            log.info("{}", x);
            List.of("cpic", "cpnds", "dpwg", "fda", "pro").forEach(source -> {
                List<Map> guidelineList = (List<Map>) x.get(source);
                guidelineList.forEach(guideline -> {
                    String url = (String) guideline.get("url");
                    doCrawlerDosingGuideline(url);
                });
            });
        });
    }

    public void doCrawlerDosingGuideline(String url) {
        String content = this.getURLContent(String.format(URL_BASE, url));
        Gson gson = new Gson();
        Map guideline = gson.fromJson(content, Map.class);
        Map data = ((Map) guideline.get("data"));
        String id = (String) data.get("id");
        String objCls = (String) data.get("objCls");
        String name = (String) data.get("name");
        boolean recommendation = (Boolean) data.get("recommendation");
        String drugId = ((String) ((List<Map>) data.get("relatedChemicals")).get(0).get("id"));
        String source = (String) data.get("source");
        String summaryMarkdown = ((String) ((Map) data.get("summaryMarkdown")).get("html"));
        String textMarkdown = ((String) ((Map) data.get("textMarkdown")).get("html"));
        String raw = gson.toJson(guideline);
        DosingGuideline dosingGuideline = new DosingGuideline(id, objCls, name, recommendation, drugId, source, summaryMarkdown, textMarkdown, raw);
        if (!dosingGuidelineDao.existsById(id)) {
            dosingGuidelineDao.saveDosingGuideline(dosingGuideline);
            log.info("Saving dosing guideline: {}", id);
        } else {
            log.info("Dosing guideline exists, skipping: {}", id);
        }
    }

}
