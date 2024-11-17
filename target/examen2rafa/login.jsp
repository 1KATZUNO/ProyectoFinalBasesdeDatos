<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ page import="com.examen2rafa.ConexionBaseDatos" %>

<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    boolean isValidUser = false;

    // Verificar si los parámetros son null o vacíos
    if (username != null && !username.trim().isEmpty() && password != null && !password.trim().isEmpty()) {
        Connection conexion = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conexion = ConexionBaseDatos.obtenerConexion();
            
            // Llamar al procedimiento almacenado
            String sql = "{CALL ValidarUsuario(?, ?)}"; // Sintaxis para invocar el procedimiento
            ps = conexion.prepareStatement(sql);
            ps.setString(1, username); // Pasar el primer parámetro
            ps.setString(2, password); // Pasar el segundo parámetro
            rs = ps.executeQuery();

            // Verificar si se devuelve un resultado válido
            if (rs.next()) {
                isValidUser = true;
                request.getSession().setAttribute("usuario", username);
                response.sendRedirect("menu.jsp");
            } else {
                response.sendRedirect("index.jsp?error=1"); // Usuario o contraseña no válidos
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=2&mensaje=" + e.getMessage()); // Error en la base de datos
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (ps != null) try { ps.close(); } catch (SQLException ignore) {}
            if (conexion != null) try { conexion.close(); } catch (SQLException ignore) {}
        }
    } else {
        response.sendRedirect("index.jsp?error=3"); // Faltan parámetros o están vacíos
    }
%>

