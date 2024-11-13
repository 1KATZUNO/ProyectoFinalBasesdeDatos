<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Actividades</title>
    <link rel="stylesheet" href="style_a.css">
</head>
<body>
    <header>
        <h1>Editar Actividades</h1>
        <button onclick="window.location.href='menu.jsp'" class="back-button">Regresar</button>
    </header>
    <main>
        
        <div class="button-container">
            <form method="post">
                <button name="action" value="eliminar" class="action-button">Eliminar</button>
                <button name="action" value="actualizar" class="action-button">Actualizar</button>
                <button name="action" value="mostrar" class="action-button">Mostrar</button>
            </form>
        </div>
        <textarea id="txtActualizar" placeholder="Resultado de la consulta...">
<%
    String action = request.getParameter("action");
    String resultado = "";

    if (action != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/users?verifyServerCertificate=false&useSSL=true", "root", "2207");
            Statement stmt = con.createStatement();

            if (action.equals("eliminar")) {
                String cedula = request.getParameter("cedula");
                if (cedula != null && !cedula.isEmpty()) {
                    String sqlEliminar = "DELETE FROM datos WHERE cedula='" + cedula + "'";
                    int exito = stmt.executeUpdate(sqlEliminar);
                    resultado = exito > 0 ? "Dato eliminado exitosamente" : "No se encontró la cédula a eliminar.";
                } else {
                    resultado = "Cédula no puede estar vacía.";
                }
            } else if (action.equals("actualizar")) {
                String busca = request.getParameter("busca");
                String cedula = request.getParameter("cedula");
                String nombre = request.getParameter("nombre");
                String lugar = request.getParameter("lugar");

                if (busca != null && cedula != null && nombre != null && lugar != null &&
                    !busca.isEmpty() && !cedula.isEmpty() && !nombre.isEmpty() && !lugar.isEmpty()) {
                    String SQL = "UPDATE datos SET cedula='" + cedula + "', nombre='" + nombre + "', lugar='" + lugar + "' WHERE cedula='" + busca + "'";
                    int exito = stmt.executeUpdate(SQL);
                    resultado = exito > 0 ? "Dato editado exitosamente" : "No se encontró la cédula a editar.";
                } else {
                    resultado = "Todos los campos deben ser llenados.";
                }
            } else if (action.equals("mostrar")) {
                String SQL = "SELECT * FROM datos";
                ResultSet rs = stmt.executeQuery(SQL);
                StringBuilder sb = new StringBuilder();
                while (rs.next()) {
                    sb.append("Cédula: ").append(rs.getString("cedula")).append(", Nombre: ").append(rs.getString("nombre"))
                      .append(", Lugar: ").append(rs.getString("lugar")).append("\n");
                }
                resultado = sb.toString();
            }

            con.close();
        } catch (ClassNotFoundException | SQLException e) {
            resultado = "Error al conectar con la base de datos: " + e.getMessage();
        }
    }

    out.print(resultado);
%>
        </textarea>
        <% if ("actualizar".equals(action)) { %>
        <form method="post" class="update-form">
            <input type="hidden" name="action" value="actualizar">
            <input type="text" name="busca" placeholder="Cédula a editar">
            <input type="text" name="cedula" placeholder="Nueva cédula">
            <input type="text" name="nombre" placeholder="Nuevo nombre">
            <input type="text" name="lugar" placeholder="Nuevo lugar">
            <button type="submit" class="action-button">Actualizar</button>
        </form>
        <% } else if ("eliminar".equals(action)) { %>
        <form method="post" class="delete-form">
            <input type="hidden" name="action" value="eliminar">
            <input type="text" name="cedula" placeholder="Cédula a eliminar">
            <button type="submit" class="action-button">Eliminar</button>
        </form>
        <% } %>
    </main>
</body>
</html>
