<%@page import="java.sql.*" %>
<%@page import="java.util.Objects" %>
<%@ page import="java.io.IOException" %>
<%@ page import="javax.swing.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
<%
    //CÓDIGO DE VALIDACIÓN
    boolean valida = true;
    int numero = -1;
    String nombre = null;
    int estatura = -1;
    int edad = -1;
    String localidad = null;
    boolean flagValidaNumero = false;
    boolean flagValidaNombreNull = false;
    boolean flagValidaNombreBlank = false;
    boolean flagValidaEstatura = false;
    boolean flagValidaEdad = false;
    boolean flagValidaLocalidad = false;

    try {
        numero = Integer.parseInt(request.getParameter("numero"));
        flagValidaNumero = true;
        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("nombre"));
        flagValidaNombreNull = true;
        //CONTRACT nonBlank..
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("nombre").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaNombreBlank = true;
        nombre = request.getParameter("nombre");

        estatura = Integer.parseInt(request.getParameter("estatura"));
        flagValidaEstatura = true;

        edad = Integer.parseInt(request.getParameter("edad"));
        flagValidaEdad = true;

        //UTILIZO LOS CONTRACTS DE LA CLASE Objects PARA LA VALIDACIÓN
        //             v---- LANZA NullPointerException SI EL PARÁMETRO ES NULL
        Objects.requireNonNull(request.getParameter("localidad"));
        //CONTRACT nonBlank
        //UTILIZO isBlank SOBRE EL PARÁMETRO DE TIPO String PARA CHEQUEAR QUE NO ES UN PARÁMETRO VACÍO "" NI CADENA TODO BLANCOS "    "
        //          |                                EN EL CASO DE QUE SEA BLANCO LO RECIBIDO, LANZO UNA EXCEPCIÓN PARA INVALIDAR EL PROCESO DE VALIDACIÓN
        //          -------------------------v                      v---------------------------------------|
        if (request.getParameter("localidad").isBlank()) throw new RuntimeException("Parámetro vacío o todo espacios blancos.");
        flagValidaLocalidad = true;
        localidad = request.getParameter("localidad");

    } catch (Exception ex) {
        ex.printStackTrace();
        valida = false;

        if(!flagValidaNumero) {
            session.setAttribute("error", "Error de número");
        } else if (!flagValidaNombreNull) {
            session.setAttribute("error", "Error de nombre nulo");
        } else if (!flagValidaNombreBlank) {
            session.setAttribute("error", "Error de nombre blanco" );
        } else if (!flagValidaEdad) {
            session.setAttribute("error", "Error en la edad");
        } else if (!flagValidaEstatura) {
            session.setAttribute("error", "Error en la estatura");
        } else if (!flagValidaLocalidad) {
            session.setAttribute("error", "Error en la localidad");
        }
    }
    //FIN CÓDIGO DE VALIDACIÓN

    if (valida) {

        Connection conn = null;
        PreparedStatement ps = null;
// 	ResultSet rs = null;

        try {

            //CARGA DEL DRIVER Y PREPARACIÓN DE LA CONEXIÓN CON LA BBDD
            //						v---------UTILIZAMOS LA VERSIÓN MODERNA DE LLAMADA AL DRIVER, no deprecado
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/baloncesto", "user", "user");


//>>>>>>NO UTILIZAR STATEMENT EN QUERIES PARAMETRIZADAS
//       Statement s = conexion.createStatement();
//       String insercion = "INSERT INTO socio VALUES (" + Integer.valueOf(request.getParameter("numero"))
//                          + ", '" + request.getParameter("nombre")
//                          + "', " + Integer.valueOf(request.getParameter("estatura"))
//                          + ", " + Integer.valueOf(request.getParameter("edad"))
//                          + ", '" + request.getParameter("localidad") + "')";
//       s.execute(insercion);
//<<<<<<

            String sql = "INSERT INTO socio VALUES ( " +
                    "?, " + //socioID
                    "?, " + //nombre
                    "?, " + //estatura
                    "?, " + //edad
                    "?)"; //localidad

            ps = conn.prepareStatement(sql);
            int idx = 1;
            ps.setInt(idx++, numero);
            ps.setString(idx++, nombre);
            ps.setInt(idx++, estatura);
            ps.setInt(idx++, edad);
            ps.setString(idx++, localidad);

            int filasAfectadas = ps.executeUpdate();
            System.out.println("SOCIOS GRABADOS:  " + filasAfectadas);

        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
            //BLOQUE FINALLY PARA CERRAR LA CONEXIÓN CON PROTECCIÓN DE try-catch
            //SIEMPRE HAY QUE CERRAR LOS ELEMENTOS DE LA  CONEXIÓN DESPUÉS DE UTILIZARLOS
            //try { rs.close(); } catch (Exception e) { /* Ignored */ }
            try {
                ps.close();
            } catch (Exception e) { /* Ignored */ }
            try {
                conn.close();
            } catch (Exception e) { /* Ignored */ }
        }

        //response.sendRedirect("detalleSocio.jsp?socioID="+numero);

        session.setAttribute("socioIDADestacar", numero);
        response.sendRedirect("pideNumeroSocio.jsp");

    } else {
        //Redirige al formulario para mostrar el error
        response.sendRedirect("formularioSocio.jsp");
    }
%>

</body>
</html>
