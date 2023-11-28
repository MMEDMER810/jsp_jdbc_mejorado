<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detalle entrenamiento</title>
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int idEntrenamiento = -1;

    try {
        idEntrenamiento = Integer.parseInt(request.getParameter("idEntrenamiento"));
    } catch (NumberFormatException nfe) {
        nfe.printStackTrace();
        valida = false;
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");

            String sql = "SELECT * FROM entrenamiento WHERE idEntrenamiento = ?";

            ps = conn.prepareStatement(sql);

            ps.setInt(1, idEntrenamiento);

            rs = ps.executeQuery();

            if (rs.next()) {
                int idEnt = rs.getInt("idEntrenamiento");
                int socioID = rs.getInt("socioID");
                String tipoEntrenamiento = rs.getString("tipoEntrenamiento");
                String ubicacion = rs.getString("ubicacion");
                Date fecha = rs.getDate("fecha");


%>
<h1>Detalle Entrenamiento</h1>
<table>
    <tr>
        <%=idEnt%>,
    </tr>
    <tr>
        socio ID: <%=socioID%>
    </tr>
    <tr>
        <%=tipoEntrenamiento%>
    </tr>
    <tr>
        <%=ubicacion%>
    </tr>
    <tr>
        <%=fecha%>
    </tr>
</table>
<%
            } else {
                out.println("No hay entrenamiento con ese ID");
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            try { ps.close(); } catch (Exception e) { /* Ignored */ }
            try { conn.close(); } catch (Exception e) { /* Ignored */ }
        }

    } else {
        out.println("Error de formato");
    }
%>

</body>
</html>

