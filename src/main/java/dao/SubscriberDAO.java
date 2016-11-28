/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
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
