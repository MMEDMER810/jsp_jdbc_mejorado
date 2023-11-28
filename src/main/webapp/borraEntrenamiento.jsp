<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
// 	ResultSet rs = null;

    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto","user", "user");

      String sql = "DELETE FROM entrenamiento WHERE idEntrenamiento = ?";
      ps = conn.prepareStatement(sql);

      ps.setInt(1, idEntrenamiento);

      int filasAfectadas = ps.executeUpdate();

      System.out.println("ENTRENAMIENTOS BORRADOS:  " + filasAfectadas);

    } catch (Exception ex) {
      ex.printStackTrace();
    } finally {
      try { ps.close(); } catch (Exception e) { /* Ignored */ }
      try { conn.close(); } catch (Exception e) { /* Ignored */ }
    }

  }
%>

<!-- REDIRECCIÓN POR JavaScript EN EL CLIENTE  -->
<script>document.location = "listadoEntrenamientos.jsp"</script>
</body>
</html>