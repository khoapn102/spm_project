<%-- 
    Document   : wishlist
    Created on : Nov 20, 2015, 12:56:55 PM
    Author     : Triet Le
--%>

<%@page import="dao.WishListDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Giỏ Hàng - Thanh Toán</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
        <script src="../js/jquery.min.js"></script>
        <link href="../css/style.css" rel='stylesheet' type='text/css' />
        <script src="../js/jquery.easydropdown.js"></script>
        <script src="../js/jquery.magnific-popup.js" type="text/javascript"></script>
        <link href="../css/magnific-popup.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="../js/backtotop.js"></script>
        <script>
            $(document).ready(function () {
                $('.popup-with-zoom-anim').magnificPopup({
                    type: 'inline',
                    fixedContentPos: false,
                    fixedBgPos: true,
                    overflowY: 'auto',
                    closeBtnInside: true,
                    preloader: false,
                    midClick: true,
                    removalDelay: 300,
                    mainClass: 'my-mfp-zoom-in'
                });
            });
        </script>

        <style>

            span #wishlist:hover {
                background-color: #df4782;
            }

            a #wishlist:hover {
                background-color: #df4782;
            }
        </style>
    </head>
    <body>
        <%@ page import="dao.*" %>
        <%@ page import="java.util.List" %>
        <%@ page import="java.util.ArrayList" %>
        <%@ page import="model.*" %>
        <%
            HttpSession s = request.getSession();
            User user_t = (User) s.getAttribute("user");
            if (user_t == null) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('You must login first!!!');\n");
                String url = "../User/login.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
//                response.sendRedirect("../User/login.jsp");
                return;
            } else if (user_t.getIsManager() == 1) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('You must login as a customer to checkout!!!');\n");
                String url = "../User/login.jsp";
                out.write("window.location.href='" + url + "';");
                out.write("</script>\n");
