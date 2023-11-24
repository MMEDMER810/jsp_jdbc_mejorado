<%@ page import="java.util.Objects" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.*" %><%--
  Created by IntelliJ IDEA.
  User: mireya
  Date: 20/11/23
  Time: 14:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Detalle socio</title>
</head>
<body>
    <%
        //CÓDIGO DE VALIDACIÓN
        boolean valida = true;
        int socioID = -1;

        try {
            socioID = Integer.parseInt(request.getParameter("socioID"));
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
                //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
                //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");

                String sql = "SELECT * FROM socio WHERE socioID = ?";

                ps = conn.prepareStatement(sql);

                ps.setInt(1, socioID);

                rs = ps.executeQuery();

                if (rs.next()) {
                    int idSocio = rs.getInt("socioID");
                    String nombre = rs.getString("nombre");
                    int estatura = rs.getInt("estatura");
                    int edad = rs.getInt("edad");
                    String localidad = rs.getString("localidad");

                %>
                <h1>Detalle socio</h1>
                <table>
                    <tr>
                        <%=idSocio%>
                    </tr>
                    <tr>
                        <%=nombre%>
                    </tr>
                    <tr>
                        <%=estatura%>
                    </tr>
                    <tr>
                        <%=edad%>
                    </tr>
                    <tr>
                        <%=localidad%>
                    </tr>
                </table>
                <%
                } else {
                    out.println("No hay socio con ese ID");
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
