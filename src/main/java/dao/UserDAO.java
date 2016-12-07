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

/**
 *
 * @author KhoaAlienware
 */
public class UserDAO {

    private Connection conn;

    //Connection to DB
    public UserDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }

    //Using LIST to get ALL users
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        List<User> users = new ArrayList<User>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from user");
            while (rs.next()) {
                User temp = new User();
                temp.setUid(rs.getInt("uid"));
                temp.setPassword(rs.getString("password"));
                temp.setFirst_name(rs.getString("first_name"));
                temp.setLast_name(rs.getString("last_name"));
                temp.setDob(rs.getString("dob"));
                temp.setPhone_number(rs.getString("phone_number"));
                temp.setAddress(rs.getString("address"));
                temp.setEmail(rs.getString("email"));
                temp.setIsManager(rs.getInt("isManager"));
                temp.setImage_url(rs.getString("u_img"));
                users.add(temp);
            }
            
            stmt.close();
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public User getOneUser(int uid) throws SQLException, ClassNotFoundException {
        User temp = new User();
        PreparedStatement pstmt = conn.prepareStatement("select * from user where uid = ?");
        pstmt.setInt(1, uid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            temp.setUid(rs.getInt("uid"));
            temp.setPassword(rs.getString("password"));
            temp.setFirst_name(rs.getString("first_name"));
            temp.setLast_name(rs.getString("last_name"));
            temp.setDob(rs.getString("dob"));
            temp.setPhone_number(rs.getString("phone_number"));
            temp.setAddress(rs.getString("address"));
            temp.setEmail(rs.getString("email"));
            temp.setIsManager(rs.getInt("isManager"));
            temp.setImage_url(rs.getString("u_img"));
        }
        
        pstmt.close();
        rs.close();
        return temp;
    }

    public User getOneUserByEmail(String email) throws SQLException, ClassNotFoundException {
        User temp = new User();
        //String query = "select * from user where email = "+email;
        PreparedStatement pstmt = conn.prepareStatement("select * from user where email = ?");
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            temp.setUid(rs.getInt("uid"));
            temp.setPassword(rs.getString("password"));
            temp.setFirst_name(rs.getString("first_name"));
            temp.setLast_name(rs.getString("last_name"));
            temp.setDob(rs.getString("dob"));
            temp.setPhone_number(rs.getString("phone_number"));
            temp.setAddress(rs.getString("address"));
            temp.setEmail(rs.getString("email"));
            temp.setIsManager(rs.getInt("isManager"));
            temp.setImage_url(rs.getString("u_img"));
        }
        
        pstmt.close();
        rs.close();
        return temp;
    }

    public String getPasswordOneUserByEmail(String email) throws SQLException, ClassNotFoundException {
        User temp = new User();
        //String query = "select * from user where email = "+email;
        PreparedStatement pstmt = conn.prepareStatement("select password from user where email = ?");
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        
        if(!rs.next()) {
            pstmt.close();
            rs.close();
            return null;
        }
        
        pstmt.close();
        rs.close();
        return rs.getString("password");
        
    }
    public List<String> getAllEmail() throws SQLException, ClassNotFoundException {
        List<String> email = new ArrayList<String>();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select email from user");
        while (rs.next()) {
            String temp = rs.getString("email");
            email.add(temp);
        }
        
        stmt.close();
        rs.close();
        return email;
    }

    public int countEmail(String email) throws SQLException, ClassNotFoundException {
        int count = 0;
        PreparedStatement pstmt = conn.prepareStatement("select email from user where email=?");
        pstmt.setString(1, email);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            count++;
        }
        
        pstmt.close();
        rs.close();
        return count;
    }

    public int addUser(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("insert into user(uid, password, first_name, last_name, DOB, phone_number, address, email, isManager, u_img) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        pstmt.setInt(1, u.getUid());
        pstmt.setString(2, u.getPassword());
        pstmt.setString(3, u.getFirst_name());
        pstmt.setString(4, u.getLast_name());
        pstmt.setString(5, u.getDob());
        pstmt.setString(6, u.getPhone_number());
        pstmt.setString(7, u.getAddress());
        pstmt.setString(8, u.getEmail());
        pstmt.setInt(9, u.getIsManager());
        pstmt.setString(10, u.getImage_url());
        pstmt.executeUpdate();
//      
        User user = getOneUserByEmail(u.getEmail());
        
        pstmt.close();
        return user.getUid();
    }

    public void addMember(User u) throws SQLException, ClassNotFoundException {

        java.util.Date date = new java.util.Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DATE);
        int year = cal.get(Calendar.YEAR);

        String cDate = String.valueOf(year) + "-" + String.valueOf(month) + "-" + String.valueOf(day);

        PreparedStatement pstmt = conn.prepareStatement("insert into member(mid, point, date_join) values (?, ?, ?)");

        int point = 0;

        pstmt.setInt(1, u.getUid());
        pstmt.setInt(2, point);
        pstmt.setString(3, cDate);

        pstmt.executeUpdate();
        
        pstmt.close();
    }

    public void removeUser(int uid) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("delete from user where uid=?");
        pstmt.setInt(1, uid);
        pstmt.executeUpdate();
        
        pstmt.close();
    }

    public void updateUserInfo(User u) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("update user set first_name=?, last_name=?, DOB=?, phone_number=?, address=?, email=?, isManager=?, u_img=? where uid=?");
        pstmt.setString(1, u.getFirst_name());
        pstmt.setString(2, u.getLast_name());
        pstmt.setString(3, u.getDob());
        pstmt.setString(4, u.getPhone_number());
        pstmt.setString(5, u.getAddress());
        pstmt.setString(6, u.getEmail());
        pstmt.setInt(7, u.getIsManager());
        pstmt.setString(8, u.getImage_url());
        pstmt.setInt(9, u.getUid());
        pstmt.executeUpdate();
        pstmt.close();
    }

    //Only Need to pass UID and PASSWORD
    public void updateUserPass(int uid, String pass) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("update user set password=? where uid=?");
        pstmt.setString(1, pass);
        pstmt.setInt(2, uid);
        pstmt.executeUpdate();
        pstmt.close();
    }

    //Need customer only;
    public List<User> getAllCustomer() throws SQLException {
        List<User> allcus = new ArrayList<User>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from user where isManager=0;");
            while (rs.next()) {
                User temp = new User();
                temp.setUid(rs.getInt("uid"));
                temp.setPassword(rs.getString("password"));
                temp.setFirst_name(rs.getString("first_name"));
                temp.setLast_name(rs.getString("last_name"));
                temp.setDob(rs.getString("dob"));
                temp.setPhone_number(rs.getString("phone_number"));
                temp.setAddress(rs.getString("address"));
                temp.setEmail(rs.getString("email"));
                temp.setIsManager(rs.getInt("isManager"));
                temp.setImage_url(rs.getString("u_img"));
                allcus.add(temp);
            }
            
            stmt.close();
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allcus;
    }

    public List<User> getAllEmployee() throws SQLException {
        List<User> allemp = new ArrayList<User>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("select * from user where isManager=1;");
            while (rs.next()) {
                User temp = new User();
                temp.setUid(rs.getInt("uid"));
                temp.setPassword(rs.getString("password"));
                temp.setFirst_name(rs.getString("first_name"));
                temp.setLast_name(rs.getString("last_name"));
                temp.setDob(rs.getString("dob"));
                temp.setPhone_number(rs.getString("phone_number"));
                temp.setAddress(rs.getString("address"));
                temp.setEmail(rs.getString("email"));
                temp.setIsManager(rs.getInt("isManager"));
                temp.setImage_url(rs.getString("u_img"));
                allemp.add(temp);
            }
            
            stmt.close();
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allemp;
    }

    public List<String> getAllSubscriber() throws SQLException {
        List<String> allsub = new ArrayList<String>();
        try {
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("(select email from user where isManager=0) union (select email from subscriber)");
            while (rs.next()) {
                allsub.add(rs.getString("email"));
            }
            
            stmt.close();
            rs.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return allsub;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        UserDAO sdao = new UserDAO();
//        List<User> s1 = sdao.getAllUsers();
//        System.out.println(s1.get(0).getUid() + " " + s1.get(0).getFirst_name());
        User u1 = sdao.getOneUserByEmail("b");
        System.out.println(u1.getFirst_name());
        u1.setFirst_name("LoLo");
        u1.setLast_name("Mimi");
        sdao.updateUserInfo(u1);
        List<User> s1 = sdao.getAllCustomer();
        System.out.println(s1.get(0).getUid() + " " + s1.get(0).getFirst_name());
        List<String> email = sdao.getAllEmail();
        System.out.println(email.get(1) + " " + email.get(0));
        int c = sdao.countEmail("e");
        System.out.println(c);
    }
    
    public void updatePoint(int sum, int uid) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("select point from member where mid=?");
        pstmt.setInt(1, uid);
        ResultSet rs = pstmt.executeQuery();
        
        int point = 0;
        
        while (rs.next()) {
            point = rs.getInt("point");
        }
        
        pstmt = conn.prepareStatement("update member set point=? where mid=?");
        point += (int)(sum / 10000);
        
        pstmt.setInt(1, point);
        pstmt.setInt(2, uid);
        pstmt.executeUpdate();
        
        pstmt.close();
        rs.close();
    }
}
