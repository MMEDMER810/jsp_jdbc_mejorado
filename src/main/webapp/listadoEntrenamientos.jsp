<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="estilos.css" />
</head>
<body>
<%
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");
    Statement s = conexion.createStatement();

    ResultSet listadoEntrenamientos = s.executeQuery ("SELECT * FROM entrenamiento");
%>
<table>
    <tr><th>Código Entrenamiento</th><th>SocioID</th><th>Tipo entrenamiento</th><th>Ubicación</th><th>Fecha</th></tr>
    <%

        while (listadoEntrenamientos.next()) {
    %>
    <tr>
        <td>
            <%=listadoEntrenamientos.getInt("idEntrenamiento")%>
        </td>
        <td>
            <%=listadoEntrenamientos.getInt("socioID")%>
        </td>
        <td>
            <%=listadoEntrenamientos.getString("tipoEntrenamiento")%>
        </td>
        <td>
            <%=listadoEntrenamientos.getString("ubicacion")%>
        </td>
        <td>
            <%=listadoEntrenamientos.getDate("fecha")%>
        </td>

        <td>
            <form method="get" action="borraEntrenamiento.jsp">
                <input type="hidden" name="idEntrenamiento" value="<%=listadoEntrenamientos.getString("idEntrenamiento") %>"/>
                <input type="submit" value="borrar">
            </form>
        </td>
        <td>
            <form action="detalleEntrenamiento.jsp" method="get">
                <input type="hidden" name="idEntrenamiento" value="<%=listadoEntrenamientos.getString("idEntrenamiento") %>">
                <input type="submit" value="detalles">
            </form>
        </td>

    </tr>
    <%
        } // fin while
        conexion.close();
    %>
</table>
</body>
</html>