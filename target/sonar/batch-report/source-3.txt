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
import dbconnection.*;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;
import controller.VerifyUtils;
/**
 *
 * @author HungPhanN53SV
 */
@WebServlet(name = "CommentServlet", urlPatterns = {"/CommentServlet"})
public class CommentServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        
        try {
            request.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            PrintWriter out = response.getWriter();
            String action = request.getParameter("action");
            ComResDAO crDAO = new ComResDAO();

            Date date = new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(date);
            int month = cal.get(Calendar.MONTH) + 1;
            int day = cal.get(Calendar.DATE);
            int year = cal.get(Calendar.YEAR);

            String cDate = String.format("%d", year) + "-" + String.format("%02d", month) + "-" + String.format("%02d", day);

            int hour = cal.get(Calendar.HOUR_OF_DAY);
            int minute = cal.get(Calendar.MINUTE);
            int second = cal.get(Calendar.SECOND);

            String cTime = String.format("%02d", hour) + ":" + String.format("%02d", minute) + ":" + String.format("%02d", second);

            Comment cm = new Comment();
            Response r = new Response();
            String pid_t = request.getParameter("pid");

            if(action == null){
                response.sendRedirect("index.jsp");
                return;
            }        
            else if(action.compareTo("newcomment") == 0){
                String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
                boolean valid = VerifyUtils.verify(gRecaptchaResponse);
                
                if (!valid) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('Please complete the captcha !');\n");
                    out.write("window.location.href='Product/view.jsp?pid=" + pid_t + "';");
                    out.write("</script>\n");
                    return;
                }
                cm.setContent(request.getParameter("content"));
                cm.setDate(cDate);
                cm.setPid(request.getParameter("pid"));
                cm.setTime(cTime);
                cm.setUcid(Integer.parseInt(request.getParameter("ucid")));
                crDAO.addComment(cm);

                String url = "Product/view.jsp?pid="+ pid_t;
                response.sendRedirect(url);
                return;
            }
            else if(action.compareTo("newresponse") == 0){            
                r.setCmid(Integer.parseInt(request.getParameter("cmid")));
                r.setContent(request.getParameter("content"));
                r.setDate(cDate);
                r.setTime(cTime);
                r.setUrid(Integer.parseInt(request.getParameter("ucid")));
                crDAO.addResponse(r);

                response.sendRedirect("Product/view.jsp?pid="+pid_t);
                return;
            }
            else{
                response.sendRedirect("index.jsp");
                return;
            }
        }
        catch(Exception e) {
            
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
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
