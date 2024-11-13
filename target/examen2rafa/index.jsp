<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="Login.css">
</head>
<body>
    <div class="body"></div>
    <div class="grad"></div>
    <div class="header">
        <div>Hospi<span>tal.ktz</span></div>
    </div>
    <br>
    <form action="login.jsp" method="post">
        <div class="login">
            <input type="text" placeholder="usuario" name="username"><br>
            <input type="password" placeholder="contraseña" name="password"><br>
            <input type="submit" value="Login">
        </div>
    </form>
    <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger">
            <%= request.getParameter("error").equals("1") ? "Usuario o contraseña incorrectos" : "Error en el servidor: " + request.getParameter("mensaje") %>
        </div>
    <% } %>
</body>
</html>