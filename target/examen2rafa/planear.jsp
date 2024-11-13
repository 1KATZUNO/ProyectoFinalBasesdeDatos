<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.JOptionPane" %>

<%
    String nombre = request.getParameter("nombre");
    String cedulaStr = request.getParameter("cedula");
    String provincia = request.getParameter("provincia");

    if (nombre != null && cedulaStr != null && provincia != null) {
        int cedula = Integer.parseInt(cedulaStr);
        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/users?verifyServerCertificate=false&useSSL=true", "root", "2207");

            String sql = "INSERT INTO datos (nombre, cedula, lugar) VALUES (?, ?, ?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setInt(2, cedula);
            pstmt.setString(3, provincia);
            int exito = pstmt.executeUpdate();

            if (exito > 0) {
                out.println("<p>Datos guardados exitosamente!</p>");
            } else {
                out.println("<p>Error al guardar los datos.</p>");
            }

            String[] lugares = new String[0];
            switch (provincia) {
                case "Guanacaste":
                    lugares = new String[]{"Parque nacional Santa Rosa", "Parque Nacional Guanacaste", "Estación Experimental Forestal Horizontes", "Refugio de Vida Silvestre Bahía Junquillal"};
                    break;
                case "Limón":
                    lugares = new String[]{"Parque nacional Cahuita", "Parque Nacional Tortuguero", "Parque Nacional Barbilla", "Parque Nacional Braulio Carrillo", "Playa Punta Uva"};
                    break;
                case "Puntarenas":
                    lugares = new String[]{"Parque nacional Corcovado", "Parque Nacional Manuel Antonio", "Parque Nacional Isla San Lucas", "Parque Nacional Marino Ballena", "Parque Nacional Carara"};
                    break;
                case "Alajuela":
                    lugares = new String[]{"Parque Nacional Volcán Arenal", "Parque Nacional Rincón de la Vieja", "Parque Nacional Volcán Tenorio", "Parque Nacional Juan Castro Blanco", "Parque Nacional Volcán Poás"};
                    break;
                case "Heredia":
                    lugares = new String[]{"El Arca Jardín Botánico", "Estación Biológica La Selva", "Pirella Ecological Garden", "Tirimbina Biological Reserve", "Bosque La Hoja"};
                    break;
                case "San José":
                    lugares = new String[]{"Parque Nacional Los Quetzales", "Parque La Sabana", "Parque Nacional Braulio Carrillo", "Monte Sky", "Laguna Don Manuel"};
                    break;
                case "Cartago":
                    lugares = new String[]{"Parque Nacional Volcán Irazú", "Parque Nacional Tapantí Macizo de la Muerte", "Parque Nacional Volcán Turrialba", "Guayabo National Monument", "Parque Recreativo Lankester"};
                    break;
            }

            out.println("<h3>Lugares a visitar en " + provincia + ":</h3>");
            for (String lugar : lugares) {
                out.println("<p>" + lugar + "</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (pstmt != null) pstmt.close();
            if (con != null) con.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Planear Visita</title>
    <link rel="stylesheet" type="text/css" href="style_p.css">
</head>
<body>
    <div class="container">
        <h2>Planear Visita</h2>
        <form method="post">
            <div class="form-group">
                <label for="nombre">Nombre:</label>
                <input type="text" id="nombre" name="nombre" required>
            </div>
            <div class="form-group">
                <label for="cedula">Cédula:</label>
                <input type="text" id="cedula" name="cedula" required>
            </div>
            <div class="form-group">
                <label for="provincia">Provincia:</label>
                <select id="provincia" name="provincia" required>
                    <option value="Guanacaste">Guanacaste</option>
                    <option value="Limon">Limon</option>
                    <option value="Puntarenas">Puntarenas</option>
                    <option value="Alajuela">Alajuela</option>
                    <option value="Heredia">Heredia</option>
                    <option value="San Jose">San Jose</option>
                    <option value="Cartago">Cartago</option>
                </select>
            </div>
            <div class="form-group">
                <button type="submit">Aceptar</button>
            </div>
        </form>
    </div>
</body>
</html>