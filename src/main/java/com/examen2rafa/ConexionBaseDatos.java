package com.examen2rafa;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBaseDatos {
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/users";
    private static final String USUARIO = "root";
    private static final String CONTRASEÑA = "2207";

    public static Connection obtenerConexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("No se pudo cargar el controlador JDBC", e);
        }
        return DriverManager.getConnection(URL, USUARIO, CONTRASEÑA);
    }
}
   