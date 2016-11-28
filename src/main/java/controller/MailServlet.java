/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;
import dao.*;
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
            throws ServletException, IOException {
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
            
        } else if (action.compareTo("contact") == 0 ) {
            String content =
                    "<html>\n" + 
                    "<body>\n" + 
                    "<h1>Tin nhắn liên hệ từ khách hàng</h1>\n" +
                    "<p><b>Tên khách hàng</b>: "+request.getParameter("author")+"<br/>\n" +
                    "<b>Email của khách hàng</b>: "+request.getParameter("email")+"<br/>\n" +
                    "<b>Nội dung tin nhắn</b>: "+request.getParameter("message")+"</p>\n" +
                    "</body>\n" + 
                    "</html>\n";
            
            md = new MailDAO("lh.nguyenvanquy.woodworkshop@gmail.com","nguyenvanquy");
            md.sendToPerson("nguyenvanquy.woodworkshop@gmail.com", "[Liên Hệ]", content);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
