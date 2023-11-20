package servlets;

import models.DataBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/clear")
public class ClearServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        DataBean dataBean = (DataBean) request.getSession().getAttribute("databean");
        if (dataBean == null) {
            dataBean = new DataBean();
        }
        dataBean.getData().clear();
        request.getSession().setAttribute("databean", dataBean);

        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
