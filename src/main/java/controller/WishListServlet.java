/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
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
 * @author Triet Le
 */
@WebServlet(urlPatterns = {"/controller.WishListServlet"})
public class WishListServlet extends HttpServlet {
    /*
     * To change this license header, choose License Headers in Project Properties.
     * To change this template file, choose Tools | Templates
     * and open the template in the editor.
     */

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        response.setContentType("text/html");
//
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        HttpSession httpSession = request.getSession();

        User u = (User) httpSession.getAttribute("user");

        if (u == null) {
            out.write("<script type='text/javascript'>\n");
            out.write("alert('You must login first!!!');\n");
            String url = "User/login.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");
        } 
        else if(action == null) {
            out.write("<script type='text/javascript'>\n");
            out.write("alert('Your request is not valid!!!');\n");
            String url = "index.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");
        }
        else if(u.getIsManager() == 1) {
            out.write("<script type='text/javascript'>\n");
            out.write("alert('You must login as customer to perform this task!!!');\n");
            String url = "index.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");
        }
        else if (action.equals("add")) {

            String pid = request.getParameter("pid");

            if (pid == null || pid.equals("")) {

                out.write("<script type='text/javascript'>\n");
                out.write("alert('The product does not exist');\n");
                String url = "index.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");

                return;
            }

            try {
                ProductDAO pDao = new ProductDAO();
                
                Product p = pDao.getOneProduct(pid);
                
                if(p.getPid() == null) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The product does not exist!!!');\n");
                    String url = "index.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }
                
                WishListDAO wDao = new WishListDAO();
                
                boolean w = wDao.getOneWishList(u, pid);

                if (w) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The product has already been added to your wishlist!!!');\n");
                    String url = "Product/view.jsp?pid=" + pid;
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }

                wDao.updateWishList(u, pid);

                response.sendRedirect("Product/view.jsp?pid=" + pid);
            } catch (SQLException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("delete")) {
            String pid = request.getParameter("pid");

            if (pid == null) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('The product does not exist!!!');\n");
                String url = "Product/wishlist.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            WishListDAO wDao;
            try {
                wDao = new WishListDAO();

                boolean w = wDao.getOneWishList(u, pid);

                if (!w) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The product is not in your wishlist');\n");
                    String url = "Product/wishlist.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }
                
                wDao.deleteWishList(u, pid);
                
                List<String> wl = (List<String>) wDao.getWishListByMid(u.getUid());

                out.write("<script type='text/javascript'>\n");
                
                if(wl.size() == 0)
                    out.write("alert('The product has been removed from your wishlist. Your wishlist is now empty!!!');\n");
                else 
                    out.write("alert('The product has been removed from your wishlist!!!');\n");
                
                String url = "Product/wishlist.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");

            } catch (SQLException ex) {
                Logger.getLogger(WishListServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(WishListServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
