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
package dao;

import model.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import dbconnection.DbConnection;
import java.util.Calendar;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

/**
 *
 * @author HungPhanN53SV
 */
public class SubscriberDAO {

    private Connection conn;

    //Connection to DB
    public SubscriberDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }

    public boolean checkExist(Subscriber s) throws SQLException {
        String email = s.getEmail();
        if(email==null) return true;
        try {
            InternetAddress emailAddr = new InternetAddress(email);
            emailAddr.validate();
        } catch (AddressException ex) {
            return true;
        }
    
        PreparedStatement psmt = conn.prepareStatement(
                "select * FROM 	((select * from subscriber where email='"+email+"') UNION (select email from user where email='"+email+"')) t");
        ResultSet rs = psmt.executeQuery();

        if (rs.next())  return true;

        return false;  
    }
    
    public void addSubscriber(Subscriber s) throws SQLException{
        PreparedStatement psmt = conn.prepareStatement(
                "insert into subscriber(email) values (?)");
        psmt.setString(1, s.getEmail());
        psmt.executeUpdate();        
    }
    
    public static void main(String args[]) throws SQLException, ClassNotFoundException{
        SubscriberDAO sd = new SubscriberDAO();
        Subscriber s = new Subscriber();
        //s.setEmail("phithangcung@gmail.com");
        s.setEmail("hungphan.cseiu.dip@gmail.com");
        //boolean k = sd.checkExist(s);
        sd.addSubscriber(s);
        
    }
    
}
