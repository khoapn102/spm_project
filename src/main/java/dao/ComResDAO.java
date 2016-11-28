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
import java.util.Date;

/**
 *
 * @author KP
 */
public class ComResDAO {

    private Connection conn;

    //Db Connection
    public ComResDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }
        
    //Get all comments of a Product
    public List<Comment> getAllComment(String pid) throws SQLException, ClassNotFoundException {
        List<Comment> comments = new ArrayList<Comment>();
        PreparedStatement pstmt = conn.prepareStatement("select * from comment where pid=? order by date_post, time_post");
        pstmt.setString(1, pid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Comment temp = new Comment();
            temp.setCmid(rs.getInt("cmid"));
            temp.setUcid(rs.getInt("ucid"));
            temp.setPid(rs.getString("pid"));
            temp.setContent(rs.getString("content"));
            temp.setDate(rs.getString("date_post"));
            temp.setTime(rs.getString("time_post"));
            comments.add(temp);
        }
        return comments;
    }

    public List<Response> getAllResponse(int cmid) throws SQLException, ClassNotFoundException {
        List<Response> responses = new ArrayList<Response>();
        PreparedStatement pstmt = conn.prepareStatement("select * from response where cmid=? order by date_post, time_post");
        pstmt.setInt(1, cmid);
        //pstmt.setInt(2, urid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Response temp = new Response();
            temp.setRid(rs.getInt("rid"));
            temp.setCmid(rs.getInt("cmid"));
            temp.setUrid(rs.getInt("urid"));
            temp.setContent(rs.getString("content"));
            temp.setDate(rs.getString("date_post"));
            temp.setTime(rs.getString("time_post"));
            responses.add(temp);
        }
        return responses;
    }

    public void addComment(Comment comment) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("insert into comment(ucid, pid, content, date_post, time_post) values (?,?,?,?,?)");
        pstmt.setInt(1, comment.getUcid());
        pstmt.setString(2, comment.getPid());
        pstmt.setString(3, comment.getContent());
        pstmt.setString(4, comment.getDate());
        pstmt.setString(5, comment.getTime());
        pstmt.executeUpdate();
    }

    public void addResponse(Response response) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("insert into response(cmid, urid, content, date_post, time_post) values (?,?,?,?,?)");
        pstmt.setInt(1, response.getCmid());
        pstmt.setInt(2, response.getUrid());
        pstmt.setString(3, response.getContent());
        pstmt.setString(4, response.getDate());
        pstmt.setString(5, response.getTime());
        pstmt.executeUpdate();
    }

    public String getText(String cmid, String pid, int ucid) throws SQLException, ClassNotFoundException {
        String content = "";
        PreparedStatement pstmt = conn.prepareStatement("select content from comment where cmid=? and pid=? and ucid=?");
        pstmt.setString(1, cmid);
        pstmt.setString(2, pid);
        pstmt.setInt(3, ucid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            content = rs.getString("content");
        }
        return content;
    }

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        ComResDAO cdao = new ComResDAO();
        /*Comment comment = new Comment();
         comment.setCmid(6);
         comment.setUcid(123);
         comment.setPid("tab1");
         comment.setContent("Today is a good day, Today is not a good day.....ba bla bablalbalbalbla");
         comment.setDate("24-11-2015");
         comment.setTime("11:00:00");
         cdao.addComment(comment);*/
        List<Comment> c = cdao.getAllComment("tab1");
        System.out.println(c.get(0));
        //List<Response> r = cdao.getAllResponse(2, 155);
        //System.out.println(r.get(0).getContent());
        List<Response> e = cdao.getAllResponse(2);
        System.out.println(e.get(0));
        List<Comment> comments = cdao.getAllComment("tab1");
        UserDAO udao = new UserDAO();
        if (comments.size() != 0) {
            for (int i = 0; i < comments.size(); i++) {
                int cmid = comments.get(i).getCmid();
                int ucid = comments.get(i).getUcid();
                Comment cm = comments.get(i); //to process each comment
                User utemp = udao.getOneUser(ucid); //to get User Name
                List<Response> resp = cdao.getAllResponse(cmid);
                System.out.println(cm);
                if (resp.size() != 0) {
                    for (int j = 0; j < resp.size(); j++) {
                        int cmid2 = resp.get(j).getCmid();
                        int urid = resp.get(j).getUrid();
                        Response r = resp.get(j);
                        User utemp2 = udao.getOneUser(urid);
                        System.out.println("        " + r);
                    }
                }
            }
        }
    }
}
