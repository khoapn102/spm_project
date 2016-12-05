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

import dbconnection.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import model.User;
import model.WishList;

/**
 *
 * @author Triet Le
 */
public class WishListDAO {

    private Connection conn;

    //Db Connection
    public WishListDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }

    public List<WishList> getAllWishList() throws SQLException {
        List<WishList> list = new ArrayList<WishList>();

        PreparedStatement pstmt = conn.prepareStatement("select * from wishlist");
        ResultSet rs = pstmt.executeQuery();

        while (rs.next()) {
            WishList w = new WishList();
            w.setMid(rs.getInt("mid"));
            w.setPid(rs.getString("pid"));
            w.setDate(rs.getString("date"));
            w.setTime(rs.getString("time"));
            list.add(w);
        }

        return list;
    }
    
    public boolean getOneWishList(User u, String pid) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("select * from wishlist where mid=? and pid=?");
        pstmt.setInt(1, u.getUid());
        pstmt.setString(2, pid);
        
        ResultSet rs = pstmt.executeQuery();
        
        if(rs.next())
            return true;
        
        return false;
        
//        WishList w = new WishList();
//        
//        while(rs.next()) {
//            w.setMid(rs.getInt("mid"));
//            w.setPid(rs.getString("pid"));
//            w.setDate(rs.getString("date"));
//            w.setTime(rs.getString("time"));
//        }
//        
//        rs.close();
//        
//        return w;
    }

    public List<Integer> getWishListByPid(String pid) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("select * from wishlist where pid=?");

        pstmt.setString(1, pid);

        ResultSet rs = pstmt.executeQuery();
        
        List<Integer> uidList = new ArrayList<Integer>();

        while (rs.next()) {
            uidList.add(rs.getInt("mid"));
        }

        rs.close();

        return uidList;
    }

    public List<String> getWishListByMid(int mid) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("select * from wishlist where mid=?");

        pstmt.setInt(1, mid);

        ResultSet rs = pstmt.executeQuery();

        List<String> pidList = new ArrayList<String>();

        while (rs.next()) {
            pidList.add(rs.getString("pid"));
        }

        rs.close();

        return pidList;
    }

    public void updateWishList(User u, String pid) throws SQLException {
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

        PreparedStatement pstmt = conn.prepareStatement("insert into wishlist(mid, pid, date, time) values (?, ?, ?, ?)");
        pstmt.setInt(1, u.getUid());
        pstmt.setString(2, pid);
        pstmt.setString(3, cDate);
        pstmt.setString(4, cTime);
        pstmt.executeUpdate();

    }
    
    public void deleteWishList(User u, String pid) throws SQLException {
        PreparedStatement pstmt = conn.prepareStatement("delete from wishlist where mid=? and pid=?");
        pstmt.setInt(1, u.getUid());
        pstmt.setString(2, pid);
        
        pstmt.executeUpdate();
    }
}
