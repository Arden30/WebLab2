package servlets;

import models.ClientData;
import models.DataBean;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@WebServlet("/areaCheck")
public class AreaCheckServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        long startTime = System.nanoTime();

        String str_x = request.getParameter("x");
        String str_y = request.getParameter("y");
        String str_r = request.getParameter("r");

        double x;
        double y;
        int r;

        try {
            x = Double.parseDouble(str_x);
            y = Double.parseDouble(str_y);
            r = Integer.parseInt(str_r);
        } catch (NumberFormatException | NullPointerException e) {
            response.sendRedirect("/index.jsp");
            return;
        }

        if (validateX(x) && validateY(y) && validateR(r)) {
            LocalDateTime now = LocalDateTime.now();
            DateTimeFormatter dateTimeFormatter = DateTimeFormatter.ofPattern("dd.MM.yyyy HH:mm:ss");
            String currentTime = now.format(dateTimeFormatter);

            boolean result = checkHit(x, y, r);
            long runningTime = System.nanoTime() - startTime;

            ClientData clientData = new ClientData(x, y, r, currentTime, runningTime, result);
            DataBean dataBean = (DataBean) request.getSession().getAttribute("databean");
            if (dataBean == null) {
                dataBean = new DataBean();
            }
            dataBean.getData().add(clientData);
            request.getSession().setAttribute("databean", dataBean);
        }

        getServletContext().getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private boolean validateX(double x) {
        return x >= -4 && x <= 4;
    }

    private boolean validateY(double y) {
        return y > -5 && y < 3;
    }

    private boolean validateR(int R) {
        List<Integer> appropriateR = List.of(1, 2, 3, 4, 5);
        return appropriateR.contains(R);
    }

    private boolean checkHit(double x, double y, double r) {
        boolean rectangle = false;
        boolean triangle = false;
        boolean circle = false;

        if (x >= -r && x <= 0 && y >= 0 && y <= r / 2) {
            rectangle = true;
        }
        if (x >= -r && x <= 0 && y >= -0.5 * x - r / 2 && y <= 0) {
            triangle = true;
        }
        if (x >= 0 && x <= r && y >= 0 && y <= r && x * x + y * y <= r * r) {
            circle = true;
        }

        return rectangle || triangle || circle;
    }
}
