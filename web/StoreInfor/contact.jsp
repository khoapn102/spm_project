<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <title>Liên Hệ</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Xưởng Mộc Cao Cấp Nguyễn Văn Quý - Bình Tân - TP.HCM</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
        <script src="../js/simpleCart.min.js"></script>
        <script src="../js/jquery.min.js"></script>
        <link href="../css/style.css" rel='stylesheet' type='text/css' />
        <script src="../js/jquery.easydropdown.js"></script>
        <script src="../js/jquery.magnific-popup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../js/backtotop.js"></script>
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
            if (user_t != null && user_t.getIsManager() == 1) {
                out.write("<script type='text/javascript'>\n");
                out.write("alert('You must login as customer!!!');\n");
                String url = "../index.jsp";
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
                                                <li><a href="#"> <i class="fb"> </i> </a></li>
                                                <li><a href="#"><i class="tw"> </i> </a></li>
                                                <li><a href="#"><i class="utube"> </i> </a></li>
                                                <li><a href="#"><i class="pin"> </i> </a></li>
                                                <li><a href="#"><i class="instagram"> </i> </a></li>
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
                                <a href="../Transaction/checkout.jsp">
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
                        </div>
                        <div class="col-md-9">
                            <div class="dreamcrub">
                                <ul class="breadcrumbs">
                                    <li class="home">
                                        <a href="../index.jsp" title="Trở về trang chủ">Trang chủ</a>&nbsp;
                                        <span>&gt;</span>
                                    </li>
                                    <li class="women">Liên Hệ Cửa Hàng</li>
                                </ul>
                                <ul class="previous">
                                    <li><a href="../index.jsp">Trở về trang chủ</a></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>
                            <div class="singel_right">
                                <div class="lcontact span_1_of_contact">
                                    <div class="contact-form">
                                        <form action="/WebProj/MailServlet?action=contact" method="post">
                                            <p class="comment-form-author"><label for="author">Họ Tên Khách Hàng:</label>
                                                <%
                                                    if (user_t == null) {
                                                        out.println("<input type=\"text\" maxlength=\"355\" id=\"nameKH\" name=\"author\" class=\"textbox\" value=\"\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {this.value = '';}\" required>");
                                                    } else {
                                                        out.println("<input type=\"text\" maxlength=\"355\" id=\"nameKH\" name=\"author\" class=\"textbox\" value=\"" + user_t.getLast_name() + " " + user_t.getFirst_name() + "\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {this.value = '" + user_t.getLast_name() + " " + user_t.getFirst_name() + "';}\" required>");
                                                    }
                                                %>
                                            </p>
                                            <script>
                                                var nameKHBox = document.getElementById("nameKH");
                                                var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                                function isValidnameKHBox() {
                                                    if (pattern.test(nameKHBox.value)) {
                                                        nameKHBox.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                                    } else {
                                                        nameKHBox.setCustomValidity('');
                                                    }
                                                }
                                                nameKHBox.onchange = isValidnameKHBox;
                                            </script>


                                            <p class="comment-form-author"><label for="author">Địa chỉ Email của Khách Hàng:</label>
                                                <%
                                                    if (user_t == null) {
                                                        out.println("<input type=\"text\" maxlength=\"355\" id=\"emailKH\" name=\"email\" class=\"textbox\" value=\"\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {this.value = '';}\" required>");
                                                    } else {
                                                        out.println("<input type=\"text\" maxlength=\"355\" id=\"emailKH\" name=\"email\" class=\"textbox\" value=\"" + user_t.getEmail() + "\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {this.value = '" + user_t.getEmail() + "';}\" required>");
                                                    }
                                                %>
                                            </p>
                                            <script>
                                                var emailKHBox = document.getElementById("emailKH");
                                                var pattern = new RegExp(/[~`!#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                                function isValidemailKHBox() {
                                                    if (pattern.test(emailKHBox.value)) {
                                                        emailKHBox.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                                    } else {
                                                        emailKHBox.setCustomValidity('');
                                                    }
                                                }
                                                emailKHBox.onchange = isValidemailKHBox;
                                            </script>

                                            <p class="comment-form-author"><label for="author">Nội dung:</label>
                                                <textarea value="" id="messKH" maxlength="355" name="message" onfocus="this.value = '';" onblur="if (this.value == '') {
                                                            this.value = '';
                                                        }" required>Điền nội dung tin nhắn vào ô này...</textarea>
                                            </p>
                                            <script>
                                                var messKHBox = document.getElementById("messKH");
                                                var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                                function isValidmessKHBox() {
                                                    if (pattern.test(messKHBox.value)) {
                                                        messKHBox.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                                    } else {
                                                        messKHBox.setCustomValidity('');
                                                    }
                                                }
                                                messKHBox.onchange = isValidmessKHBox;
                                            </script>
                                            <input name="submit" type="submit" id="submit" value="Gửi" onclick="displayConfirm()">
                                        </form>
                                        <!--                                        <script type="text/javascript">
                                        
                                                                                    function displayConfirm() {
                                                                                        alert('Chúng tôi sẽ hồi âm trong thời gian sớm nhất!');
                                                                                    }
                                        
                                                                                </script>-->
                                    </div>
                                </div>

                                <div class="contact_grid span_2_of_contact_right">
                                    <h3>Địa chỉ Cửa Hàng 1</h3>
                                    <div class="address">
                                        <i class="pin_icon"></i>
                                        <div class="contact_address">
                                            449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM 
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="address">
                                        <i class="phone"></i>
                                        <div class="contact_address">
                                            0938 200 871
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="contact_grid span_2_of_contact_right">
                                    <h3>Địa chỉ Cửa Hàng 2</h3>
                                    <div class="address">
                                        <i class="pin_icon"></i>
                                        <div class="contact_address">
                                            449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM 
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                    <div class="address">
                                        <i class="phone"></i>
                                        <div class="contact_address">
                                            (08) 5407 0556
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </div>
                                <div class="clearfix"></div>
                            </div>

                            <div class="map">  
                                <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d1959.7711152006361!2d106.61224799798701!3d10.769719706268045!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752c3c2deebb0b%3A0xc158fd7574371e15!2zNDQ5IEhMMiwgQsOsbmggVHLhu4sgxJDDtG5nLCBCw6xuaCBUw6JuLCBI4buTIENow60gTWluaCwgVmnhu4d0IE5hbQ!5e0!3m2!1svi!2s!4v1447528237915" width="600" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
                            </div>
                        </div>
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
                        <li><a href="contact.jsp">Liên Hệ Với Chúng Tôi</a></li>
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