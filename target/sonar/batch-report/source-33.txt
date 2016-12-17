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
package shoppingcart;

/**
 *
 * @author Triet Le
 */
import dao.*;
import model.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
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

/**
 *
 * @author Triet Le
 */
@WebServlet(urlPatterns = {"/shoppingcart.ShoppingServlet"})
public class ShoppingServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        request.setCharacterEncoding("UTF-8");

        response.setContentType("text/html");
//
        PrintWriter out = response.getWriter();

        String action = request.getParameter("action");

        ArrayList<Product> cart = new ArrayList<Product>();

        HttpSession httpSession = request.getSession();

        User u = (User) httpSession.getAttribute("user");

        if (u == null) {
            out.write("<script type='text/javascript'>\n");
            out.write("alert('You must login first!!!');\n");
            String url = "User/login.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");
        } 
        else if (action == null) {
            out.write("<script type='text/javascript'>\n");
            out.write("alert('Your request is not valid!!!');\n");
            String url = "index.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");
        } 
        else if (u.getIsManager() == 1) {
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
//                    response.sendRedirect("Product/view.jsp?pid=" + pid);
                return;
            }

            try {

                ProductDAO pDao = new ProductDAO();

                Product p = pDao.getOneProduct(pid);

                if (p.getPid() == null) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The product does not exist');\n");
                    String url = "index.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
//                    response.sendRedirect("Product/view.jsp?pid=" + pid);
                    return;
                }

                String q = request.getParameter("quantity");

                if (q == null || q.equals("")) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The quantity is not valid');\n");
                    String url = "Product/view.jsp?pid=" + pid;
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }

                int quantity = Integer.parseInt(q);

                cart = (ArrayList<Product>) httpSession.getAttribute("cart");

                int i = 0;

                for (; i < cart.size(); i++) {
                    Product c = cart.get(i);
                    if (c.getPid().equals(pid)) {
                        break;
                    }
                }

                if ((i == cart.size() && quantity > p.getQuantity()) || (i < cart.size() && (quantity + cart.get(i).getQuantity()) > p.getQuantity())) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('Exceeded the quantity in stock');\n");
                    String url = "Product/view.jsp?pid=" + pid;
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }

                if (i == cart.size()) {
                    p.setQuantity(quantity);
                    cart.add(p);
                } else {
                    cart.get(i).setQuantity(cart.get(i).getQuantity() + quantity);
                }

                httpSession.setAttribute("cart", cart);

                response.sendRedirect("Transaction/shoppingcart.jsp");
//                RequestDispatcher requestDispatcher = request.getRequestDispatcher("product.jsp");
//                requestDispatcher.forward(request, response);
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
                String url = "Transaction/shoppingcart.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            cart = (ArrayList<Product>) httpSession.getAttribute("cart");

            int i = 0;

            for (; i < cart.size(); i++) {
                if (cart.get(i).getPid().equals(pid)) {
                    cart.remove(i);
                    break;
                }
            }

            if (i == cart.size()) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('The product is not in your cart');\n");
                String url = "Transaction/shoppingcart.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            httpSession.setAttribute("cart", cart);

            out.write("<script type='text/javascript'>\n");

            if (cart.size() == 0) {
                out.write("alert('The product has been removed from cart. Your shopping cart is now empty!!!');\n");
            } else {
                out.write("alert('The product has been removed from cart');\n");
            }

            String url = "Transaction/shoppingcart.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");

