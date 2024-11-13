<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mantenimiento</title>
    <link rel="stylesheet" href="Menu.css">
</head>
<body>
    <div class="container">
        <div class="logo">
            <img src="https://figuescr.com/wp-content/uploads/Declaracion-2-Design.png" alt="Natural Pet Bakery">
        </div>
        <nav class="menu">
            <a href="menu.jsp">Volver al Menú</a>
        </nav>
        <form action="agregarUsuario.jsp" method="post">
            <input type="text" name="username" placeholder="Usuario" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <input type="text" name="nombre" placeholder="Nombre" required>
            <input type="text" name="apellido" placeholder="Apellido" required>
            <select name="sexo" required>
                <option value="M">Masculino</option>
                <option value="F">Femenino</option>
            </select>
            <input type="text" name="año_nacimiento" placeholder="Año de Nacimiento" required>
            <button type="submit">Agregar Usuario</button>
        </form>
    </div>
</body>
</html>