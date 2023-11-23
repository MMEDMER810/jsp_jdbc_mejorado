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
<br>
</body>
</html>