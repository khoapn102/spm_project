<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>     
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Tìm kiếm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
        <script src="../js/simpleCart.min.js"></script>
        <script src="../js/jquery.min.js"></script>
        <link href="../css/style.css" rel='stylesheet' type='text/css' />
        <script src="../js/jquery.easydropdown.js"></script>
        <script src="../js/jquery.magnific-popup.js" type="text/javascript"></script>
        <link href="../css/magnific-popup.css" rel="stylesheet" type="text/css">
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
    </head>
    <body>
        <%
            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
        %>
        <%@ page import="dao.ProductDAO" %>
        <%@ page import="java.util.List" %>
        <%@ page import="model.*" %>
        <%
            HttpSession s = request.getSession();
            User user_t = (User) s.getAttribute("user");
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
                <div class="banner_wrap">
                    <div class="bannertop_box">
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
                            <!--<li class="wish"><a href="#">D.S Mong muốn</a></li>-->
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
                        <div class="welcome_box">
                            <h3>Chào bạn đến với của hàng chúng tôi,</h3>
                            <p>Chúc bạn có những khoảng thời gian mua sắm vui vẻ và tìm được những sản phẩm mà bạn mong muốn</p>
                        </div>
                    </div>
                    <div class="banner_right">
                        <p style="font-size: 1.1em;"><i>Chúng tôi chuyên sản xuất các sản phẩm nội thất đồ gỗ cho gia đình, khách sạn, trường học và văn phòng...</i></p>
                        <p style="font-size: 1.4em;"><b>Hotline: 0938 200 871<b></p>
                                    <a href="#" class="banner_btn">Mua ngay</a>
                                    </div>
                                    <div class='clearfix'></div>
                                    </div>
                                    </div>
                                    </div>
                                    <div class="main">
                                        <div class="content_box">
                                            <div class="container">
                                                <div class="row">
                                                    <div class="col-md-3">
                                                        <div class="menu_box">
                                                            <h3 class="menu_head" style="font-size: 18px"><img src="../icons/menu.png"><b>&nbsp;&nbsp;DANH MỤC</b></h3>
                                                            <ul class="nav">
                                                                <li><a href="../StoreInfor/about.jsp"><img src="../icons/user.png"><b>&nbsp;&nbsp;GIỚI THIỆU VỀ CHÚNG TÔI</b></a></li>
                                                                        <%if (user_t != null && user_t.getIsManager() == 0) {%>
                                                                <li><a href="../Product/compare.jsp"><img src="../icons/compare.png"><b>&nbsp;&nbsp;BẤM ĐỂ SO SÁNH NGAY</b></a></li>
                                                                        <%}%>
                                                                <li><a href="../Product/viewCate.jsp?cid=liv"><img src="../icons/living.png"><b>&nbsp;&nbsp;PHÒNG KHÁCH</b></a></li>
                                                                <li><a href="../Product/viewCate.jsp?cid=bed"><img src="../icons/bed.png"><b>&nbsp;&nbsp;PHÒNG NGỦ</b></a></li>
                                                                <li><a href="../Product/viewCate.jsp?cid=kit"><img src="../icons/dining.png"><b>&nbsp;&nbsp;NHÀ BẾP</b></a></li>
                                                                <li><a href="../Product/viewCate.jsp?cid=off"><img src="../icons/work.png"><b>&nbsp;&nbsp;VĂN PHÒNG</b></a></li>
                                                                <li><a href="../Product/viewCate.jsp?cid=acc"><img src="../icons/shelf.png"><b>&nbsp;&nbsp;PHỤ KIỆN</b></a></li>
                                                                <li><a href="../StoreInfor/contact.jsp"><img src="../icons/contact.png"><b>&nbsp;&nbsp;LIÊN HỆ</b></a></li>
                                                            </ul>
                                                        </div>
                                                        <div class="tags">
                                                            <h4 class="tag_head">Thẻ Tìm Kiếm Nhanh</h4>
                                                            <ul class="tags_links">
                                                                <li><a href="../Product/search.jsp?searchkeyword=Tủ Bếp">Tủ Bếp</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Bàn Làm Việc">Bàn Làm Việc</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Giường Ngủ">Giường Ngủ</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Ghế Gỗ">Ghế Gỗ</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Tủ Tivi">Tủ Tivi</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Khung Gương">Khung Gương</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Sang Trọng">Sang Trọng</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Cao Cấp">Cao Cấp</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Hiện đại">Hiện Đại</a></li>
                                                                <li><a href="../Product/search.jsp?searchkeyword=Cổ điển">Cổ Điển</a></li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-9">
                                                        <h3 class="m_1">Kết quả tìm kiếm</h3>
                                                        <%
                                                            ProductDAO pd = new ProductDAO();

                                                            List<Product> productList = null;

                                                            String keyWord = request.getParameter("searchkeyword");

                                                            String price = request.getParameter("price");

                                                            if (keyWord != null && !keyWord.equals("Tìm kiếm") && price == null) {
                                                                productList = pd.getSearchProduct(keyWord);

                                                            } else if (keyWord == null && price != null) {

                                                                int low = 0;
                                                                int up = 0;

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

                                                                productList = pd.getSearchProductByPrice(low, up);

                                                            }

                                                            if (productList
                                                                    != null && productList.size()
                                                                    != 0) {
                                                                for (int i = 0; i < productList.size(); i++) {
                                                                    String url = "../Product/view.jsp?pid=" + productList.get(i).getPid();
                                                                    if (i % 3 == 0) {
                                                                        out.println("<div class=\"content_grid\">");
                                                                    }

                                                                    if (i % 3 != 2 && i != productList.size() - 1) {
                                                                        out.println(
                                                                                "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem\">\n"
                                                                                + "<a href=\"../Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                                + "<div class=\"inner_content clearfix\">\n"
                                                                                + "<div class=\"product_image\">\n"
                                                                                + "<img src=\"../" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
                                                                                + "<a href=\"" + url + "\" class=\"button item_add item_1\"> </a>\n"
                                                                                + "<div class=\"product_container\">\n"
                                                                                + "<div class=\"cart-left\">\n"
                                                                                + "<p class=\"title\">" + productList.get(i).getPname() + i + "</p>\n"
                                                                                + "</div>\n"
                                                                                + "<span class=\"amount item_price\">" + productList.get(i).getPrice() + " VND</span>\n"
                                                                                + "<div class=\"clearfix\"></div>\n"
                                                                                + "</div>\n"
                                                                                + "</div>\n"
                                                                                + "</div>\n"
                                                                                + "</a>\n"
                                                                                + "</div>\n");
                                                                    }

                                                                    if (i % 3 == 2 || i == productList.size() - 1) {
                                                                        out.println(
                                                                                "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem last_1\">\n"
                                                                                + "<a href=\"../Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                                + "<div class=\"inner_content clearfix\">\n"
                                                                                + "<div class=\"product_image\">\n"
                                                                                + "<img src=\"../" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
                                                                                + "<a href=\"" + url + "\" class=\"button item_add item_1\"> </a>\n"
                                                                                + "<div class=\"product_container\">\n"
                                                                                + "<div class=\"cart-left\">\n"
                                                                                + "<p class=\"title\">" + productList.get(i).getPname() + "</p>\n"
                                                                                + "</div>\n"
                                                                                + "<span class=\"amount item_price\">" + productList.get(i).getPrice() + " VND</span>\n"
                                                                                + "<div class=\"clearfix\"></div>\n"
                                                                                + "</div>\n"
                                                                                + "</div>\n"
                                                                                + "</div>\n"
                                                                                + "</a>\n"
                                                                                + "</div>\n"
                                                                                + "<div class=\"clearfix\"></div>\n"
                                                                                + "</div> ");
                                                                    }
                                                                }
                                                            } else if (productList
                                                                    == null || productList.size()
                                                                    == 0) {
                                                                out.println("<h2>Hệ thống không tìm thấy kết quả phù hợp !</h2>");
                                                            }

                                                            //out.println("<h1>"+productList.size()+"</h1>");

                                                        %>                        
                                                    </div>
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
                                    </body>
                                    </html>		