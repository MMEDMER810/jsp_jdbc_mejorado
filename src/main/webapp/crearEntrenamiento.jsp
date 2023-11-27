<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %><%--
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
    boolean flagValidaID = false;
    boolean flagValidaTipoEntrenamientoNull = false;
    boolean flagValidaTipoEntrenamientoBlank = false;
    boolean flagValidaTipoEntrenamientoContemplado = false;
    boolean flagValidaUbicacionNull = false;
    boolean flagValidaUbicacionBlank = false;
    boolean flagValidaFechaNull = false;
    boolean flagValidaFechaBlank = false;

    try {
        //Valida socioID
        socioID = Integer.parseInt(request.getParameter("socioID"));
        flagValidaID = true;

        //Valida tipoEntrenamiento (nulo, en blanco, que sea uno de los contemplados)
        Objects.requireNonNull(request.getParameter("tipoEntrenamiento"));
        flagValidaTipoEntrenamientoNull = true;

        if (request.getParameter("tipoEntrenamiento").isBlank()) throw new RuntimeException(("Parámetro vacío o todo espacios"));
        flagValidaTipoEntrenamientoBlank = true;

        if (!request.getParameter("tipoEntrenamiento").equals("fisico") && !request.getParameter("tipoEntrenamiento").equals("tecnico"))
            throw new RuntimeException("Tipo de entrenamiento incorrecto");
        flagValidaTipoEntrenamientoContemplado = true;
        tipoEntrenamiento = request.getParameter("tipoEntrenamiento");

        //Valida ubicación (nulo y en blanco)
        Objects.requireNonNull(request.getParameter("tipoEntrenamiento"));
        flagValidaUbicacionNull = true;

        if (request.getParameter("ubicacion").isBlank()) throw new RuntimeException(("Parámetro vacío o todo espacios"));
        flagValidaUbicacionBlank = true;
        ubicacion = request.getParameter("ubicacion");

        //Valida fecha (nula y en blanco)
        Objects.requireNonNull(request.getParameter("fecha"));
        flagValidaFechaNull = true;

        if (request.getParameter("fecha").isBlank()) throw new RuntimeException("Parámetro vacío");
        flagValidaFechaBlank = true;
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        fecha = formatoFecha.parse(request.getParameter("fecha"));

    }catch(Exception e) {
        e.printStackTrace();
        valida = false;

        if (!flagValidaID) {
            session.setAttribute("error", "Error de socioID");
        } else if (!flagValidaTipoEntrenamientoNull) {
            session.setAttribute("error", "Error de tipo de entrenamiento nulo");
        } else if (!flagValidaTipoEntrenamientoBlank) {
            session.setAttribute("error", "Error de tipo de entrenamiento en blanco");
        } else if (!flagValidaTipoEntrenamientoContemplado) {
            session.setAttribute("error", "Error de tipo de entrenamiento no contemplado");
        } else if (!flagValidaUbicacionNull) {
            session.setAttribute("error", "Error de ubicación nula");
        } else if (!flagValidaUbicacionBlank) {
            session.setAttribute("error", "Error de ubicación en blanco");
        } else if (!flagValidaFechaNull) {
            session.setAttribute("error", "Error de fecha nula");
        } else if (!flagValidaFechaBlank) {
            session.setAttribute("error", "Error de fecha en blanco");
        }
    }
    //FIN VALIDACIÓN

    if (valida) {
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "user", "user");

            String sql = "INSERT INTO entrenamiento VALUES (" +
                    "?, " + //socioID
                    "?, " + //tipo entrenamiento
                    "?, " + //ubicacion
                    "?)" + //Fecha



        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                ps.close();
            } catch (Exception e) {
            }
            try {
                conn.close();
            } catch (Exception e) {
            }
        }

    } else {
        //Redirige y muestra el error
        response.sendRedirect("index.jsp");

    }


%>


</body>
</html>
