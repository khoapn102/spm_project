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

/**
 *
 * @author KhoaAlienware
 */
public class ProductDAO {

    private Connection conn;

    //Db Connection
    public ProductDAO() throws SQLException, ClassNotFoundException {
        conn = DbConnection.getConnection();
    }

    public String getTypeName(String pid) throws SQLException {
        String res = null;
        PreparedStatement pstmt = conn.prepareStatement("select c.type_name from product, category c where product.cid = c.cid and product.pid=?");
        pstmt.setString(1, pid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            res = rs.getString("type_name");
        }
        pstmt.close();
        rs.close();
        return res;
    }

    public List<String> getAllType() throws SQLException {
        List<String> res = new ArrayList<String>();
        Statement pstmt = conn.createStatement();
        ResultSet rs = pstmt.executeQuery("select c.type_name from product, category c where product.cid = c.cid order by product.pid");
        while (rs.next()) {
            String temp = rs.getString("type_name");
            res.add(temp);
        }
        pstmt.close();
        rs.close();
        return res;
    }

    public String getSpecificType(String cid) throws SQLException{
        String res = "";
        PreparedStatement pstmt = conn.prepareStatement("select c.type_name from product, category c where product.cid = c.cid and product.cid=?");
        pstmt.setString(1, cid);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            res = rs.getString("type_name");
        }
        pstmt.close();
        rs.close();
        return res;
    }
    
    public int countPid(String pid) throws SQLException, ClassNotFoundException{
        int res = 0;
        PreparedStatement pstmt = conn.prepareStatement("select pid from product where pid=?");
        pstmt.setString(1, pid);
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            res++;
        }
        pstmt.close();
        rs.close();
        return res;
    }
    
    //Using LIST to get All Products
    public List<Product> getAllProduct() throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from product");
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        stmt.close();
        rs.close();
        return prod;
    }
    
    public int getItemPrice(String pid) throws SQLException, ClassNotFoundException{
        PreparedStatement pstmt = conn.prepareStatement("select price from product where pid=?");
        pstmt.setString(1, pid);
        int res = 0;
        ResultSet rs = pstmt.executeQuery();
        while(rs.next()){
            res = rs.getInt("price");
        }
        pstmt.close();
        rs.close();
        return res;
    }
    
    public List<Product> getAllDiscountProduct() throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("select * from product where discount<>0");
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        stmt.close();
        rs.close();
        return prod;
    }
    
    public List<Product> recommendProduct(String pid) throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        
        Product x = getOneProduct(pid);
        
        PreparedStatement pstmt = conn.prepareStatement("select * from product where cid=? and pid<>?");
        pstmt.setString(1, x.getCid());
        pstmt.setString(2, x.getPid());
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        pstmt.close();
        rs.close();
        return prod;
    }

    public List<Product> getSimilarProduct(Product x) throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        PreparedStatement pstmt = conn.prepareStatement("select * from product where cid=? and pid<>?");
        pstmt.setString(1, x.getCid());
        pstmt.setString(2, x.getPid());
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        pstmt.close();
        rs.close();
        return prod;
    }

    public List<Product> getProductByCate(String cid) throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        PreparedStatement pstmt = conn.prepareStatement("select * from product where cid=?");
        pstmt.setString(1, cid);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        pstmt.close();
        rs.close();
        return prod;
    }

    public List<Product> getSearchProductByPrice(int low, int up) throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        String query = "select * from product where price >= '" + low + "' and price <= '" + up + "';";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        pstmt.close();
        rs.close();
        return prod;
    }
    
    public List<Product> getAllSearchedProducts(String[] categories, String discount, String price) throws SQLException, ClassNotFoundException {
        
        System.out.println("Searching products now");
        List<Product> prod = new ArrayList<Product>();
        
        String query = "select * from product where";
        
        int low = -1;
        int up = -1;

        if(price != null) {
           switch (price) {
                case "1.000.000 - 3.000.000":
                    low = 1000000;
                    up = 3000000;
                    break;
                case "3.000.000 - 5.000.000":
                    low = 3000000;
                    up = 5000000;
                    break;
                case "5.000.000 - 8.000.000":
                    low = 5000000;
                    up = 8000000;
                    break;
                case "Hơn 8.000.000":
                    low = 8000000;
                    up = 100000000;
                    break;
                default:
                    break;
            } 
        }
        
        int lowPercent = -1;
        int upPercent = -1;
        
        if(discount != null) {
            switch(discount) {
                case "0 - 20%":
                    lowPercent = 0;
                    upPercent = 20;
                    break;
                case "20 - 50%":
                    lowPercent = 20;
                    upPercent = 50;
                    break;
                case "Hơn 50%":
                    lowPercent = 50;
                    upPercent = 100;
                    break;
                default:
                    break;
            }
        }
        
        boolean foundCriteria = false;
        
        if(low != -1 && up != -1) {
            query += " price >= '" + low + "' and price <= '" + up + "'";
            foundCriteria = true;
        }
        
//        System.out.println(discount);
        
        if(lowPercent !=- 1 && upPercent != -1) {
            if(foundCriteria)
                query += " and discount >= '" + lowPercent + "' and discount <= '" + upPercent + "'";
            else {
                query += " discount >= '" + lowPercent + "' and discount <= '" + upPercent + "'";
                foundCriteria = true;
            }
        }
        
        if(categories != null) {
            int cateLen = categories.length;
        
            if(cateLen > 0) {
                if(foundCriteria)
                    query += " and (";
                else
                    query += " (";
                for(int i = 0; i < cateLen; i++) {
                    String cid = "";
                    switch(categories[i]) {
                        case "Phụ Kiện Nội Thất":
                            cid = "acc";
                            break;
                        case "Nội Thất Phòng Ngủ":
                            cid = "bed";
                            break;
                        case "Nội Thất Nhà Bếp":
                            cid = "kit";
                            break;
                        case "Nội Thất Phòng Khách":
                            cid = "liv";
                            break;
                        case "Nội Thất Văn Phòng":
                            cid = "off";
                            break;
                        default:
                            break;
                    }

                    if(i == 0)
                        query += "cid = '" + cid + "'";
                    else
                        query += " or cid = '" + cid + "'";
                }

                query += ")";
            }
        }
        
        query += ";";
        
        System.out.println(query);
        
//        String query = "select * from product where price >= '" + low + "' and price <= '" + up + "';";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        
        // System.out.println("List size " + prod.size());
        
        pstmt.close();
        rs.close();
        
        return prod;
    }

    public List<Product> getSearchProduct(String keyword) throws SQLException, ClassNotFoundException {
        List<Product> prod = new ArrayList<Product>();
        String query = "select * from product where pname like \'" + "%" + keyword + "%\' or pdesc like \'" + "%" + keyword + "%\'";
        PreparedStatement pstmt = conn.prepareStatement(query);
        ResultSet rs = pstmt.executeQuery();
        while (rs.next()) {
            Product temp = new Product();
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
            prod.add(temp);
        }
        pstmt.close();
        rs.close();
        return prod;
    }

    public Product getOneProduct(String pid) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("select * from product where pid=?");
        pstmt.setString(1, pid);
        ResultSet rs = pstmt.executeQuery();
        Product temp = new Product();
        while (rs.next()) {
            temp.setPid(rs.getString("pid"));
            temp.setCid(rs.getString("cid"));
            temp.setPname(rs.getString("pname"));
            temp.setDesc(rs.getString("pdesc"));
            temp.setPrice(rs.getInt("price"));
            temp.setQuantity(rs.getInt("quantity"));
            temp.setRating(rs.getInt("rating"));
            temp.setView(rs.getInt("view"));
            temp.setP_img(rs.getString("p_img"));
            temp.setDiscount(rs.getDouble("discount"));
        }
        pstmt.close();
        rs.close();
        return temp;
    }

    public int getQuantity(String pid) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("select quantity from product where pid=?");
        pstmt.setString(1, pid);
        ResultSet rs = pstmt.executeQuery();
        int q = -1;
        while (rs.next()) {
            q = Integer.parseInt(rs.getString("quantity"));
        }
        pstmt.close();
        rs.close();
        return q;
    }

    public void addProduct(Product p) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("insert into product(pid, cid, pname, pdesc, price, quantity, rating, view, p_img, discount) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        pstmt.setString(1, p.getPid());
        pstmt.setString(2, p.getCid());
        pstmt.setString(3, p.getPname());
        pstmt.setString(4, p.getDesc());
        pstmt.setDouble(5, p.getPrice());
        pstmt.setInt(6, p.getQuantity());
        pstmt.setInt(7, p.getRating());
        pstmt.setInt(8, p.getView());
        pstmt.setString(9, p.getP_img());
        pstmt.setDouble(10, p.getDiscount());
        pstmt.executeUpdate();
        pstmt.close();
    }

    public void removeProduct(String pid) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("delete from product where pid=?");
        pstmt.setString(1, pid);
        pstmt.executeUpdate();
        pstmt.close();
    }

    public void updateProduct(Product p) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("update product set cid=?, pname=?, pdesc=?, price=?, quantity=?, rating=?, view=?, p_img=?, discount=? where pid=?");
        pstmt.setString(1, p.getCid());
        pstmt.setString(2, p.getPname());
        pstmt.setString(3, p.getDesc());
        pstmt.setDouble(4, p.getPrice());
        pstmt.setInt(5, p.getQuantity());
        pstmt.setInt(6, p.getRating());
        pstmt.setInt(7, p.getView());
        pstmt.setString(8, p.getP_img());
        pstmt.setDouble(9, p.getDiscount());
        pstmt.setString(10, p.getPid());
        pstmt.executeUpdate();
        pstmt.close();
    }
//    

    public void updateQuantity(String pid, int quantity) throws SQLException, ClassNotFoundException {
        PreparedStatement pstmt = conn.prepareStatement("update product set quantity=? where pid=?");
        pstmt.setInt(1, quantity);
        pstmt.setString(2, pid);
        pstmt.executeUpdate();
        pstmt.close();
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

    public static void main(String[] args) throws SQLException, ClassNotFoundException {
        ProductDAO sdao = new ProductDAO();
        List<Product> s1 = sdao.getAllProduct();
        sdao.updateQuantity("tab1", 21);
        sdao.removeProduct("tab4");
        System.out.println(sdao.getSpecificType("bed"));
        List<String> s2 = sdao.getAllType();
        System.out.println(s2.get(0));
        String b = "bed2";
        System.out.println(b.substring(b.length()-1));
        System.out.println(sdao.countPid("tab3"));
    }
}
