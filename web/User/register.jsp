<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>Đăng Ký tài Khoản</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <meta name="keywords" content="Luxury Furnish Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
              Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
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
        <%@ page import="java.util.*" %>
        <%@ page import="model.*" %>
        <%
            HttpSession s = request.getSession();
            User user_t = (User) s.getAttribute("user");
            if (user_t != null) {
                response.sendRedirect("../index.jsp");
                return;
            }
        %>
        <div class="header">
            <div class="container"> 
                <div class="header-top">
                    <div class="logo">
                        <a href="../index.jsp"><h6>Xưởng Mộc</h6><h2>Nguyễn Văn Quý</h2></a>
                    </div>
                    <div class="header_right">
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
                    </div>
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
                                <h4><i class="cart_icon"> </i><p>Giỏ hàng: 
                                        <% if (user_t == null) {
                                                out.println("0 sản phẩm");
                                            } else {
                                                List<Product> cart = (ArrayList<Product>) s.getAttribute("cart");
                                                out.println(cart.size() + " sản phẩm");
                                            }
                                        %>
                                    </p><div class="clearfix"> </div></h4>
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%@ page import="net.tanesha.recaptcha.ReCaptcha"%>
        <%@ page import="net.tanesha.recaptcha.ReCaptchaFactory"%>        
        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
        
        <div class="main">
            <div class="container">
                <div class="register">

                    <form action="../controller.UserServlet?action=register" method="post">
                        <div>
                            <% if (request.getParameter("result") != null && request.getParameter("result").equals("error")) {%>
                            <br><h4 id="Error" style="font-size: 18px; color: #e24602"><i>Email đã tồn tại! Vui lòng nhập lại!</i></h4>
                            <%}%>
                        </div><br>
                        <div class="register-top-grid">
                            <h3>Thông tin đăng nhập</h3>
                            <h6><i>Vui lòng điền đầy đủ thông tin vào ô có dấu (*)</i></h6>
                            <div>
                                <span>Địa chỉ Email<label>*</label></span>
                                <input type="text" name="email" id="email" maxlength="35" required>
                            </div>
                            <div>
                                <span>Nhập lại địa chỉ email<label>*</label></span>
                                <input type="text" id="confirmemail" maxlength="35" required>
                            </div>
                            <div>
                                <span>Mật khẩu<label>*</label></span>
                                <input type="password" id="pass" name="password" maxlength="15" required>
                            </div>
                            <div>
                                <span>Nhập lại mật khẩu<label>*</label></span>
                                <input type="password" id="confirmpass" maxlength="15" required>
                            </div>

                        </div>
                        <div class="register-bottom-grid">
                            <h3>Thông tin cá nhân</h3>
                            <div>
                                <span>Họ<label>*</label></span>
                                <input type="text" id="first" name="lastname" maxlength="25" required> 
                            </div>
                            <div>
                                <span>Tên<label>*</label></span>
                                <input type="text" id="last" name="firstname" maxlength="25" required> 
                            </div>
                            <div>
                                <span>Ngày - Tháng - Năm Sinh<label>*</label></span>
                                <select name="date">
                                    <option> - Ngày - </option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                    <option value="13">13</option>
                                    <option value="14">14</option>
                                    <option value="15">15</option>
                                    <option value="16">16</option>
                                    <option value="17">17</option>
                                    <option value="18">18</option>
                                    <option value="19">19</option>
                                    <option value="20">20</option>
                                    <option value="21">21</option>
                                    <option value="22">22</option>
                                    <option value="23">23</option>
                                    <option value="24">24</option>
                                    <option value="25">25</option>
                                    <option value="26">26</option>
                                    <option value="27">27</option>
                                    <option value="28">28</option>
                                    <option value="29">29</option>
                                    <option value="30">30</option>
                                    <option value="31">31</option>
                                </select>
                                &nbsp;
                                <select name="month">
                                    <option> - Tháng - </option>
                                    <option value="1">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                    <option value="9">9</option>
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                                &nbsp;
                                <select name="year">
                                    <option> - Năm - </option>
                                    <option value="1995">1995</option>
                                    <option value="1994">1994</option>
                                    <option value="1993">1993</option>
                                    <option value="1992">1992</option>
                                    <option value="1991">1991</option>
                                    <option value="1990">1990</option>
                                    <option value="1989">1989</option>
                                    <option value="1988">1988</option>
                                    <option value="1987">1987</option>
                                    <option value="1986">1986</option>
                                    <option value="1985">1985</option>
                                    <option value="1984">1984</option>
                                    <option value="1983">1983</option>
                                    <option value="1982">1982</option>
                                    <option value="1981">1981</option>
                                    <option value="1980">1980</option>
                                    <option value="1979">1979</option>
                                    <option value="1978">1978</option>
                                    <option value="1977">1977</option>
                                    <option value="1976">1976</option>
                                    <option value="1975">1975</option>
                                    <option value="1974">1974</option>
                                    <option value="1973">1973</option>
                                    <option value="1972">1972</option>
                                    <option value="1971">1971</option>
                                    <option value="1970">1970</option>
                                    <option value="1969">1969</option>
                                    <option value="1968">1968</option>
                                    <option value="1967">1967</option>
                                    <option value="1966">1966</option>
                                    <option value="1965">1965</option>
                                    <option value="1964">1964</option>
                                    <option value="1963">1963</option>
                                    <option value="1962">1962</option>
                                    <option value="1961">1961</option>
                                    <option value="1960">1960</option>
                                    <option value="1959">1959</option>
                                    <option value="1958">1958</option>
                                    <option value="1957">1957</option>
                                    <option value="1956">1956</option>
                                    <option value="1955">1955</option>
                                    <option value="1954">1954</option>
                                    <option value="1953">1953</option>
                                    <option value="1952">1952</option>
                                    <option value="1951">1951</option>
                                    <option value="1950">1950</option>
                                </select>

                            </div>
                            <div>
                                <span>Số điện thoại<label>*</label></span>
                                <input type="text" id="tel" name="tel" maxlength="12" required> 
                            </div>

                            <div>
                                <span>Địa chỉ nhà<label></label></span>
                                <input name="address" id="addr" maxlength="50" type="text"> 
                            </div>
                            <div>
                                <span>Hình ảnh đại diện</span>
                                <!--<input type="file" name="u_img">-->
                                <script type="text/javascript">
                                    function jsDropDown(imgid, newimg) {
                                        document.getElementById("userPic").src = "../" + newimg;
                                    }
                                </script>
                                <table>
                                    <tr>
                                        <td>
                                            <select name="u_img" onchange="jsDropDown('userPic', this.value)">
                                                <option value="image/user/itc1.jpg">ITC</option>
                                                <option value="image/user/coffee.jpg">Coffee</option>
                                                <option value="image/user/danger.jpg">Danger</option>
                                                <option value="image/user/egg.jpg">Egg</option>
                                                <option value="image/user/mundo.jpg">Mundo</option>
                                                <option value="image/user/cool.jpg">Cool Guy</option>
                                            </select>
                                        </td>
                                        <td>
                                            &nbsp;&nbsp;&nbsp;<img src="../image/user/itc1.jpg" alt="No Image" id="userPic"/>
                                        </td>
                                    </tr>
                                </table>


                            </div>
                            <div class="clearfix"> </div>
                            <a class="news-letter" href="#">
                                <label class="checkbox"><input type="checkbox" name="checkbox" checked=""><i> </i>Đăng ký để nhận thông tin từ chúng tôi</label>
                            </a><br>
                            <div class='clearfix'></div>
