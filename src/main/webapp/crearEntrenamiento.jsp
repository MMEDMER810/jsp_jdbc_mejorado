<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %><%--
  Created by IntelliJ IDEA.
  User: mireya
  Date: 24/11/23
  Time: 12:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Crear entrenamiento</title>
</head>
<body>
<%
    //VALIDACIÓN
    boolean valida = true;
    int socioID = -1;
    String tipoEntrenamiento = null;
    String ubicacion = null;
    Date fecha = null;



    socioID = Integer.parseInt(request.getParameter("socioID"));
    tipoEntrenamiento = request.getParameter("tipoEntrenamiento");
    ubicacion = request.getParameter("ubicacion");

    SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    fecha = formato.parse(request.getParameter("fecha"));


%>


</body>
</html>
