<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.User"%>
<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Thông Tin Tài Khoản</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
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

        <%@ page import="dao.ProductDAO" %>
        <%@ page import="java.util.List" %>
        <%@ page import="model.*" %>
        <%
            HttpSession s = request.getSession();
            User user_t = (User) s.getAttribute("user");
            if (user_t == null) {
                response.sendRedirect("../User/login.jsp");
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
                        <!--<li class="wish"><a href="#">D.S Mong muốn</a></li>-->
                        <div class='clearfix'></div>
                    </ul>
                    <div class="cart_bg">
                        <ul class="cart">
                            <a href="../Transaction/shoppingcart.jsp">
                                <h4><i class="cart_icon"> </i><p>Giỏ hàng: ${fn:length(cart)} sản phẩm</p><div class="clearfix"> </div></h4>
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
                    <div>
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
                            <div class="account_grid">
                                <div class="col-md-6">
                                    <h2>Xin chào <span style="color: #31b0d5;">${user.last_name} ${user.first_name}</span></h2>
                                    <%--<% User temp = (User) session.getAttribute("user");
                                    if (temp.getIsManager() == 1) {%>
                                <h3 id="manager" style="padding-top: 5px">Chủ cửa hàng</h3>
                                <%}%>
                                <c:out value="${sessionScope.user.isManager }"/>--%>
                                    <c:if test="${user.isManager == 1}">
                                        <h3 id="manager" style="padding-top: 5px">Chủ cửa hàng</h3>
                                    </c:if>   
                                    <hr>
                                    <h5 style="color: #737373">Ảnh đại diện</h5><br>
                                    <img src="../${user.image_url}" alt="No Image!"><br><br>
                                    <a class="acount-btn" id="passchange" href="#">Thay Đổi Mật Khẩu</a>
                                    <form id="formPass" action="../controller.UserServlet?action=changepass" method="post" style="display: none;">
                                        <br><div class="col-md-6 login-right">
                                            <!--<div>
                                                <span>Mật khẩu hiện tai: <label>*</label></span>
                                                <input type="password" id="currpass" required>
                                            </div>-->
                                            <div>
                                                <span>Mât khẩu mới: <label>*</label></span>
                                                <input type="password" maxlenght="15" id="newpass" name="newpass" required>
                                            </div>
                                            <div>
                                                <span>Xác nhận mật khẩu: <label>*</label></span>
                                                <input type="password" maxlenght="15" id="confirmpass" required> 
                                            </div><br>
                                            <input type="submit" value="Thay đổi mật khẩu">
                                        </div>
                                    </form>
                                </div>
                                <div class="col-md-6">
                                    <h3 style="padding:6.5px 0 0 2px"><span style="color: #ffd001">Thông tin cá nhân</span></h3><hr>
                                    <b>Họ và Tên: ${sessionScope.user.last_name} ${sessionScope.user.first_name}<br><br>
                                        Ngày sinh: ${sessionScope.user.dob}<br><br>
                                        Số điện thoại: ${sessionScope.user.phone_number}<br><br>
                                        Địa chỉ nhà: ${sessionScope.user.address}<br><br>
                                        Địa chỉ Email: ${sessionScope.user.email}<br><br></b>
                                    <!--<button class="acount-btn" href="UserServlet?action=changepass">Change Password</button>-->
                                    <br>
                                    <a class="acount-btn" id="infochange" href="#">Thay Đổi Thông Tin</a>
                                    <form id="formInfo" action="../controller.UserServlet?action=changeinfo" method="post" style="display: none;">
                                        <br><div class="col-md-9 login-right">
                                            <div>
                                                <span>Họ<label>*</label></span>
                                                <input type="text" maxlength="25" id="first" name="lastname" value="${sessionScope.user.last_name}" contenteditable="true" required> 
                                            </div>
                                            <div>
                                                <span>Tên<label>*</label></span>
                                                <input type="text" maxlength="25" id="last" name="firstname" value="${sessionScope.user.first_name}" contenteditable="true" required> 
                                            </div>
                                            <div>
                                                <span>Ngày Sinh<label>*</label></span>
                                                <input type="text" id="dob" placeholder="Có dạng dd-mm-yyyy" name="dob" value="${sessionScope.user.dob}" contenteditable="true"> 
                                            </div>
                                            <div>
                                                <span>Số điện thoại<label>*</label></span>
                                                <input type="text" maxlength="12" id="tel"  name="tel" value="${sessionScope.user.phone_number}" contenteditable="true" required> 
                                            </div>
                                            <div>
                                                <span>Địa chỉ Email:<label></label></span>
                                                <input name="email" maxlength="30" id="email" type="text" value="${sessionScope.user.email}" contenteditable="true"> 
                                            </div>
                                            <div>
                                                <span>Địa chỉ nhà<label></label></span>
                                                <input name="address" maxlength="45" id="addr" type="text" value="${sessionScope.user.address}" contenteditable="true"> 
                                            </div><br>
                                            <input type="submit" value="Thay đổi thông tin">
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <script type="text/javascript">
                                $('#passchange').click(function (e) {
                                    if ($('#formPass').is(":visible")) {
                                        $('#formPass').hide("slow");
                                    } else {
                                        $('#formPass').show("slow");
                                    }
                                    e.preventDefault();
                                });
                                $('#infochange').click(function (e) {
                                    if ($('#formInfo').is(":visible")) {
                                        $('#formInfo').hide("slow");
                                    } else {
                                        $('#formInfo').show("slow");
                                    }
                                    e.preventDefault(); //avoiding jerking back up top page
                                })
                                var pass = document.getElementById("newpass");
                                var confirm = document.getElementById("confirmpass");
                                //var currpass = document.getElementById("currpass");
                                function checkpass() {
                                    if (currpass.value != ${sessionScope.user.password}) {
                                        currpass.setCustomValidity('Mật khẩu không đúng');
                                    } else {
                                        currpass.setCustomValidity('');
                                    }
                                }
                                function validate() {
                                    if (pass.value != confirm.value) {
                                        confirm.setCustomValidity('Mật khẩu không trùng khớp');
                                    } else {
                                        confirm.setCustomValidity('');
                                    }
                                }
                                pass.onchange = validate;
                                confirm.onkeyup = validate;

                                var first = document.getElementById("first");
                                var last = document.getElementById("last");
                                var email = document.getElementById("email");
                                var tel = document.getElementById("tel");
                                var addr = document.getElementById("addr");
                                var dob = document.getElementById("dob");

                                var pattern = new RegExp(/[~`!#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                var isnum = new RegExp(/^\d+$/);
                                function isValidFirst() {
                                    if (pattern.test(first.value)) {
                                        first.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        first.setCustomValidity('');
                                    }
                                }
                                function isValidLast() {
                                    if (pattern.test(last.value)) {
                                        last.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        last.setCustomValidity('');
                                    }
                                }
                                function isValidEmail() {
                                    if (pattern.test(email.value)) {
                                        email.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        email.setCustomValidity('');
                                    }
                                }
                                function isValidAddr() {
                                    if (pattern.test(addr.value)) {
                                        addr.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        addr.setCustomValidity('');
                                    }
                                }
                                function isValidTel() {
                                    if (!isnum.test(tel.value)) {
                                        tel.setCustomValidity('Vui lòng chỉ nhập chữ số!');
                                    } else {
                                        tel.setCustomValidity('');
                                    }
                                }
                                function isValidDob() {
                                    var d = dob.value;
                                    var date = d.substring(0, 2);
                                    var month = d.substring(3, 5);
                                    var year = d.substring(6, 9);
                                    if ((!isnum.test(date)) || (!isnum.test(month)) || (!isnum.test(year)) || (d.charAt(2) !== '-') || (d.charAt(5) !== '-')) {
                                        dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                    } else {
                                        dob.setCustomValidity('');
                                    }
                                    /*if (!isnum.test(date)) {
                                     dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                     } else if (!isnum.test(month)) {
                                     dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                     } else if (!isnum.test(year)) {
                                     dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                     } else if (d.charAt(2) !== '-') {
                                     dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                     } else if (d.charAt(5) !== '-') {
                                     dob.setCustomValidity('Ngày Tháng Năm Sinh không hợp lệ!');
                                     } else {
                                     dob.setCustomValidity('');
                                     }*/
                                }
                                first.onchange = isValidFirst;
                                last.onchange = isValidLast;
                                tel.onchange = isValidTel;
                                email.onchange = isValidEmail;
                                addr.onchange = isValidAddr;
                                dob.onchange = isValidDob;

                            </script>
                        </div>
                    </div>
                </div>

            </div>
            <div class="container">
                <!-- <div class="instagram_top">
                    <div class="instagram text-center">
                        <h3>Bộ Sưu Tập</h3>
                    </div>
                    <ul class="instagram_grid">
                      <li><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i1.jpg" class="img-responsive"alt=""/></a></li>
                      <li><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i2.jpg" class="img-responsive" alt=""/></a></li>
                      <li><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i3.jpg" class="img-responsive" alt=""/></a></li>
                      <li><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i4.jpg" class="img-responsive" alt=""/></a></li>
                      <li><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i5.jpg" class="img-responsive" alt=""/></a></li>
                      <li class="last_instagram"><a class="popup-with-zoom-anim" href="#small-dialog1"><img src="images/i6.jpg" class="img-responsive" alt=""/></a></li>
                      <div class="clearfix"></div>
                      <div id="small-dialog1" class="mfp-hide">
                        <div class="pop_up">
                            <h4>A Sample Photo Stream</h4>
                            <img src="images/i_zoom.jpg" class="img-responsive" alt=""/>
                        </div>
                      </div>
                    </ul>
                </div> -->
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
                    <p>
                        Chủ cơ sở : NGUYỄN VĂN QUÝ<br/>
                        Copyright &copy; 2015 Xưởng Mộc Cao Cấp Nguyễn Văn Quý. Phát triển bởi <a href="#" target="_blank">HKT Software Solution</a>
                    </p>
                </div>
            </div>
        </div>
        <p><a href="#" class="back-to-top">Back to Top</a></p>
    </body>
</html>
