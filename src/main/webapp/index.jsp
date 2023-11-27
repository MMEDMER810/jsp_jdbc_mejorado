<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
<br>
<a href="listadoSocios.jsp">Listado de Socios</a>
<br>
<a href="formularioSocio.jsp">Fomulario de Socio Nuevo</a>
<br>
<a href="pideNumeroSocio.jsp">Listado de Socios</a>
<br>
<form method="get" action="detalleSocio.jsp">
    Introduce ID del socio: <input type="text" name="socioID">
    <input type="submit" value="Aceptar">
</form>
<%
    //Fecha mínima para elegir la de hoy
    LocalDate hoy = LocalDate.now();
    //Formatear YYYY-MM-DD
    DateTimeFormatter formato = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String fechaMin = hoy.format(formato);
%>
<form method="get" action="crearEntrenamiento.jsp">
    Introduce ID del socio: <input type="text" name="socioID">
    <select name="tipoEntrenamiento">
        <option value="fisico">Físico</option>
        <option value="tecnico">Técnico</option>
    </select>
    Ubicación: <input type="text" name="ubicacion">
    Fecha de realización: <input type="date" name="fecha"  min=<%=fechaMin%>>
    <input type="submit" value="Aceptar">
</form>
<%
    String error = (String)session.getAttribute("error");
    if (error!=null) {
%>
<span style="background-color: red; color: yellow"><%=error%></span>
<%}%>
<%session.removeAttribute("error");%>
</body>
</html>