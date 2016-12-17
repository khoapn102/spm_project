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
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

/**
 *
 * @author KP
 * 
 */
public class OrderDAO {

    private Connection conn;

    //Db Connection
    public OrderDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }

    //Using LIST to get All Products
    public List<Order> getAllOrder() throws SQLException, ClassNotFoundException {
        List<Order> ords = new ArrayList<Order>();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from orders");
        while (rs.next()) {
            Order temp = new Order();
            temp.setMid(rs.getInt("mid"));
            temp.setPid(rs.getString("pid"));
            temp.setDate(rs.getString("odate"));
            temp.setTime(rs.getString("otime"));
            temp.setQuantity(rs.getInt("quantity"));
            ords.add(temp);
        }
        stmt.close();
        rs.close();
        return ords;
    }

    public Set getReport() throws SQLException, ClassNotFoundException{
        HashMap r = new HashMap();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select pid, sum(quantity) qt from orders group by(pid)");
        while(rs.next()){
            r.put(rs.getString("pid"), rs.getInt("qt"));
        }
        Set report = r.entrySet();
        stmt.close();
        rs.close();
        return report;
    }
    
    public Order getOneProduct(int mid, String pid, String date, String time) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("select * from product where mid=? and pid=? and date=? and time=?");
        pstmt.setInt(1, mid);
        pstmt.setString(2, pid);
        pstmt.setString(3, date);
        pstmt.setString(4, time);
        ResultSet rs = pstmt.executeQuery();
        Order temp = new Order();
        while (rs.next()) {
            temp.setMid(rs.getInt("mid"));
            temp.setPid(rs.getString("pid"));
            temp.setDate(rs.getString("date"));
            temp.setTime(rs.getString("time"));
        }
        pstmt.close();
        rs.close();
        return temp;
    }

    public void updateOrders(User u, ArrayList<Product> cart) throws SQLException {

        Date date = new Date();
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int month = cal.get(Calendar.MONTH) + 1;
        int day = cal.get(Calendar.DATE);
        int year = cal.get(Calendar.YEAR);

        String cDate = String.valueOf(year) + "-" + String.valueOf(month) + "-" + String.valueOf(day);

        int hour = cal.get(Calendar.HOUR_OF_DAY);
        int minute = cal.get(Calendar.MINUTE);
        int second = cal.get(Calendar.SECOND);

        String cTime = String.valueOf(hour) + ":" + String.valueOf(minute) + ":" + String.valueOf(second);

        for (int i = 0; i < cart.size(); i++) {
            PreparedStatement pstmt = conn.prepareStatement("insert into orders(mid, pid, odate, otime, quantity) values (?, ?, ?, ?, ?)");
            pstmt.setInt(1, u.getUid());
            pstmt.setString(2, cart.get(i).getPid());
            pstmt.setString(3, cDate);
            pstmt.setString(4, cTime);
            pstmt.setInt(5, cart.get(i).getQuantity());
            pstmt.executeUpdate();
            pstmt.close();
        }
    }

    public void deleteOrder(int mid, String pid, String odate, String otime) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("delete from orders where mid=? and pid=? and odate=? and otime=?");
        pstmt.setInt(1, mid);
        pstmt.setString(2, pid);
        pstmt.setString(3, odate);
        pstmt.setString(4, otime);
        pstmt.executeUpdate();
        pstmt.close();
    }

    public void updateDbOrder(int mid, String pid, String odate, String otime, int quantity) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("update orders set quantity=? where mid=? and pid=? and odate=? and otime=?");
        pstmt.setInt(1, quantity);
        pstmt.setInt(2, mid);
        pstmt.setString(3, pid);
        pstmt.setString(4, odate);
        pstmt.setString(5, otime);
        pstmt.executeUpdate();
        pstmt.close();
    }

    public List<Order> getBestSeller() throws SQLException, ClassNotFoundException {
        List<Order> best = new ArrayList<Order>();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select pid, sum(quantity) as sumq from orders group by pid desc having sumq >= 5 order by sumq ");
        while (rs.next()) {
            Order temp = new Order();
            temp.setMid(0);
            temp.setPid(rs.getString("pid"));
            temp.setDate("####");
            temp.setTime("###");
            temp.setQuantity(rs.getInt("sumq"));
            best.add(temp);
        }
        stmt.close();
        rs.close();
        return best;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        OrderDAO odao = new OrderDAO();
        List<Order> or = odao.getAllOrder();
        //System.out.println(or.get(1).getPid() + " " + or.get(1).getTime());
        for (int i = 0; i < or.size(); i++) {
            System.out.println(or.get(i));
        }
        Order o1 = new Order();
        o1.setMid(153);
        o1.setPid("tab3");
        o1.setDate("2015-11-19");
        o1.setTime("9:42:56");
        o1.setQuantity(2);
        odao.updateDbOrder(153, "tab3", "2015-11-19", "9:42:56", 3);
        or = odao.getBestSeller();
        for (int i = 0; i < or.size(); i++) {
            System.out.println(or.get(i).getPid());
        }
        /*Set r = odao.getReport();
        Iterator i = r.iterator();
        while(i.hasNext()){
            Map.Entry me = (Map.Entry)i.next();
            System.out.println(me.getKey() + " " + me.getValue().toString());
            //System.out.println(me.getValue());
        }*/
    }
}
