package cn.edu.zju.crawler;

public class Main {
    public static void main(String[] args) {

        DrugLabelCrawler drugLabelCrawler = new DrugLabelCrawler();
        DosingGuidelineCrawler dosingGuidelineCrawler = new DosingGuidelineCrawler();

        // comment the step, if you have finished it

        // Step 1
        drugLabelCrawler.doCrawlerDrug();

        // Step 2
        drugLabelCrawler.doCrawlerDrugLabel();

        // Step 3
        dosingGuidelineCrawler.doCrawlerDosingGuidelineList();
    }
}