<!--                        <div class="register-but">
                                <input type="submit" value="Đăng ký" style="background-color: #31C2DB; padding: 12px 25px; font-size: 22px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                            </div>-->
                            
                            <div class="g-recaptcha" data-sitekey="6LewuwwUAAAAAKvnR3GcLNj7D9dCOrSKsu9NByaO"></div>
                                <br/>
                                <input type="submit" value="Đăng ký" style="background-color: #31C2DB; padding: 12px 25px; font-size: 22px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                            <div class="clearfix"> </div>
                        </div>
                    </form>
                    <div class="clearfix"> </div>
                    <script type="text/javascript">
                        var pass = document.getElementById("pass");
                        var confirm = document.getElementById("confirmpass");
                        //var currpass = document.getElementById("currpass");
                        function validatePass() {
                            if (pass.value != confirm.value) {
                                confirm.setCustomValidity('Mật khẩu không trùng khớp');
                            } else {
                                confirm.setCustomValidity('');
                            }
                        }
                        pass.onchange = validatePass;
                        confirm.onkeyup = validatePass;
                        var email = document.getElementById("email");
                        var confirmemail = document.getElementById("confirmemail");
                        function validateEmail() {
                            if (email.value != confirmemail.value) {
                                confirmemail.setCustomValidity('Email không trùng khớp');
                            } else {
                                confirmemail.setCustomValidity('');
                            }
                        }
                        email.onchange = validateEmail;
                        confirmemail.onkeyup = validateEmail;

                        var first = document.getElementById("first");
                        var last = document.getElementById("last");
                        var tel = document.getElementById("tel");
                        var addr = document.getElementById("addr");
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

                        first.onchange = isValidFirst;
                        last.onchange = isValidLast;
                        tel.onchange = isValidTel;
                        email.onkeyup = isValidEmail;
                        addr.onchange = isValidAddr;
                    </script>
                </div>
            </div>
        </div>
        
        <form action="?" method="POST">
            
         </form>
        
        
        
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