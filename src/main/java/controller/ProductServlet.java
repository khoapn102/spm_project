package controller;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import dao.ProductDAO;
import dao.UserDAO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Mail;
import model.Product;

/**
 *
 * @author KP
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/ProductServlet"})
public class ProductServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    //private static final String save_dir = "image";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");
        String sessionPid = request.getParameter("pid");
        HttpSession session = request.getSession();
        ProductDAO pdao = new ProductDAO();
        UserDAO udao = new UserDAO();
//        out.println("Hello world");

//        System.out.println("Hello world");
        
        if (action == null) {
            response.sendRedirect("error.jsp");
            return;
        }

        if (action.equals("search")) {

            List<Product> productList = null;

            String keyWord = request.getParameter("searchkeyword");

            String pid = request.getParameter("rpid");

            String price = request.getParameter("price");
            String discount = request.getParameter("discount");
            String[] categories = request.getParameterValues("category");
            
            String header = "";
            
//            System.out.println(price + " " + discount + " " + categories);

            if(pid != null) {
                header = "<h3 class=\"m_1\">Sản phẩm tương tự:</h3>";
                productList = pdao.recommendProduct(pid);
            }
            else {
                header = "<h3 class=\"m_1\">Kết quả tìm kiếm</h3>";
                if (keyWord != null && !keyWord.equals("Tìm kiếm")) {
                    productList = pdao.getSearchProduct(keyWord);
                }
                else if(price != null && categories != null && discount != null) {
                    productList = pdao.getAllSearchedProducts(categories, discount, price);
                }
            }
            
            session.setAttribute("header", header);
            session.setAttribute("searchList", productList);
            response.sendRedirect("Product/search.jsp");
        }
        else if (action.equals("edit")) {
            //String sessionPid = (String)session.getAttribute("prodPid");
            Product temp = pdao.getOneProduct(sessionPid);
            //String pid = request.getParameter("pid");
            String pname = request.getParameter("pname");
            //String cid = request.getParameter("cid");
            String desc = request.getParameter("desc");
            //String p_img = request.getParameter("image");
            //int rating = Integer.parseInt(request.getParameter("rating").trim());
            //int view = Integer.parseInt(request.getParameter("view").trim());
            int quantity = Integer.parseInt(request.getParameter("quantity").trim());
            int price = Integer.parseInt(request.getParameter("price").trim());
            double discount = Double.parseDouble(request.getParameter("discount").trim());
            //temp.setPid(pid);
            temp.setPname(pname);
            //temp.setCid(cid);
            temp.setDesc(desc);
            temp.setPrice(price);
            temp.setDiscount(discount);
            //temp.setView(view);
            //temp.setRating(rating);
            //temp.setP_img(p_img);
            temp.setQuantity(quantity);
            pdao.updateProduct(temp);
            out.write("<script type='text/javascript'>\n");
            out.write("alert('Database Successfully Updated !!');\n");
            out.write("setTimeout(function(){window.location.href='../WebProj/Product/storemanage.jsp'},25);");
            out.write("</script>\n");
            //RequestDispatcher rd = request.getRequestDispatcher("../Product/storemanager.jsp");
            //rd.forward(request, response);
            //response.sendRedirect("../WebProj/Product/storemanage.jsp?result=success");
        } else if (action.equals("delete")) {
            pdao.removeProduct(sessionPid);
            List<Product> allProd = pdao.getAllProduct();
            session.setAttribute("allProd", allProd);
            out.write("<script type='text/javascript'>\n");
            out.write("alert('Database Successfully Updated !!');\n");
            out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
            out.write("</script>\n");
        } else if(action.equals("rate")){
            String pid = request.getParameter("pid");
            int star = Integer.parseInt(request.getParameter("rating"));
            Product p = pdao.getOneProduct(pid);
            double avg_star = (p.getRating() + star) / 2;
            int avgstar = (int) avg_star;
            System.out.println(avgstar);
            p.setView(p.getView()+1);
            p.setRating(avgstar);
            pdao.updateProduct(p);
            p = pdao.getOneProduct(pid);
            
            response.sendRedirect("../WebProj/Product/view.jsp?pid="+pid);
        } else if (action.equals("add")) {
            /*String pid = request.getParameter("pid");
             if (pid.equals("0")) {
             pid = request.getParameter("othername");
             }*/
            String pid = request.getParameter("pid");
            int c = pdao.countPid(pid);
            if (c == 0) {
                String pname = request.getParameter("pname");
                String cid = request.getParameter("cid");
                String desc = request.getParameter("desc");
                //String p_img = request.getParameter("image");
                //String othername = request.getParameter("othername");
                int rating = Integer.parseInt(request.getParameter("rating").trim());
                int view = Integer.parseInt(request.getParameter("view").trim());
                int quantity = Integer.parseInt(request.getParameter("quantity").trim());
                int price = Integer.parseInt(request.getParameter("price").trim());
                double discount = Double.parseDouble(request.getParameter("discount").trim());

                //File part
                int last = pid.length() - 1;

                String p_img = "image/" + cid + "/" + pid.substring(last) + "/";

                Product temp = new Product();
                temp.setPid(pid);
                temp.setPname(pname);
                temp.setCid(cid);
                temp.setDesc(desc);
                temp.setPrice(price);
                temp.setDiscount(discount);
                temp.setView(view);
                temp.setRating(rating);
                temp.setP_img(p_img);
                temp.setQuantity(quantity);
                pdao.addProduct(temp);
                session.setAttribute("tempPid", pid);
                session.setAttribute("tempCid", cid);
                
                Product newProduct = temp;
                Mail mail = new Mail();
                String content =
                        "<html>\n" + 
                        "<body>\n" + 
                        "<h1>Thông báo về sản phẩm mới</h1>\n" + 
                        "<p>Chúng tôi vừa nhập sản phẩm mới \"<b>"+pname+"</b>\"<br/>" +
                        "Chúng tôi kính mời quý khách hàng ghé thăm và trải nghiệm tại cửa hàng của chúng tôi<br/>" +
                        "Xin chân thành cám ơn quý khách,</p>" +
                        "<p>----------------<br/><b>XƯỞNG MỘC NGUYỄN VĂN QUÝ<br/>" +
                        "Cơ sở 1: 449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>" +
                        "Cơ sở 2: 449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>" +
                        "Điện thoại: 08.5407.0556 - Đường dây nóng: 0938.200.871</b></p>" +
                        "</body>\n" + 
                        "</html>\n"; 

                mail.setSender("nguyenvanquy.woodworkshop@gmail.com");
                mail.setPwd("nguyenvanquy");
                mail.setRecipient(udao.getAllSubscriber());
                mail.setSubject("[Sản phẩm mới]");
                mail.setContent(content);
                session.setAttribute("mail", mail);
                //session.setAttribute("newProduct", newProduct);
                
                /*out.write("<script type='text/javascript'>\n");
                 out.write("alert('Database Successfully Updated !!');\n");
                 out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
                 out.write("</script>\n");*/
                response.sendRedirect("Product/addPicture.jsp");
            } else {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('!!!ERROR: Database Conflict!!! PID is not available');\n");
                out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
                out.write("</script>\n");
            }
        }
    }

    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