//                response.sendRedirect("../User/login.jsp");
                return;
            }
        %>
        <div class="header">    
            <div class="container"> 
                <div class="header-top">
                    <div class="logo">
                        <a href="../index.jsp"><h6>Xưởng Mộc</h6><h2>Nguyễn Văn Quý</h2></a>
                    </div>
                    <!--                    <div class="header_right">
                                            <ul class="social">
                                                <li><a href=""> <i class="fb"> </i> </a></li>
                                                <li><a href=""><i class="tw"> </i> </a></li>
                                                <li><a href=""><i class="utube"> </i> </a></li>
                                                <li><a href=""><i class="pin"> </i> </a></li>
                                                <li><a href=""><i class="instagram"> </i> </a></li>
                                            </ul>
                                            <div class="lang_list">
                                                <select tabindex="4" class="dropdown">
                                                    <option value="" class="label" value="">VI</option>
                                                    <option value="1">VI</option>
                                                    <option value="2">EN</option>
                                                </select>
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>-->
                    <div class="clearfix"></div>
                </div>  
                <div class="about_box">
                    <ul class="login">
                        <%
                            if (user_t == null) {
                                out.println("<li class=\"login_text\"><a href=\"../User/login.jsp\">Đăng Nhập</a></li>");
                                out.println("<li class=\"wish\"><a href=\"../Product/wishlist.jsp\">D.S Mong Muốn</a></li>");
                            } else {
                                out.println("<li class=\"login_text\"><a href=\"../User/profile.jsp\">Xem profile</a></li>");
                                if (user_t.getIsManager() == 1) {
                                    out.println("<li class=\"wish\"><a href=\"../Product/storemanage.jsp\">Quản Lý Xưởng</a></li>");
                                } else {
                                    out.println("<li class=\"wish\"><a href=\"../Product/wishlist.jsp\">D.S Mong Muốn</a></li>");
                                }
                                out.println("<li class=\"logout\"><a href=\"../controller.UserServlet?action=logout\">Đăng Xuất</a></li>");
                            }
                        %>

                        <div class='clearfix'></div>
                    </ul>
                    <div class="cart_bg">
                        <ul class="cart">
                            <a href="../Transaction/shoppingcart.jsp">
                                <h4><i class="cart_icon"> </i><p>Giỏ hàng:  ${fn:length(cart)} sản phẩm</p><div class="clearfix"> </div></h4>
                            </a>
                        </ul>
                    </div>
                    <ul class="quick_access">
                        <li class="view_cart"><a href="../Transaction/shoppingcart.jsp">Xem giỏ hàng</a></li>
                        <li class="check"><a href="../Transaction/checkout.jsp">Thanh toán</a></li>
                        <div class='clearfix'></div>
                    </ul>
                    <div class="search">
                        <form method="post" action="../Product/search.jsp">
                            <input type="text" value="Tìm kiếm" name="searchkeyword" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Tìm kiếm';
                                    }">
                            <input type="submit" value="">
                            <br><br>

                            <!--                            <form method="post" action="Product/search.jsp">-->
                        </form>
                    </div>
                    <div class="login-right">
                        <form method="post" action="../Product/search.jsp">
                            <label style="background-color: white; padding-right: 35px">
                                Chọn sản phẩm theo mức giá
                            </label>
                            <select name="price">
                                <option>1.000.000 - 3.000.000</option>
                                <option>3.000.000 - 5.000.000</option>
                                <option>5.000.000 - 8.000.000</option>
                                <option>Hơn 8.000.000</option>
                            </select>
                            <input type="submit" value="Tìm">
                            <br><br>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="main">
            <div class="container">
                <div class="check_box">	 
                    <div class="col-md-9 cart-items">
                        <h1>Danh Sách Mong Muốn Của Bạn</h1>

                        <%
                            WishListDAO wDao = new WishListDAO();

                            List<String> pidList = (ArrayList<String>) wDao.getWishListByMid(user_t.getUid());

                            ProductDAO pDao = new ProductDAO();

                            for (int i = 0; i < pidList.size(); i++) {
                                Product p = (Product) pDao.getOneProduct(pidList.get(i));

                                out.println("<div class=\"cart-header\">");
                                out.println("<a href=\"#\" id=\"delBtn" + String.valueOf(i) + "\"><div class=\"close1\"></div></a>");

                                out.println("<div class=\"cart-sec simpleCart_shelfItem\">");
                                out.println("<div class=\"cart-item cyc\">");

                                out.println("<img src=\"../" + p.getP_img() + "1.jpg\" class=\"img-responsive\" alt=\"\">");

                                out.println("<span id=\"wishlist\" style=\"background-color: #22A7F0;\"><a id=\"wishlist\"style='color:white; text-decoration: none; font-size: 17px' href=\"../Product/view.jsp?pid=" + p.getPid() + "\">Thêm vào Giỏ Hàng</a></span></div>");

                                out.println("<div class=\"cart-item-info\">");
                                out.println("<h3><a href=\"#\"></a>" + p.getPname() + "<span>Mã Món Hàng: " + p.getPid() + "</span>");
                                out.println("<span>Thông Tin Sản Phẩm: </span><span>" + p.getDesc() + "</span></h3></div>");

                                out.println("<div class=\"clearfix\"></div></div></div>");

                        %>

                        <script>

                            document.getElementById("delBtn<%=i%>").addEventListener('click', function () {
                                var acc = confirm("Xin Vui Lòng Xác Nhận Xóa Khỏi Danh Sách Mong Muốn");

                                if (acc == true) {
                                    window.location.href = '../controller.WishListServlet?action=delete&pid=<%=p.getPid()%>';
                                }

                            });
                        </script>

                        <%
                            }

                            out.println("</div>");

                        %>
                        <div class="col-md-3 cart-total">
                            <a class="continue" href="../index.jsp">Tiếp Tục Mua Sắm</a>

                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="instagram_top">
                    <div class="instagram text-center">
                        <h3>Kết Nối Với Chúng Tôi</h3>
                    </div>
                    <ul class="footer_social">
                        <li><a href="#"><i class="tw"> </i> </a></li>
                        <li><a href="#"> <i class="fb"> </i> </a></li>          
                        <li><a href="#"><i class="pin"> </i> </a></li>
                        <div class="clearfix"></div>
                    </ul>
                </div>
            </div>
        </div>
        <div class="footer">
            <div class="container">
                <div class="footer-grid">
                    <h3>Thông Tin Liên Hệ</h3>
                    <p class="footer_desc">
                        <b><u>Cơ Sở 1</u><br/></b>
                        Địa chỉ: 449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>
                        ĐT: 0938 200 871
                    </p>
                    <p class="footer_desc">
                        <b><u>Cơ Sở 2</u><br/></b>
                        Địa chỉ: 449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>                    
                        ĐT: (08) 5407 0556
                    </p>
                </div>
                <div class="footer-grid">
                    <h3>Danh Mục</h3>
                    <ul class="list1">
                        <li><a href="../index.jsp">Trang chủ</a></li>
                        <li><a href="../StoreInfor/about.jsp">Giới Thiệu Về Chúng Tôi</a></li>
                        <li><a href="../Product/viewCate.jsp?cid=liv">Nội Thất Phòng Khách</a></li>
                        <li><a href="../Product/viewCate.jsp?cid=bed">Nội Thất Phòng Ngủ</a></li>
                        <li><a href="../Product/viewCate.jsp?cid=kit">Nội Thất Nhà Bếp</a></li>
                        <li><a href="../Product/viewCate.jsp?cid=off">Nội Thất Văn Phòng</a></li>
                        <li><a href="../Product/viewCate.jsp?cid=acc">Phụ Kiện Trang Trí</a></li>
                        <li><a href="../StoreInfor/contact.jsp">Liên Hệ Với Chúng Tôi</a></li>
                    </ul>
                </div>

                <div class="footer-grid">
                    <h3>Đăng Ký Nhận Tin</h3>
                    <p class="footer_desc">Chúng tôi sẽ cập nhật thông tin sản phẩm mới nhất và các chương trình khuyến mãi nhanh chóng và kịp thời đến bạn</p>
                    <div class="search_footer">
                        <form method="post" action="../../WebProj/SubscriberServlet?action=add">
                            <input type="text" class="text" value="Email" name="email" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Email';
                                    }">
                            <input type="submit" value="Đăng Ký">
                        </form>
                    </div>
                    <img src="../images/payment.png" class="img-responsive" alt=""/>
                </div>
                <div class="clearfix"> </div>
            </div>
        </div>
        <div class="footer_bottom">
            <div class="container">
                <div class="copy">
                    <p>Chủ cơ sở : NGUYỄN VĂN QUÝ<br/>Copyright &copy; 2015 Xưởng Mộc Cao Cấp Nguyễn Văn Quý. Phát triển bởi <a href="#" target="_blank">HKT Software Solution</a> </p>
                </div>
            </div>
        </div>
                                <p><a href="#" class="back-to-top">Back to Top</a></p>
    </body>
</html>		
