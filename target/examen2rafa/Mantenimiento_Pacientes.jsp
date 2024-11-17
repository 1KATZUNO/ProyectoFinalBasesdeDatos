<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Pacientes</title>
    <link rel="stylesheet" href="style_a.css">
</head>
<body>
    <header>
        <h1>Editar Pacientes</h1>
        <button onclick="window.location.href='menu.jsp'" class="back-button">Regresar</button>
    </header>
    <main>
        <div class="button-container">
            <form method="post">
                <button name="action" value="eliminar" class="action-button">Eliminar</button>
                <button name="action" value="actualizar" class="action-button">Actualizar</button>
                <button name="action" value="mostrar" class="action-button">Mostrar</button>
                <button name="action" value="agregar" class="action-button">Agregar</button>
            </form>
        </div>
        <textarea id="txtActualizar" placeholder="Resultado de la consulta..." readonly>
<%
    String action = request.getParameter("action");
    String resultado = "";

    if (action != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/users?verifyServerCertificate=false&useSSL=true", "root", "2207");

            if (action.equals("eliminar")) {
                String cedula = request.getParameter("cedula");
                if (cedula != null && !cedula.isEmpty()) {
                    CallableStatement stmt = con.prepareCall("{CALL eliminarPacientes(?)}");
                    stmt.setInt(1, Integer.parseInt(cedula));
                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Paciente eliminado exitosamente" : "No se encontró el paciente con la cédula proporcionada.";
                } else {
                    resultado = "La cédula no puede estar vacía.";
                }
            } else if (action.equals("actualizar")) {
                String busca = request.getParameter("busca");
                String nombre1 = request.getParameter("nombre1");
                String apellido1 = request.getParameter("apellido1");
                String apellido2 = request.getParameter("apellido2");
                String telefono = request.getParameter("telefono");
                String fechaNacimiento = request.getParameter("fecha_nacimiento");

                if (busca != null && nombre1 != null && apellido1 != null &&
                    apellido2 != null && telefono != null && fechaNacimiento != null &&
                    !busca.isEmpty() && !nombre1.isEmpty() && !apellido1.isEmpty() &&
                    !apellido2.isEmpty() && !telefono.isEmpty() && !fechaNacimiento.isEmpty()) {

                    CallableStatement stmt = con.prepareCall("{CALL actualizarPacientes(?, ?, ?, ?, ?, ?)}");
                    stmt.setInt(1, Integer.parseInt(busca));
                    stmt.setString(2, nombre1);
                    stmt.setString(3, apellido1);
                    stmt.setString(4, apellido2);
                    stmt.setInt(5, Integer.parseInt(telefono));
                    stmt.setString(6, fechaNacimiento);

                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Paciente actualizado exitosamente" : "No se encontró el paciente con la cédula proporcionada.";
                } else {
                    resultado = "Todos los campos deben ser llenados.";
                }
            } else if (action.equals("mostrar")) {
                // Llamar al procedimiento almacenado para mostrar pacientes
                CallableStatement stmt = con.prepareCall("{CALL mostrarPacientess()}");
                ResultSet rs = stmt.executeQuery();
                StringBuilder sb = new StringBuilder();
                while (rs.next()) {
                    sb.append("Cédula: ").append(rs.getInt("cedula"))
                      .append(", Nombre: ").append(rs.getString("nombre1"))
                      .append(", Apellido 1: ").append(rs.getString("apellido1"))
                      .append(", Apellido 2: ").append(rs.getString("apellido2"))
                      .append(", Teléfono: ").append(rs.getInt("telefono"))
                      .append(", Fecha Nacimiento: ").append(rs.getString("fecha_nacimiento"))
                      .append("\n");
                }
                resultado = sb.toString();
            } else if (action.equals("agregar")) {
                String cedula = request.getParameter("cedula");
                String nombre1 = request.getParameter("nombre1");
                String apellido1 = request.getParameter("apellido1");
                String apellido2 = request.getParameter("apellido2");
                String telefono = request.getParameter("telefono");
                String fechaNacimiento = request.getParameter("fecha_nacimiento");

                if (cedula != null && nombre1 != null && apellido1 != null &&
                    apellido2 != null && telefono != null && fechaNacimiento != null &&
                    !cedula.isEmpty() && !nombre1.isEmpty() && !apellido1.isEmpty() &&
                    !apellido2.isEmpty() && !telefono.isEmpty() && !fechaNacimiento.isEmpty()) {

                    CallableStatement stmt = con.prepareCall("{CALL agregarPacientes(?, ?, ?, ?, ?, ?)}");
                    stmt.setInt(1, Integer.parseInt(cedula));
                    stmt.setString(2, nombre1);
                    stmt.setString(3, apellido1);
                    stmt.setString(4, apellido2);
                    stmt.setInt(5, Integer.parseInt(telefono));
                    stmt.setString(6, fechaNacimiento);

                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Paciente agregado exitosamente" : "No se pudo agregar el paciente.";
                } else {
                    resultado = "Todos los campos deben ser llenados.";
                }
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
            <input type="text" name="busca" placeholder="Cédula a editar" readonly>
            <input type="text" name="nombre1" placeholder="Primer nombre">
            <input type="text" name="apellido1" placeholder="Primer apellido">
            <input type="text" name="apellido2" placeholder="Segundo apellido">
            <input type="text" name="telefono" placeholder="Teléfono">
            <input type="text" name="fecha_nacimiento" placeholder="Fecha de nacimiento">
            <button type="submit" class="action-button">Actualizar</button>
        </form>
        <% } else if ("eliminar".equals(action)) { %>
        <form method="post" class="delete-form">
            <input type="hidden" name="action" value="eliminar">
            <input type="text" name="cedula" placeholder="Cédula a eliminar">
            <button type="submit" class="action-button">Eliminar</button>
        </form>
        <% } else if ("agregar".equals(action)) { %>
        <form method="post" class="add-form">
            <input type="hidden" name="action" value="agregar">
            <input type="text" name="cedula" placeholder="Cédula">
            <input type="text" name="nombre1" placeholder="Primer nombre">
            <input type="text" name="apellido1" placeholder="Primer apellido">
            <input type="text" name="apellido2" placeholder="Segundo apellido">
            <input type="text" name="telefono" placeholder="Teléfono">
            <input type="text" name="fecha_nacimiento" placeholder="Fecha de nacimiento">
            <button type="submit" class="action-button">Agregar</button>
        </form>
        <% } %>
    </main>
</body>
</html>


