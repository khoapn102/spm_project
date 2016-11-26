/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Product;
import model.User;
import shoppingcart.ShoppingServlet;

/**
 *
 * @author KP
 */
@WebServlet(name = "UserServlet2", urlPatterns = {"/controller.UserServlet2"})
public class UserServlet2 extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        String action = request.getParameter("action");

        User u = new User();

        UserDAO uDao = new UserDAO();

        HttpSession httpSession = request.getSession();
        /* TODO output your page here. You may use following sample code. */

        if (action == null) {
            response.sendRedirect("error.jsp");
        } else if (action.equals("login")) {
            String email = request.getParameter("email");

            String inputPass = request.getParameter("password");

            if (email == null || email.equals("") || inputPass == null || inputPass.equals("")) {
                response.sendRedirect("User/login.jsp?result=empty");
                return;
            }

            try {
                uDao = new UserDAO();

                u = uDao.getOneUserByEmail(email);

                String pass = u.getPassword();
                String currEmail = u.getEmail();

                if (!email.equals(currEmail) || !inputPass.equals(pass)) {
                    response.sendRedirect("User/login.jsp?result=wronglogin");
                    return;
                }

                if (u.getIsManager() == 0) {
                    ArrayList<Product> cart = new ArrayList<Product>();

                    httpSession.setAttribute("user", u);
                    
                    httpSession.setAttribute("cart", cart);
                    
                    ArrayList<Product> comp = new ArrayList<Product>();
                    
                    httpSession.setAttribute("comp", comp);

                    response.sendRedirect("index.jsp");
                } else if (u.getIsManager() == 1) {
                    ProductDAO pdao = new ProductDAO();
                    List<Product> allProd = pdao.getAllProduct();
                    httpSession.setAttribute("user", u);
                    httpSession.setAttribute("allProd", allProd);
                    response.sendRedirect("index.jsp");
                }

            } catch (SQLException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("register")) {
            String email = request.getParameter("email");
            int count = uDao.countEmail(email);
            if (count == 0) {
                u.setEmail(request.getParameter("email"));
                u.setPassword(request.getParameter("password"));
                u.setFirst_name(request.getParameter("firstname"));
                u.setLast_name(request.getParameter("lastname"));
                //u.setDob(request.getParameter("dob"));
                String date = request.getParameter("date");
                String month = request.getParameter("month");
                String year = request.getParameter("year");
                String dob = date + "-" + month + "-" + year;
                u.setDob(dob);
                u.setPhone_number(request.getParameter("tel"));
                u.setIsManager(0);
                u.setAddress(request.getParameter("address"));
                u.setImage_url(request.getParameter("u_img"));

                u.setUid(uDao.addUser(u));

                uDao.addMember(u);

                User eUser = (User) httpSession.getAttribute("user");

                if (eUser != null) {
                    httpSession.removeAttribute("user");
                    httpSession.removeAttribute("cart");
                }

                ArrayList<Product> cart = new ArrayList<Product>();

                httpSession.setAttribute("user", u);

                httpSession.setAttribute("cart", cart);
                
                ArrayList<Product> comp = new ArrayList<Product>();
                
                httpSession.setAttribute("comp", comp);

                response.sendRedirect("index.jsp");
            } else if (count > 0) {
                response.sendRedirect("../WebProj/User/register.jsp?result=error");

            }

        } else if (action.equals("changepass")) {
            String password = request.getParameter("newpass");
            u = (User) httpSession.getAttribute("user");
            u.setPassword(password);
            uDao.updateUserPass(u.getUid(), password);
            httpSession.setAttribute("user", u);
            response.sendRedirect("User/profile.jsp");
        } else if (action.equals("changeinfo")) {
            u = (User) httpSession.getAttribute("user");
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String dob = request.getParameter("dob");
            String phone = request.getParameter("tel");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            u.setFirst_name(firstname);
            u.setLast_name(lastname);
            u.setDob(dob);
            u.setAddress(address);
            u.setEmail(email);
            u.setPhone_number(phone);
            httpSession.setAttribute("user", u);
            uDao.updateUserInfo(u);
            response.sendRedirect("User/profile.jsp");
        } else if (action.equals("logout")) {
            httpSession.invalidate();
            response.sendRedirect("index.jsp");

        } else if (action.equals("delete")) {
            int uid = Integer.parseInt(request.getParameter("uid").trim());
            uDao.removeUser(uid);
            out.write("<script type='text/javascript'>\n");
            out.write("alert('Database Successfully Updated !!');\n");
            out.write("window.location.href='../WebProj/Product/storemanage.jsp';");
            out.write("</script>\n");
            //response.sendRedirect("../Product/storemanage.jsp");
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
            Logger.getLogger(UserServlet.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UserServlet.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserServlet.class
                    .getName()).log(Level.SEVERE, null, ex);
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
