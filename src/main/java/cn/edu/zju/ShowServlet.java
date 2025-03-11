package cn.edu.zju;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ShowServlet", urlPatterns = "/show")
public class ShowServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.println("<html><body>");
        out.println("<h2>药物数据</h2>");
        out.println("<table border='1'>");

        List<Map<String, String>> dataList = DatabaseUtil.queryDatabase();

        if (dataList.isEmpty()) {
            out.println("<tr><td colspan='2'>没有数据</td></tr>");
        } else {
            // 表头
            out.println("<tr>");
            for (String column : dataList.get(0).keySet()) {
                out.println("<th>" + column + "</th>");
            }
            out.println("</tr>");

            // 数据行
            for (Map<String, String> row : dataList) {
                out.println("<tr>");
                for (String value : row.values()) {
                    out.println("<td>" + value + "</td>");
                }
                out.println("</tr>");
            }
        }

        out.println("</table>");
        out.println("</body></html>");
    }
}
