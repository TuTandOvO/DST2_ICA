package cn.edu.zju.crawler;

import cn.edu.zju.bean.Drug;
import cn.edu.zju.bean.DrugLabel;
import cn.edu.zju.dao.DrugDao;
import cn.edu.zju.dao.DrugLabelDao;
import cn.edu.zju.dbutils.DBUtils;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public class DrugLabelCrawler extends BaseCrawler {

    private static final Logger log = LoggerFactory.getLogger(DrugLabelCrawler.class);

    public static final String URL_DRUG_LABEL = "https://api.pharmgkb.org/v1/site/labelsByDrug";
    public static final String URL_DRUG_LABEL_DETAIL = "https://api.pharmgkb.org/v1/site/page/drugLabels/%s?view=base";

    private DrugDao drugDao = new DrugDao();
    private DrugLabelDao drugLabelDao = new DrugLabelDao();

    public void doCrawlerDrug() {
        String content = this.getURLContent(URL_DRUG_LABEL);
        Gson gson = new Gson();
        Map drugLabels = gson.fromJson(content, Map.class);
        List<Map> data = (List<Map>) drugLabels.get("data");
        data.stream().forEach(x -> {
            log.info("{}", x);
            Map drug = ((Map) x.get("drug"));
            String id = (String) drug.get("id");
            String name = (String) drug.get("name");
            String objCls = (String) drug.get("objCls");
            String drugUrl = (String) x.get("drugUrl");
            boolean biomarker = ((Boolean) x.get("biomarker"));
            Drug drugBean = new Drug(id, name, biomarker, drugUrl, objCls);

            drugDao.saveDrug(drugBean);
        });
    }

    public void doCrawlerDrugLabel() {

        DBUtils.execSQL(connection -> {
            try {
                PreparedStatement preparedStatement = connection.prepareStatement("select * from drug");
                ResultSet resultSet = preparedStatement.executeQuery();
                while (resultSet.next()) {
                    String id = resultSet.getString("id");
                    String content = this.getURLContent(String.format(URL_DRUG_LABEL_DETAIL, id));
                    Gson gson = new Gson();
                    Map result = gson.fromJson(content, Map.class);
                    Map data = (Map) result.get("data");
                    List<Map> drugLabels = (List<Map>) data.get("drugLabels");
                    log.info("Fetch label of drug {}", id);
                    drugLabels.stream().forEach(x -> {
                        log.info("Going to save label: {}", (String) x.get("id"));
                        String labelId = (String) x.get("id");
                        String name = (String) x.get("id");
                        String objCls = (String) x.get("objCls");
                        boolean alternateDrugAvailable = (Boolean) x.get("alternateDrugAvailable");
                        boolean dosingInformation = (Boolean) x.get("dosingInformation");
                        String prescribingMarkdown = "";
                        if (x.containsKey("prescribingMarkdown")) {
                            prescribingMarkdown = ((String) ((Map) x.get("prescribingMarkdown")).get("html"));
                        }
                        String source = (String) x.get("source");
                        String textMarkdown = ((String) ((Map) x.get("textMarkdown")).get("html"));
                        String summaryMarkdown = ((String) ((Map) x.get("summaryMarkdown")).get("html"));
                        String raw = gson.toJson(x);
                        String drugId = ((String) ((List<Map>) x.get("relatedChemicals")).get(0).get("id"));
                        DrugLabel drugLabelBean = new DrugLabel(labelId, name, objCls, alternateDrugAvailable, dosingInformation
                                , prescribingMarkdown, source, textMarkdown, summaryMarkdown, raw, drugId);
                        if (!drugLabelDao.existsById(labelId)) {
                            drugLabelDao.saveDrugLabel(drugLabelBean);
                            log.info("Saved: {}", labelId);
                        } else {
                            log.info("Label {} already exist, skip", labelId);
                        }
                    });
                }
            } catch (SQLException e) {
                log.info("", e);
            }
        });
    }

}
