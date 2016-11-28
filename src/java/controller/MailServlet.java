/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import com.sun.org.apache.xml.internal.security.exceptions.Base64DecodingException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import dao.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.HttpSession;

/**
 *
 * @author HungPhanN53SV
 */
@WebServlet(name = "MailServlet", urlPatterns = {"/MailServlet"})
public class MailServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException, Base64DecodingException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        HttpSession httpSession = request.getSession();

        boolean sendingStatus;
        Mail mail = (Mail) httpSession.getAttribute("mail");
        MailDAO md;

        if (action.compareTo("notify") == 0) {
            md = new MailDAO(mail.getSender(), mail.getPwd());
            sendingStatus = md.sendToPeople(mail.getRecipient(), mail.getSubject(), mail.getContent());
            if (sendingStatus == false) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('Notify Mail has been failed !');\n");
                out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
                out.write("</script>\n");
                //response.sendRedirect("Product/storemanage.jsp");
                return;
            } else {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('Notify Mail was sent successfully !');\n");
                out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
                out.write("</script>\n");
                //response.sendRedirect("Product/storemanage.jsp");
                return;
            }

        } else if (action.compareTo("contact") == 0) {
            String content
                    = "<html>\n"
                    + "<body>\n"
                    + "<h1>Tin nhắn liên hệ từ khách hàng</h1>\n"
                    + "<p><b>Tên khách hàng</b>: " + request.getParameter("author") + "<br/>\n"
                    + "<b>Email của khách hàng</b>: " + request.getParameter("email") + "<br/>\n"
                    + "<b>Nội dung tin nhắn</b>: " + request.getParameter("message") + "</p>\n"
                    + "</body>\n"
                    + "</html>\n";

            md = new MailDAO("woodonline.store@gmail.com", "woodshop123");
            md.sendToPerson("woodonline.store@gmail.com", "[Liên Hệ]", content);
            //md.sendToPerson("nguyenvanquy.woodworkshop@gmail.com", "[Liên Hệ]", "Từ: " + request.getParameter("email") + "<br/>" + request.getParameter("message"));

            response.sendRedirect("mailStatus.jsp?status=success");
            return;

        } else if (action.compareTo("billing") == 0) {
            md = new MailDAO(mail.getSender(), mail.getPwd());
            sendingStatus = md.sendToPerson(mail.getRecipient().get(0), mail.getSubject(), mail.getContent());
            if (sendingStatus == false) {
                response.sendRedirect("mailStatus.jsp?status=fail");
                return;
            } else {
                response.sendRedirect("Transaction/billing.jsp");
                return;
            }
        } else if (action.compareTo("forgetPassword") == 0) {
            UserDAO uDAO = new UserDAO();
            String email_t = request.getParameter("forgetEmail");
            String pass = PasswordProtection.decrypt(uDAO.getPasswordOneUserByEmail(email_t));

            if (pass == null) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('Email does not exit or Email is invalid !');\n");
                out.write("window.location.href='../WebProj/User/login.jsp';");
                out.write("</script>\n");
                return;
            } else {
                String content
                        = "<html>\n"
                        + "<body>\n"
                        + "<h1>Nhắc mật khẩu</h1>\n"
                        + "<p>Mật khẩu tài khoản <b>"+email_t+"</b> là: " + pass +"<br/>\n"
                        + "<p>Quý khách vui lòng dùng mật khẩu trên, truy cập vào trang của cửa hàng để mua sắm </p>"
                        + "<p>----------------<br/><b>XƯỞNG MỘC NGUYỄN VĂN QUÝ<br/>"
                        + "Cơ sở 1: 449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>"
                        + "Cơ sở 2: 449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>"
                        + "Điện thoại: 08.5407.0556 - Đường dây nóng: 0938.200.871</b></p>"
                        + "</body>"
                        + "</html>\n";

                md = new MailDAO("woodonline.store@gmail.com", "woodshop123");
                md.sendToPerson(email_t, "[Nhắc mật khẩu]", content);
                //md.sendToPerson("nguyenvanquy.woodworkshop@gmail.com", "[Liên Hệ]", "Từ: " + request.getParameter("email") + "<br/>" + request.getParameter("message"));

                out.write("<script type='text/javascript'>\n");
                out.write("alert('Check your mail for the password !');\n");
                out.write("window.location.href='../WebProj/User/login.jsp';");
                out.write("</script>\n");
                return;
            }

        } else {
            response.sendRedirect("index.jsp");
            return;
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
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Base64DecodingException ex) {
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Base64DecodingException ex) {
            Logger.getLogger(MailServlet.class.getName()).log(Level.SEVERE, null, ex);
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
