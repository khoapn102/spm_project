/* 
 * Copyright (C) 2016 Kppc
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
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