//            response.sendRedirect("Transaction/shoppingcart.jsp");
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("test2/products.jsp");
//            requestDispatcher.forward(request, response);
        } else if (action.equals("checkout")) {
            httpSession = request.getSession();
            cart = (ArrayList<Product>) httpSession.getAttribute("cart");

            if (cart.size() == 0) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('There is no product in your cart to checkout');\n");
                String url = "Transaction/shoppingcart.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            ProductDAO pDao;
            UserDAO uDao;
            try {
                pDao = new ProductDAO();
                uDao = new UserDAO();
                int sum = 0;
                int nProduct = 0;
                String content
                        = "<html>"
                        + "<body>"
                        + "<h1>Hóa đơn mua hàng của quý khách</h1>"
                        + "<p><b>Tên khách hàng</b>: " + u.getLast_name() + " " + u.getFirst_name() + "<br/>"
                        + "<b>Ngày sinh của quý khách</b>: " + u.getDob() + "<br/>"
                        + "<b>Địa chỉ của quý khách</b>: " + u.getAddress() + "<br/>"
                        + "<b>Số điện thoại liên lạc của quý khách</b>: " + u.getPhone_number() + "<br/></p>"
                        + "<table border=\"1px solid black\">"
                        + "<tr>"
                        + "<th>Mã sản phẩm</th>"
                        + "<th>Tên sản phẩm</th>"
                        + "<th>Số lượng</th>"
                        + "<th>Đơn giá</th>"
                        + "<th>Giảm giá</th>"
                        + "<th>Tổng thành tiền</th>"
                        + "</tr>";
                for (int i = 0; i < cart.size(); i++) {
                    Product p = cart.get(i);
                    int currentQuantity = pDao.getQuantity(p.getPid());

                    content
                            += "<tr>"
                            + "<td align=\"center\">" + p.getPid() + "</td>"
                            + "<td align=\"center\">" + p.getPname() + "</td>"
                            + "<td align=\"center\">" + p.getQuantity() + "</td>"
                            + "<td align=\"center\">" + p.getPrice() + "</td>"
                            + "<td align=\"center\">" + p.getDiscount() + "%</td>"
                            + "<td align=\"center\">" + p.getQuantity() * (100.0 - p.getDiscount()) / 100.0 * p.getPrice() + "</td>"
                            + "</tr>";
                    sum += p.getQuantity() * (100.0 - p.getDiscount()) / 100.0 * p.getPrice();
                    nProduct++;
                    pDao.updateQuantity(p.getPid(), currentQuantity - p.getQuantity());
                }

                content
                        += "<tr>"
                        + "<td colspan=\"5\" align=\"right\">Phí vận chuyển</td>"
                        + "<td align=\"center\">" + nProduct + " x 200000 = " + nProduct * 200000 + "</td>"
                        + "</tr>"
                        + "<tr>"
                        + "<td colspan=\"5\" align=\"right\">Tổng cộng</td>"
                        + "<td align=\"center\">" + (sum + nProduct * 200000) + "</td>"
                        + "</tr>"
                        + "</table>"
                        + "<p>Xin chân thành cám ơn quý khách,</p>"
                        + "<p>----------------<br/><b>XƯỞNG MỘC NGUYỄN VĂN QUÝ<br/>"
                        + "Cơ sở 1: 449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>"
                        + "Cơ sở 2: 449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>"
                        + "Điện thoại: 08.5407.0556 - Đường dây nóng: 0938.200.871</b></p>"
                        + "</body>"
                        + "</html>";

                Mail mail = new Mail();
                List<String> rcvEmail = new ArrayList<String>();
                rcvEmail.add(u.getEmail());

                mail.setSender("nguyenvanquy.woodworkshop@gmail.com");
                mail.setPwd("nguyenvanquy");
                mail.setRecipient(rcvEmail);
                mail.setSubject("[Hóa đơn mua hàng]");
                mail.setContent(content);

                u = (User) httpSession.getAttribute("user");

//                out.println(sum + ", " + u.getUid());
                uDao.updatePoint(sum, u.getUid());

                pDao.updateOrders(u, cart);

                cart = new ArrayList<Product>();
                httpSession.setAttribute("cart", cart);
                httpSession.setAttribute("mail", mail);
                //response.sendRedirect("/WebProj/MailServlet?action=billing");
                RequestDispatcher requestDispatcher = request.getRequestDispatcher("/MailServlet?action=billing");
                requestDispatcher.forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
//            RequestDispatcher requestDispatcher = request.getRequestDispatcher("checkout.jsp");
//            requestDispatcher.forward(request, response);
        } else if (action.equals("addCompare")) {

            String pid = request.getParameter("pid");

            if (pid == null) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('The product does not exist!!! Please check again');\n");
                String url = "index.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            ArrayList<Product> comp = (ArrayList<Product>) httpSession.getAttribute("comp");

            if (comp.size() == 3) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('Please remove one product to continue comparing');\n");
                String url = "Product/compare.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            try {

                ProductDAO pDAO;

                pDAO = new ProductDAO();

                Product p = pDAO.getOneProduct(pid);

                if (p.getPid() == null) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('The product does not exist!!! Please check again');\n");
                    String url = "index.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }

                for (Product comp1 : comp) {
                    if (!comp1.getCid().equals(p.getCid())) {
                        out.write("<script type='text/javascript'>\n");
                        String category = comp1.getCid();
                        out.write("alert('Please add product in the " + category + " category');\n");
                        String url = "Product/view.jsp?pid=" + pid;
                        out.write("window.location.href='" + url + "';");
                        out.write("</script>\n");
                        return;
                    }

                    if (comp1.getPid().equals(pid)) {
                        out.write("<script type='text/javascript'>\n");
                        out.write("alert('The product has already been added to compare list');\n");
                        String url = "Product/view.jsp?pid=" + pid;
                        out.write("window.location.href='" + url + "';");
                        out.write("</script>\n");
                        return;
                    }
                }

                comp.add(p);

                httpSession.setAttribute("comp", comp);

                if (comp.size() == 1) {
                    out.write("<script type='text/javascript'>\n");
                    out.write("alert('Pleases add one more product to compare');\n");
                    String url = "index.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");
                    return;
                }

                response.sendRedirect("Product/compare.jsp");

            } catch (SQLException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(ShoppingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }

        } else if (action.equals("removeCompare")) {

            String pid = request.getParameter("pid");

            if (pid == null) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('The product does not exist');\n");
                String url = "index.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
                return;
            }

            ArrayList<Product> comp = (ArrayList<Product>) httpSession.getAttribute("comp");

            for (Product comp1 : comp) {
                if (comp1.getPid().equals(pid)) {
                    comp.remove(comp1);

                    httpSession.setAttribute("comp", comp);

                    out.write("<script type='text/javascript'>\n");

                    if (comp.size() == 1) {
                        out.write("alert('The product has been removed from compare list!!! Add one more product to compare');\n");
                    } else {
                        out.write("alert('The product has been removed from compare list!!!');\n");
                    }

                    String url = "Product/compare.jsp";
                    out.write("window.location.href='" + url + "';");
                    out.write("</script>\n");

                    return;
                }
            }

            out.write("<script type='text/javascript'>\n");
            out.write("alert('The product is not in the compare list');\n");
            String url = "Product/compare.jsp";
            out.write("window.location.href='" + url + "';");
            out.write("</script>\n");

//            response.sendRedirect("Product/compare.jsp");
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
