<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Doctores</title>
    <link rel="stylesheet" href="style_a.css">
</head>
<body>
    <header>
        <h1>Editar Doctores</h1>
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
                String iddoctor = request.getParameter("iddoctor");
                if (iddoctor != null && !iddoctor.isEmpty()) {
                    CallableStatement stmt = con.prepareCall("{CALL eliminarDoctor(?)}");
                    stmt.setInt(1, Integer.parseInt(iddoctor));
                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Doctor eliminado exitosamente" : "No se encontró el doctor con el id proporcionado.";
                } else {
                    resultado = "El id del doctor no puede estar vacío.";
                }
            } else if (action.equals("actualizar")) {
                String iddoctor = request.getParameter("iddoctor");
                String nombre1 = request.getParameter("nombre1");
                String apellido1 = request.getParameter("apellido1");
                String cedula = request.getParameter("cedula");
                String especialidad = request.getParameter("especialidad");
                String iddepartamento = request.getParameter("iddepartamento");

                if (iddoctor != null && nombre1 != null && apellido1 != null &&
                    cedula != null && especialidad != null && iddepartamento != null &&
                    !iddoctor.isEmpty() && !nombre1.isEmpty() && !apellido1.isEmpty() &&
                    !cedula.isEmpty() && !especialidad.isEmpty() && !iddepartamento.isEmpty()) {

                    CallableStatement stmt = con.prepareCall("{CALL actualizarDoctor(?, ?, ?, ?, ?, ?)}");
                    stmt.setInt(1, Integer.parseInt(iddoctor));
                    stmt.setString(2, nombre1);
                    stmt.setString(3, apellido1);
                    stmt.setInt(4, Integer.parseInt(cedula));
                    stmt.setString(5, especialidad);
                    stmt.setInt(6, Integer.parseInt(iddepartamento));

                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Doctor actualizado exitosamente" : "No se encontró el doctor con el id proporcionado.";
                } else {
                    resultado = "Todos los campos deben ser llenados.";
                }
            } else if (action.equals("mostrar")) {
                // Llamar al procedimiento almacenado para mostrar doctores
                CallableStatement stmt = con.prepareCall("{CALL mostrarDoctores()}");
                ResultSet rs = stmt.executeQuery();
                StringBuilder sb = new StringBuilder();
                while (rs.next()) {
                    sb.append("ID Doctor: ").append(rs.getInt("iddoctor"))
                      .append(", Nombre: ").append(rs.getString("nombre1"))
                      .append(", Apellido: ").append(rs.getString("apellido1"))
                      .append(", Cédula: ").append(rs.getInt("cedula"))
                      .append(", Especialidad: ").append(rs.getString("especialidad"))
                      .append(", Departamento: ").append(rs.getInt("iddepartamento"))
                      .append("\n");
                }
                resultado = sb.toString();
            } else if (action.equals("agregar")) {
                String iddoctor = request.getParameter("iddoctor");
                String nombre1 = request.getParameter("nombre1");
                String apellido1 = request.getParameter("apellido1");
                String cedula = request.getParameter("cedula");
                String especialidad = request.getParameter("especialidad");
                String iddepartamento = request.getParameter("iddepartamento");

                if (iddoctor != null && nombre1 != null && apellido1 != null &&
                    cedula != null && especialidad != null && iddepartamento != null &&
                    !iddoctor.isEmpty() && !nombre1.isEmpty() && !apellido1.isEmpty() &&
                    !cedula.isEmpty() && !especialidad.isEmpty() && !iddepartamento.isEmpty()) {

                    CallableStatement stmt = con.prepareCall("{CALL agregarDoctor(?, ?, ?, ?, ?, ?)}");
                    stmt.setInt(1, Integer.parseInt(iddoctor));
                    stmt.setString(2, nombre1);
                    stmt.setString(3, apellido1);
                    stmt.setInt(4, Integer.parseInt(cedula));
                    stmt.setString(5, especialidad);
                    stmt.setInt(6, Integer.parseInt(iddepartamento));

                    int exito = stmt.executeUpdate();
                    resultado = exito > 0 ? "Doctor agregado exitosamente" : "No se pudo agregar el doctor.";
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
            <input type="text" name="iddoctor" placeholder="ID Doctor" readonly>
            <input type="text" name="nombre1" placeholder="Primer nombre">
            <input type="text" name="apellido1" placeholder="Primer apellido">
            <input type="text" name="cedula" placeholder="Cédula">
            <input type="text" name="especialidad" placeholder="Especialidad">
            <input type="text" name="iddepartamento" placeholder="ID Departamento">
            <button type="submit" class="action-button">Actualizar</button>
        </form>
        <% } else if ("eliminar".equals(action)) { %>
        <form method="post" class="delete-form">
            <input type="hidden" name="action" value="eliminar">
            <input type="text" name="iddoctor" placeholder="ID Doctor a eliminar">
            <button type="submit" class="action-button">Eliminar</button>
        </form>
        <% } else if ("agregar".equals(action)) { %>
        <form method="post" class="add-form">
            <input type="hidden" name="action" value="agregar">
            <input type="text" name="iddoctor" placeholder="ID Doctor">
            <input type="text" name="nombre1" placeholder="Primer nombre">
            <input type="text" name="apellido1" placeholder="Primer apellido">
            <input type="text" name="cedula" placeholder="Cédula">
            <input type="text" name="especialidad" placeholder="Especialidad">
            <input type="text" name="iddepartamento" placeholder="ID Departamento">
            <button type="submit" class="action-button">Agregar</button>
        </form>
        <% } %>
    </main>
</body>
</html>

