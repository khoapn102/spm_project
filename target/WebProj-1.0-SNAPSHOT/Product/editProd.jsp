<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.User"%>
<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Cập nhật sản phẩm</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
        <link href="../css/bootstrap.css" rel='stylesheet' type='text/css' />
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

        <%@ page import="dao.ProductDAO" %>
        <%@ page import="java.util.List" %>
        <%@ page import="model.*" %>
        <%
            HttpSession s = request.getSession();
            User user_t = (User) s.getAttribute("user");
            if (user_t == null) {
                response.sendRedirect("../User/login.jsp");
                return;
            } else if (user_t.getIsManager() == 0) {
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
                        <form method="post" action="../ProductServlet?action=search">
                            <input type="text" value="Tìm kiếm" name="searchkeyword" onfocus="this.value = '';" onblur="if (this.value == '') {
                                        this.value = 'Tìm kiếm';
                                    }">
                            <input type="submit" value="">
                            <br><br>

                            <!--                            <form method="post" action="Product/search.jsp">-->
                        </form>
                    </div>
                    <div class="login-right">
                        <a href="#"><h3 class="menu_head" style="font-size: 18px; color: white;" id="advSearch"><b>Tìm kiếm nâng cao</b></h3></a>
                        <form method="post" action="../ProductServlet?action=search" id="searchForm" style="display: none">
                            <label style="background-color: white; padding-right: 35px">
                                &nbsp;Chọn mức giá sản phẩm
                            </label>
                            <select name="price">
                                <option>Chưa chọn mức giá</option>
                                <option>1.000.000 - 3.000.000</option>
                                <option>3.000.000 - 5.000.000</option>
                                <option>5.000.000 - 8.000.000</option>
                                <option>Hơn 8.000.000</option>
                            </select>

                            <br>

                            <label style="background-color: white; padding-right: 35px">
                                &nbsp;Chọn chủng loại sản phẩm
                                <br>

                                <p>&nbsp;<input type="checkbox" name="category" value="Phụ Kiện Nội Thất">Phụ Kiện Nội Thất</p>
                                <p>&nbsp;<input type="checkbox" name="category" value="Nội Thất Phòng Ngủ">Nội Thất Phòng Ngủ</p>
                                <p>&nbsp;<input type="checkbox" name="category" value="Nội Thất Nhà Bếp">Nội Thất Nhà Bếp</p>
                                <p>&nbsp;<input type="checkbox" name="category" value="Nội Thất Phòng Khách">Nội Thất Phòng Khách</p>
                                <p>&nbsp;<input type="checkbox" name="category" value="Nội Thất Văn Phòng">Nội Thất Văn Phòng</p>
                            </label>

                            <label style="background-color: white; padding-right: 35px">
                                &nbsp;Chọn mức giảm giá
                                <br>
                            </label>

                            <select name="discount">
                                <option>Chưa chọn mức giảm giá</option>
                                <option>0 - 20%</option>
                                <option>20 - 50%</option>
                                <option>Hơn 50%</option>
                            </select>

                            <input type="submit" value="Tìm">
                            <br><br>
                        </form>
                    </div>

                    <script type="text/javascript">
                        $('#advSearch').click(function (e) {
                            if ($('#searchForm').is(":visible")) {
                                $('#searchForm').hide("slow");
                            } else {
                                $('#searchForm').show("slow");
                            }
                            e.preventDefault();
                        });
                    </script>
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
                        <%--<% if (request.getParameter("action") != null && request.getParameter("action").equals("edit")) {%>--%>
                        <div class="col-md-9">
                            <h3 align="center">Chỉnh/Sửa Thông tin Sản Phẩm</h3><hr>
                            <% String pid = request.getParameter("pid");
                                ProductDAO pdao = new ProductDAO();
                                Product p = pdao.getOneProduct(pid);
                                String type_name = pdao.getSpecificType(p.getCid());
                            %>
                            <form action="../ProductServlet?action=edit&pid=<%=p.getPid()%>" method="post">
                                <div class="col-md-9 login-right" style="font-size:18px">
                                    <div>
                                        <b>Mã Sản Phẩm: </b><input type="text" value="<%=p.getPid()%>" name="pid" readonly>
                                    </div>
                                    <br>
                                    <div>
                                        <b>Tên Sản Phẩm:</b> <input type="text" id="pname" maxlength="45" value="<%=p.getPname()%>" contenteditable="true" name="pname">
                                    </div>
                                    <br>
                                    <div>
                                        <b>Loại Sản Phẩm: &nbsp;</b><i style="color: #31b0d5">bed, liv, kit, off, acc</i> <input type="text" value="<%=type_name%>" name="cid" readonly>
                                    </div><br>
                                    <div>
                                        <b>Mô Tả Sản Phẩm:</b><br> <textarea rows="5" cols="63" maxlength="655" id="desc" contenteditable="true" name="desc"><%=p.getDesc()%></textarea>
                                    </div><br>
                                    <div>
                                        <b>Giá Sản Phẩm:</b> <input type="text" id="priceText" value="<%=p.getPrice()%>" contenteditable="true" name="price">
                                    </div><br>
                                    <div>
                                        <b>Đánh giá Sản Phẩm:</b><input type="text" value="<%=p.getRating()%>" name="rating" readonly>
                                    </div><br>
                                    <div>
                                        <b>Số lượt xem:</b><input type="text" value="<%=p.getView()%>" name="view" readonly>
                                    </div><br>
                                    <div>
                                        <b>Hình ảnh:</b><img src="../<%=p.getP_img()%>1.jpg" name="image" alt="No Image">
                                    </div><br>
                                    <div>
                                        <b>Số lượng:</b><input type="text" id="quantityText" value="<%=p.getQuantity()%>" contenteditable="true" size="4" name="quantity">
                                    </div><br>
                                    <div>
                                        <b>Phần Trăm Giảm:</b><input type="text" id="discountText" value="<%=p.getDiscount()%>" contenteditable="true" name="discount">
                                    </div><br>
                                    <input type="submit" value="Cập Nhật Thông Tin">&nbsp;&nbsp;&nbsp;&nbsp;<a href="../Product/storemanage.jsp">Trở lại</a>
                                </div>
                            </form>
                            <script type="text/javascript">
                                var pr = document.getElementById("priceText");
                                var qr = document.getElementById("quantityText");
                                var dr = document.getElementById("discountText");
                                function isValidInput() {
                                    if (isNaN(pr.value) || isNaN(qr.value) || isNaN(dr.value) || pr.value < 0 || qr.value < 0 || dr.value < 0) {
                                        this.setCustomValidity('Vui Lòng Nhập Số Nguyên và Giá Trị Tối Thiểu = 0!');
                                    } else {
                                        this.setCustomValidity('');
                                    }
                                }
                                pr.onchange = isValidInput;
                                qr.onchange = isValidInput;
                                dr.onchange = isValidInput;

                                var pname = document.getElementById("pname");
                                var desc = document.getElementById("desc");
                                var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);

                                function isValidPname() {
                                    if (pattern.test(pname.value)) {
                                        pname.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        pname.setCustomValidity('');
                                    }
                                }
                                function isValidDesc() {
                                    if (pattern.test(desc.value)) {
                                        desc.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                    } else {
                                        desc.setCustomValidity('');
                                    }
                                }
                                pname.onchange = isValidPname;
                                desc.onchange = isValidDesc;
                            </script>
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
                    <input type="text" class="text" value="Email" onfocus="this.value = '';" onblur="if (this.value == '') {
                                this.value = 'Email';
                            }">
                    <input type="submit" value="Đăng Ký">
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
</body>
</html>
