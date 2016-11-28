/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dbconnection;

import java.sql.*;

/**
 *
 * @author KhoaAlienware
 */
public class DbConnection {

    private static Connection connection;
    private static String URL = "jdbc:mysql://localhost:3306/onlinestore?useUnicode=yes&characterEncoding=UTF-8";
    private static String username = "root";
    private static String password = "admin";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.jdbc.Driver");
        if (DbConnection.connection == null) {
            try {
                connection = DriverManager.getConnection(URL,username, password);
                System.out.println("Success!!");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        Connection conn = DbConnection.getConnection();
    }
}
