<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.examen2rafa.ConexionBaseDatos" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Usuario</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String sexo = request.getParameter("sexo");
        String año_nacimiento = request.getParameter("año_nacimiento");

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = ConexionBaseDatos.obtenerConexion(); // Utilizar el método correcto

            String query = "INSERT INTO mad (username, password, nombre, apellido, sexo, año_nacimiento) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, nombre);
            stmt.setString(4, apellido);
            stmt.setString(5, sexo);
            stmt.setString(6, año_nacimiento);

            int rows = stmt.executeUpdate();

            if (rows > 0) {
                out.println("<script>alert('Usuario agregado exitosamente');</script>");
                out.println("<script>window.location='mantenimiento.jsp';</script>");
            } else {
                out.println("<script>alert('Error al agregar usuario');</script>");
                out.println("<script>window.location='mantenimiento.jsp';</script>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>