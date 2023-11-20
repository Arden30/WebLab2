<%@ page import="models.ClientData" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:useBean id="databean" class="models.DataBean" scope="session"/>
<html>
<head>
    <meta charset="UTF-8">
    <title>WebLab2</title>
    <link rel="shortcut icon" href="img/30.jpg">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
    <header class="header">
        <h1>Arsenev Denis, P3214</h1>
        <h2>Variant: 2473</h2>
    </header>
    <div class="main-panel">
        <div id="coordinates">
            <svg height="450" width="450" xmlns="http://www.w3.org/2000/svg">
                <!-- X -->
                <line stroke="black" x1="0" x2="450" y1="225" y2="225"></line>
                <!-- Стрелка X -->
                <polygon fill="black" points="450,225 440,230 440,220" stroke="black"></polygon>

                <!-- Y -->
                <line stroke="black" x1="225" x2="225" y1="0" y2="450"></line>
                <!-- Стрелка Y -->
                <polygon fill="black" points="225,0 220,10 230,10" stroke="black"></polygon>

                <!-- Справа по Х -->
                <line stroke="black" x1="300" x2="300" y1="235" y2="215"></line>
                <line stroke="black" x1="375" x2="375" y1="235" y2="215"></line>

                <!-- Слева по Х -->
                <line stroke="black" x1="150" x2="150" y1="235" y2="215"></line>
                <line stroke="black" x1="75" x2="75" y1="235" y2="215"></line>

                <!-- Снизу по Y -->
                <line stroke="black" x1="215" x2="235" y1="300" y2="300"></line>
                <line stroke="black" x1="215" x2="235" y1="375" y2="375"></line>

                <!-- Сверху по Y -->
                <line stroke="black" x1="215" x2="235" y1="150" y2="150"></line>
                <line stroke="black" x1="215" x2="235" y1="75" y2="75"></line>

                <!-- Подписи к делениям и осям -->
                <!-- Справа по Х -->
                <text fill="black" x="300" y="255">R/2</text>
                <text fill="black" x="375" y="255">R</text>

                <!-- Слева по Х -->
                <text fill="black" x="150" y="255">-R/2</text>
                <text fill="black" x="75" y="255">-R</text>

                <!-- Сверху по Y -->
                <text fill="black" x="240" y="150">R/2</text>
                <text fill="black" x="240" y="75">R</text>

                <!-- Снизу по Y -->
                <text fill="black" x="240" y="300">-R/2</text>
                <text fill="black" x="240" y="375">-R</text>

                <!-- Ось Х -->
                <text fill="black" x="430" y="215">X</text>
                <!-- Ось Y -->
                <text fill="black" x="230" y="15">Y</text>

                <!-- Полуокружность (1 четверть) -->
                <path fill="blue"
                      fill-opacity="0.2"
                      stroke="blue"
                d = "M 225 225 L 225 75 A 150,150 0 0,1 375,225 Z"></path>

                <!-- Прямоугольник (2 четверть) -->
                <polygon fill="blue"
                         fill-opacity="0.2"
                         stroke="blue"
                         points="75,225 225,225 225,150 75,150"></polygon>

                <!-- Треугольник (3 четверть) -->
                <polygon fill="blue"
                      fill-opacity="0.2"
                      stroke="blue"
                         points="75,225 225,225 225,300"></polygon>

                <% double size = 450;
                    int num = databean.getData().size();
                    if (num > 0) {
                        ClientData dot = databean.getData().get(num - 1);%>
                    <circle r="3.5"
                        cx=<%=(size / 2 + (dot.x() + (double) 1/75) / dot.r() * 150)%>
                                cy=<%=(size / 2 + (dot.y() - (double) 1/75) / dot.r() * -150)%>
                        id="dot"
                        fill=<%=dot.result() ? "green" : "red"%>
                                    </circle>
                    <%}%>
            </svg>
        </div>
        <div class="input">
            <form method="POST" id="coordinates-form">
                <div class="values">
                    <div class="X-val">
                        <label> X:
                            <select name="x" id="x-select">
                                <option value="-4">-4</option>
                                <option value="-3">-3</option>
                                <option value="-2">-2</option>
                                <option value="-1">-1</option>
                                <option value="0">0</option>
                                <option value="1">1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </label>
                    </div>
                    <div class="Y-val">
                        <label>
                            Y:
                            <input id="y" type="text" name="y" placeholder="(-5; 3)" autocomplete="off" maxlength="13"/>
                        </label>
                    </div>
                    <div class="R-val">
                        R:
                        <label>
                            1
                            <input type="radio" name="r" value="1">
                        </label>
                        <label>
                            2
                            <input type="radio" name="r" value="2">
                        </label>
                        <label>
                            3
                            <input type="radio" name="r" value="3">
                        </label>
                        <label>
                            4
                            <input type="radio" name="r" value="4">
                        </label>
                        <label>
                            5
                            <input type="radio" name="r" value="5">
                        </label>
                    </div>
                    <button id="submit-button" type="submit">Send</button>
                </div>
            </form>
        </div>
    </div>
    <div class="table" id="table">
        <table id="table-header">
            <tr>
                <th scope="col">X</th>
                <th scope="col">Y</th>
                <th scope="col">R</th>
                <th scope="col">Current time</th>
                <th scope="col">Running time</th>
                <th scope="col">Result</th>
            </tr>
                <%for (ClientData data: databean.getData()) { %>
            <tr>
                <td><%=data.x()%></td>
                <td><%=data.y()%></td>
                <td><%=data.r()%></td>
                <td><%=data.time()%></td>
                <td><%=data.runningTime()%> ns</td>
                <td><%=data.result() ? "Hit" : "Miss"%></td>
            </tr>
            <%}%>
        </table>
        <button id="clear-button" type="reset">Clear</button>
    </div>
</div>
<footer>
    <h2>Web-programming. Laboratory work #2. 2023</h2>
</footer>
<script type="text/javascript" src="js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script></body>
</html>
