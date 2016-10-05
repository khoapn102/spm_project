<%@page import="java.util.Map"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="dao.OrderDAO"%>
<%@page import="dao.UserDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.User"%>
<!DOCTYPE HTML>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>Quản lý xưởng</title>
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
                            <!--Button Design -->
                            <div class="account_grid" id="functions">
                                <div class="col-md-6">
                                    <div>
                                        <a class="acount-btn" id="list" href="#" style="background-color: #31b0d5;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Danh Sách Sản Phẩm</a>
                                    </div><br><br>
                                    <div>
                                        <a class="acount-btn" id="addremove" href="#" style="background-color: #c9302c;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Nhập/Xuất Kho</a>
                                    </div><br><br>
                                    <div>
                                        <a class="acount-btn" id="order" href="#" style="background-color: #c0a16b;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Danh Sách Đơn Hàng</a>
                                    </div><br><br>
                                </div>
                                <div class="col-md-6">
                                    <div>
                                        <a class="acount-btn" id="report" href="#" style="background-color: #f0ad4e;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Tổng Kết Thu Nhập</a>
                                    </div><br><br>
                                    <div>
                                        <a class="acount-btn" id="customer" href="#" style="background-color: #3b5997;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Danh Sách Khách Hàng</a>
                                    </div><br><br>
                                    <div>
                                        <a class="acount-btn" id="employee" href="#" style="background-color: #595555;padding: 15px 30px; font-size: 25px; width: 350px; text-align: center">Danh sách Nhân viên</a>
                                    </div><br><br>
                                </div>
                            </div>
                            <!--Form Display-->
                            <div class="col-lg-12" id="prodList" style="display: none; ">
                                <p><i>Click vào hình hay mã sản phẩm để thay đổi thông tin</i></p>
                                <div id="cbp-vm" class="cbp-vm-switcher cbp-vm-view-grid">
                                    <div class="clearfix"></div>
                                    <% ProductDAO pdao = new ProductDAO();
                                        List<Product> prodList = pdao.getAllProduct();
                                        List<String> type = pdao.getAllType();
                                        //Page Scope Request, set attribute so that we can retrieve with Jstl
                                        pageContext.setAttribute("prodList", prodList);
                                        pageContext.setAttribute("type", type);%>
                                    <table> 
                                        <ol>
                                            <c:forEach var="prod" items="${prodList}" varStatus="status">
                                                <tr>
                                                    <td><li></li></td>
                                                <td><a href="../Product/editProd.jsp?action=edit&pid=${prod.pid}"><pre>${prod.pid}</pre></a></td>
                                                <td><a href="../Product/editProd.jsp?action=edit&pid=${prod.pid}"><pre><img src="../${prod.p_img}1.jpg" width="30" height="30" alt="No Image"></pre></a></td>
                                                <td><a href="../Product/editProd.jsp?action=edit&pid=${prod.pid}"><pre>${type[status.index]}</pre></td>
                                                <td><a href="../Product/editProd.jsp?action=edit&pid=${prod.pid}"><pre>${prod.pname}</pre></td>
                                                <td><pre>${prod.quantity}</pre></td>
                                                <td><pre>${prod.price}</pre></td>
                                                <td><pre>${prod.rating}</pre></td>
                                                <td><pre>${prod.view}</pre></td>
                                                <td><pre>${prod.discount}</pre></td>
                                                <td><form action="../ProductServlet?action=delete&pid=${prod.pid}" method="post" onsubmit="return confirm('Chắc chắn xóa? Bấm Ok để tiếp tục!');">
                                                        <input type="submit" value="Xóa" style="background-color: #FFD001; padding: 5px; font-style: strong;font-size: 15px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                    </form></td>
                                                </tr>
                                            </c:forEach>
                                        </ol>
                                    </table>
                                </div>

                                <div class="clearfix"></div><br><br>
                                <div><a class="acount-btn" id="report" href="../Product/storemanage.jsp">Trở Lại</a></div>
                            </div>
                            <div class="cold-md-9" id="manageList" style="display: none; ">
                                &nbsp;&nbsp;&nbsp;<a href="../Product/storemanage.jsp">Trở lại</a>
                                <form action="../ProductServlet?action=add" method="post">
                                    <div class="col-md-9 login-right" style="font-size:18px">
                                        <div id="selectList">
                                            <b>Mã Sản Phẩm: </a></b>
                                            <!--<select id="choose" name="pid">
                                                <option value="tab1">tab1</option>
                                                <option value="tab2">tab2</option>
                                                <option value="tab3">tab3</option>
                                                <option value="bed1">bed1</option>
                                                <option value="bed2">bed2</option>
                                                <option value="bed3">bed3</option>
                                                <option value="bep1">bep1</option>
                                                <option value="bep2">bep2</option>
                                                <option value="bep3">bep3</option>
                                                <option value="off1">off1</option>
                                                <option value="off2">off2</option>
                                                <option value="off3">off3</option>
                                                <option value="pk1">pk1</option>
                                                <option value="pk2">pk2</option>
                                                <option value="pk3">pk3</option>
                                                <option value="0">Khác</option>
                                            </select>
                                            <label id="other" style="display:none;">
                                                <input type="text" name="othername" placeholder="Khác"/>
                                            </label>
                                            <script type="text/javascript">
                                                $('#choose').change(function () {
                                                    if ($(this).val() == '0') {
                                                        //$('#manageList').append('<input id="myInput" type="text" />');
                                                        $('#other').show();
                                                    } else {
                                                        $('#other').hide();
                                                    }
                                                });
                                            </script>-->
                                            <input type="text" id="pid" name="pid" placeholder="Mã Sản Phẩm">
                                        </div><br>
                                        <div>
                                            <b>Tên Sản Phẩm:</b> <input type="text" id="pname" maxlength="45" name="pname" required>
                                        </div><br>
                                        <div>
                                            <b>Loại Sản Phẩm:</b> 
                                            <select name="cid">
                                                <option value="liv">Nội Thất Phòng Khách</option>
                                                <option value="bed">Nội Thất Phòng Ngủ</option>
                                                <option value="kit">Nội Thất Nhà Bếp</option>
                                                <option value="off">Nội Thất Văn Phòng</option>
                                                <option value="acc">Phụ Kiện Nội Thất</option>
                                            </select>
                                        </div><br>
                                        <div>
                                            <b>Mô Tả Sản Phẩm:</b><br> <textarea rows="5" id="desc" maxlength="655" cols="63" name="desc"></textarea>
                                        </div><br>
                                        <div>
                                            <b>Giá Sản Phẩm:</b> <input type="text" name="price" id="priceText" required>
                                        </div><br>
                                        <div>
                                            <b>Đánh giá Sản Phẩm:</b><input type="text" name="rating" value=0 readonly>
                                        </div><br>
                                        <div>
                                            <b>Số lượt xem:</b><input type="text" value=0 name="view" readonly>
                                        </div><br>
                                        <!--<div>
                                            <b>Hình ảnh:</b><input type="text" name="image">
                                        </div><br>-->
                                        <div>
                                            <b>Số lượng:</b><input type="text" name="quantity" size="4" id="quantityText" required>
                                        </div><br>
                                        <div>
                                            <b>Phần Trăm Giảm:</b><input type="text" name="discount" id="discountText">
                                        </div><br>
                                        <input type="submit" value="Thêm Sản Phẩm">&nbsp;&nbsp;&nbsp;&nbsp;<a href="../Product/storemanage.jsp">Trở lại</a>
                                    </div>
                                </form>
                                <script type="text/javascript">

                                    var pr = document.getElementById("priceText");
                                    var qr = document.getElementById("quantityText");
                                    var dr = document.getElementById("discountText");
                                    function isValidPrice() {
                                        if (isNaN(pr.value) || pr.value < 0) {
                                            this.setCustomValidity('Vui Lòng Nhập Số Nguyên và Giá Trị Tối Thiểu = 0!');
                                        } else {
                                            this.setCustomValidity('');
                                        }
                                    }
                                    function isValidQuantity() {
                                        if (isNaN(qr.value) || qr.value < 0) {
                                            this.setCustomValidity('Vui Lòng Nhập Số Nguyên và Giá Trị Tối Thiểu = 0!');
                                        } else {
                                            this.setCustomValidity('');
                                        }
                                    }
                                    function isValidDiscount() {
                                        if (isNaN(dr.value) || dr.value < 0) {
                                            this.setCustomValidity('Vui Lòng Nhập Số Nguyên và Giá Trị Tối Thiểu = 0!');
                                        } else {
                                            this.setCustomValidity('');
                                        }
                                    }
                                    pr.onkeyup = isValidPrice;
                                    qr.onkeyup = isValidQuantity;
                                    dr.onkeyup = isValidDiscount;

                                    var pname = document.getElementById("pname");
                                    var desc = document.getElementById("desc");
                                    var pid = document.getElementById("pid");
                                    var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                    function isValidPid() {
                                        if (pattern.test(pid.value)) {
                                            pid.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                        } else {
                                            pid.setCustomValidity('');
                                        }
                                    }
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
                                    pid.onchange = isValidPid;
                                    pname.onchange = isValidPname;
                                    desc.onchange = isValidDesc;

                                </script>
                            </div>
                            <!--Order Section-->
                            <div class="col-md-12" id="orderList" style="display: none; ">
                                <% OrderDAO odao = new OrderDAO();
                                    List<Order> orlist = odao.getAllOrder();
                                    pageContext.setAttribute("orlist", orlist);
                                %>
                                <%--<c:forEach var="ord" items="${orlist}">
                                    <c:out value="${ord.mid}"/>
                                </c:forEach>--%>
                                <div class="col-md-12" id="section">
                                    <table> 
                                        <ol>
                                            <c:forEach var="order" items="${orlist}">
                                                <tr>
                                                    <td><li></li></td>
                                                <form action="../OrderServlet?action=edit&mid=${order.mid}&pid=${order.pid}&date=${order.date}&time=${order.time}" method="post">
                                                    <td><pre>${order.mid}</pre></td>
                                                    <td><pre>${order.pid}"</pre></td>
                                                    <td><pre>${order.date}</pre></td>
                                                    <td><pre>${order.time}</pre></td>
                                                    <td><pre><input type="text" class="orquan" pattern="[0-9]{1,3}" title="Vui lòng nhập số nguyên > 0!" autofocus value="${order.quantity}" name="quantity" size="5"></pre></td>
                                                    <td>
                                                        <input type="submit" value="Cập Nhật" style="background-color: #FFD001; padding: 5px; font-style: strong;font-size: 15px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                    </td>
                                                </form>
                                                <td>&nbsp;&nbsp;&nbsp;</td>
                                                <td><form action="../OrderServlet?action=delete&mid=${order.mid}&pid=${order.pid}&date=${order.date}&time=${order.time}" method="post" onsubmit="return confirm('Chắc chắn xóa? Bấm Ok để tiếp tục!');">
                                                        <input type="submit" value="Xóa" style="background-color: #FFD001; padding: 5px; font-style: strong;font-size: 15px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                    </form></td>
                                                </tr>

                                            </c:forEach>
                                        </ol>
                                    </table>
                                    <script type="text/javascript">
                                        /*var orquan = document.getElementByClassName("orquan");
                                        function isValidInput() {
                                            for (int i = 0; i < orquan.length; i++) {
                                                if (isNaN(orquan[i].value) || orquan[i].value < 0) {
                                                    this.setCustomValidity('Vui Lòng Nhập Số Nguyên và Giá Trị Tối Thiểu = 0!');
                                                } else {
                                                    this.setCustomValidity('');
                                                }
                                            }
                                        }
                                        orquan.onkeyup = isValidInput;*/
                                    </script>
                                </div>
                                <div class="clearfix"></div><br><br>
                                <div><a class="acount-btn" id="report" href="../Product/storemanage.jsp">Trở Lại</a></div>
                            </div>

                            <div class="col-md-9" id="custList" style="display: none; ">
                                <%  int i = 1;
                                    UserDAO udao = new UserDAO();
                                    List<User> customer = udao.getAllCustomer();
                                    pageContext.setAttribute("allCust", customer);
                                %>
                                <table> 
                                    <ol id="orderlist">
                                        <c:forEach var="cust" items="${allCust}">
                                            <tr>
                                                <td><li></li></td>
                                            <td><pre><img src="../${cust.image_url}" width="30" height="30" alt="No Image"></pre></td>
                                            <td><pre>${cust.last_name} ${cust.first_name}</pre></td>
                                            <td><pre>${cust.dob}</pre></td>
                                            <td><pre>${cust.phone_number}</pre></td>
                                            <td><pre>${cust.address}</pre></td>
                                            <td><pre>${cust.email}</pre></td>
                                            <td><form action="../controller.UserServlet?action=delete&uid=${cust.uid}" method="post" onsubmit="return confirm('Chắc chắn xóa? Bấm Ok để tiếp tục!');">
                                                    <input type="submit" value="Xóa" style="background-color: #FFD001; padding: 5px; font-style: strong;font-size: 15px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                </form></td>
                                            </tr>
                                        </c:forEach>
                                    </ol>
                                </table>
                                <div class="clearfix"></div><br><br>
                                <div><a class="acount-btn" id="report" href="../Product/storemanage.jsp">Trở Lại</a></div>
                            </div>
                            <div class="account-grid" id="reportList" style="display: none; ">
                                <% //OrderDAO da = new OrderDAO();
                                    List<Order> best = odao.getBestSeller();
                                %>
                                <div class="col-md-12" align="center">
                                    <!--<textarea cols="100" rows="22" style="overflow-y: scroll">
                                    </textarea>-->
                                    <h2>Tổng Kết</h2><hr>
                                    <h5><b>Sản Phẩm Bán được trong Tuần</b></h5>
                                    <%
                                        Set report = odao.getReport();
                                        Iterator iter = report.iterator();
                                        int res = 0;
                                        while (iter.hasNext()) {
                                            Map.Entry me = (Map.Entry) iter.next();
                                            int price = pdao.getItemPrice(me.getKey().toString());
                                            int total = (int) me.getValue() * price;
                                            out.println("<pre>" + me.getKey() + "\t\t" + me.getValue().toString() + "\t\t" + total + "</pre>");
                                            res += total;
                                            //System.out.println(me.getValue());
                                        }
                                        out.println("<pre>Tổng số tiền thu được:" + "\t\t" + res + "</pre>");
                                    %>
                                    <h5><b>Những Sản Phẩm bán chạy trong Tuần ( số lượng > 5 )</b></h5>
                                    <%
                                        for (int it = 0; it < best.size(); it++) {
                                            out.println("<pre>" + best.get(it).getPid() + "\t\t" + best.get(it).getQuantity() + "</pre>");
                                        }
                                    %>
                                </div>
                                <div class="clearfix"></div><br><br>
                                <div><a class="acount-btn" id="report" href="../Product/storemanage.jsp">Trở Lại</a></div>
                            </div>
                            <div class="account-grid" id="employeeList" style="display: none; ">
                                <%
                                    List<User> empl = udao.getAllEmployee();
                                    pageContext.setAttribute("empl", empl);
                                %>
                                <table> 
                                    <ol id="orderlist">
                                        <c:forEach var="emp" items="${empl}">
                                            <tr>
                                                <td><li></li></td>
                                            <td><pre><img src="../${emp.image_url}" width="30" height="30" alt="No Image"></pre></td>
                                            <td><pre>${emp.last_name} ${emp.first_name}</pre></td>
                                            <td><pre>${emp.dob}</pre></td>
                                            <td><pre>${emp.phone_number}</pre></td>
                                            <td><pre>${emp.address}</pre></td>
                                            <td><pre>${emp.email}</pre></td>
                                            <td><form action="../controller.UserServlet?action=delete&uid=${emp.uid}" method="post" onsubmit="return confirm('Chắc chắn xóa? Bấm Ok để tiếp tục!');">
                                                    <input type="submit" value="Xóa" style="background-color: #FFD001; padding: 5px; font-style: strong;font-size: 15px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                </form></td>
                                            </tr>
                                        </c:forEach>
                                    </ol>
                                </table>
                                <div class="clearfix"></div><br><br>
                                <div><a class="acount-btn" id="report" href="../Product/storemanage.jsp">Trở Lại</a></div>
                            </div>
                            <script type="text/javascript">


                                $('#list').click(function (e) {
                                    if ($('#prodList').is(":visible")) {
                                        $('#prodList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#prodList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });
                                $('#addremove').click(function (e) {
                                    if ($('#manageList').is(":visible")) {
                                        $('#manageList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#manageList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });
                                $('#order').click(function (e) {
                                    if ($('#orderList').is(":visible")) {
                                        $('#orderList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#orderList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });
                                $('#report').click(function (e) {
                                    if ($('#reportList').is(":visible")) {
                                        $('#reportList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#reportList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });
                                $('#customer').click(function (e) {
                                    if ($('#custList').is(":visible")) {
                                        $('#custList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#custList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });
                                $('#employee').click(function (e) {
                                    if ($('#employeeList').is(":visible")) {
                                        $('#employeeList').hide();
                                        $('#functions').show();
                                    } else {
                                        $('#employeeList').show();
                                        $('#functions').hide();
                                    }
                                    e.preventDefault();
                                });

                            </script>
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
                    <p>
                        Chủ cơ sở : NGUYỄN VĂN QUÝ<br/>
                        Copyright &copy; 2015 Xưởng Mộc Cao Cấp Nguyễn Văn Quý. Phát triển bởi <a href="#" target="_blank">HKT Software Solution</a>
                    </p>
                </div>
            </div>
        </div>
    </body>
</html>
