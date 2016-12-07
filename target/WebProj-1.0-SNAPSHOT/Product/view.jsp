<%@page import="dao.UserDAO"%>
<%@page import="dao.ComResDAO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Sản phẩm</title>
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
        <style type="text/css">
            .rating {
                float:left;
            }

            /* :not(:checked) is a filter, so that browsers that don’t support :checked don’t 
               follow these rules. Every browser that supports :checked also supports :not(), so
               it doesn’t make the test unnecessarily selective */
            .rating:not(:checked) > input[type="radio"] {
                position:absolute;
                top:-9999px;
                clip:rect(0,0,0,0);
            }

            .rating:not(:checked) > label {
                float:right;
                width:1em;
                padding:0 .1em;
                overflow:hidden;
                white-space:nowrap;
                cursor:pointer;
                font-size:200%;
                line-height:1.2;
                color:#ddd;
                text-shadow:1px 1px #bbb, 2px 2px #666, .1em .1em .2em rgba(0,0,0,.5);
            }

            .rating:not(:checked) > label:before {
                content: '★ ';
            }

            .rating > input[type="radio"]:checked ~ label {
                color: #f70;
                text-shadow:1px 1px #c60, 2px 2px #940, .1em .1em .2em rgba(0,0,0,.5);
            }

            .rating:not(:checked) > label:hover,
            .rating:not(:checked) > label:hover ~ label {
                color: gold;
                text-shadow:1px 1px goldenrod, 2px 2px #B57340, .1em .1em .2em rgba(0,0,0,.5);
            }

            .rating > input[type="radio"]:checked + label:hover,
            .rating > input[type="radio"]:checked + label:hover ~ label,
            .rating > input[type="radio"]:checked ~ label:hover,
            .rating > input[type="radio"]:checked ~ label:hover ~ label,
            .rating > label:hover ~ input[type="radio"]:checked ~ label {
                color: #ea0;
                text-shadow:1px 1px goldenrod, 2px 2px #B57340, .1em .1em .2em rgba(0,0,0,.5);
            }

            .rating > label:active {
                position: static;
                top:2px;
                left:2px;
            }
        </style>

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
        <script src="../js/easyResponsiveTabs.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#horizontalTab').easyResponsiveTabs({
                    type: 'default', //Types: default, vertical, accordion           
                    width: 'auto', //auto or any width like 600px
                    fit: true   // 100% fit in a container
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
        <%
            ProductDAO pd = new ProductDAO();
            Product x = pd.getOneProduct(request.getParameter("pid"));
            if (x.getPid() == null) {
                response.sendRedirect("../index.jsp");
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
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Tủ Bếp">Tủ Bếp</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Bàn Làm Việc">Bàn Làm Việc</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Giường Ngủ">Giường Ngủ</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Ghế Gỗ">Ghế Gỗ</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Tủ Tivi">Tủ Tivi</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Khung Gương">Khung Gương</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Sang Trọng">Sang Trọng</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Cao Cấp">Cao Cấp</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Hiện đại">Hiện Đại</a></li>
                                        <li><a href="../ProductServlet?action=search&searchkeyword=Cổ điển">Cổ Điển</a></li>
                                </ul>
                            </div>
                        </div>
                        <div class="col-md-9">
                            <div class="dreamcrub">
                                <ul class="breadcrumbs">
                                    <li class="home">
                                        <a href="../index.jsp" title="Trở về trang chủ">Trang Chủ</a>&nbsp;
                                        <span>&gt;</span>
                                    </li>
                                    <li class="home">&nbsp;
                                        Sản Phẩm&nbsp;
                                        <span>&gt;</span>&nbsp;
                                    </li>                    
                                </ul>
                                <ul class="previous">
                                    <li><a href="../index.jsp">Trở về trang chủ</a></li>
                                </ul>
                                <div class="clearfix"></div>
                            </div>


                            <%String url = "/WebProj/shoppingcart.ShoppingServlet?action=add&pid=" + x.getPid();%>
                            <div class="singel_right">
                                <div class="labout span_1_of_a1">
                                    <div class="flexslider">
                                        <ul class="slides">
                                            <li data-thumb=<%="../" + x.getP_img() + "1.jpg"%>>
                                                <img src=<%="../" + x.getP_img() + "1.jpg"%> />
                                            </li>
                                            <li data-thumb=<%="../" + x.getP_img() + "2.jpg"%>>
                                                <img src=<%="../" + x.getP_img() + "2.jpg"%> />
                                            </li>
                                            <li data-thumb=<%="../" + x.getP_img() + "3.jpg"%>>
                                                <img src=<%="../" + x.getP_img() + "3.jpg"%> />
                                            </li>
                                            <li data-thumb=<%="../" + x.getP_img() + "4.jpg"%>>
                                                <img src=<%="../" + x.getP_img() + "4.jpg"%> />
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="cont1 span_2_of_a1 simpleCart_shelfItem">
                                    <h1><%=x.getPname()%></h1>
                                    <div class="col-md-9">

                                        <form action="../ProductServlet?action=rate&pid=<%=x.getPid()%>" method="post">
                                            <div class="col-md-6 login-left">

                                                <fieldset class="rating">
                                                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="Rocks!">5 stars</label>
                                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="Pretty good">4 stars</label>
                                                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="Meh">3 stars</label>
                                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="Kinda bad">2 stars</label>
                                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="Sucks big time">1 star</label>
                                                </fieldset>
                                            </div>
                                            <div class="col-md-3 login-right" style="padding-top: 5px;">
                                                <% if (user_t == null) {%>
                                                <input type="submit" value="Bạn phải đăng nhập để đánh giá" style="background-color: #FFD001; padding: 2px; font-style: strong;font-size: 12px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5" disabled>
                                                <% } else { %>
                                                <input type="submit" value="Đánh giá" style="background-color: #FFD001; padding: 2px; font-style: strong;font-size: 12px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                                <% } %>
                                            </div>


                                        </form>
                                    </div>
                                    <div class="clearfix"></div>
                                    <div class="price_single">
                                        <%
                                            if (x.getDiscount() != 0.0) {
                                                out.println(
                                                        "<span class=\"reducedfrom\">" + x.getPrice() + " VND</span>\n"
                                                        + "<span class=\"amount item_price actual\">" + (int) (x.getPrice() * (100 - x.getDiscount()) / 100) + " VND</span>Ưu Đãi</a>");
                                            } else {
                                                out.println(
                                                        "<span class=\"amount item_price actual\">" + x.getPrice() + " VND</span>\n");
                                            }
                                        %>

                                    </div>
                                    <br>
                                    <h3 class="quick">Mô Tả Chung:</h3>
                                    <p class="quick_desc"><%=x.getDesc()%></p>

                                    <div id="shopping" class="btn_form button item_add item_1">
                                        <form method="post" action=<%=url%>>
                                            <ul class="product-qty">
                                                <span>Số lượng:</span>
                                                <!--<input type="number" name="quantity" min="1" max="20">-->
                                                <select name="quantity">
                                                    <%
                                                        for (int i = 1; i <= 20; i++) {
                                                            out.println("<option>" + i + "</option>");
                                                        }
                                                    %>
                                                </select>

                                                <span>Tồn Kho: <%=x.getQuantity()%> sản phẩm</span>
                                            </ul>

                                            <input type="submit" value="Thêm vào giỏ" title="">
                                        </form>


                                        <%String url2 = "../controller.WishListServlet?action=add&pid=" + x.getPid();%>
                                        <div class="col-md-4 login-left">
                                            <form method="post" action=<%=url2%>>
                                                <input type="submit" value="+ DS.Mong Muốn" title="">
                                            </form>
                                        </div>
                                        <%String url3 = "../shoppingcart.ShoppingServlet?action=addCompare&pid=" + x.getPid();%>
                                        <div class="col-md-4 login-left">
                                            <form method="post" action=<%=url3%>>
                                                <input type="submit" value="+ D.S So Sánh" title="">
                                            </form>
                                        </div>
                                    </div>

                                    <% if (user_t != null) {%>
                                    <script type="text/javascript">


                                        var status = <%=user_t.getIsManager()%>;

                                        $(function () {

                                            if (status == 1) {
                                                $("#shopping").hide();
                                            }

                                        });


                                    </script>
                                    <%}%>

                                </div>
                                <div class="clearfix"></div>
                            </div>
                            <div class="sap_tabs">	
                                <div id="horizontalTab" style="display: block; width: 100%; margin: 0px;">
                                    <ul class="resp-tabs-list">
                                        <li class="resp-tab-item" aria-controls="tab_item-0" role="tab"><span>Mô Tả Sản Phẩm</span></li>
                                        <!--                                        <li class="resp-tab-item" aria-controls="tab_item-2" role="tab"><span>Đánh Giá Sản Phẩm</span></li>-->
                                        <li class="resp-tab-item" aria-controls="tab_item-2" role="tab"><span>Bình Luận</span></li>
                                        <div class="clear"></div>
                                    </ul>				  	 
                                    <div class="resp-tabs-container">
                                        <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-0">
                                            <div class="facts">
                                                <ul class="tab_list">
                                                    <li><%=x.getDesc()%></li>

                                                </ul>           
                                            </div>
                                        </div>						
                                        <!--                                        <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-2">
                                                                                    <ul class="tab_list">
                                                                                        <li>Quý khách hãy đánh giá chất lượng sản phẩm: thang điểm từ từ 1 đến 5</li>
                                                                                    
                                                                                    <div class="col-md-9">
                                        
                                                                                        <form action="../ProductServlet?action=rate&pid=<%=x.getPid()%>" method="post">
                                                                                            <div class="col-md-6 login-left">
                                        
                                                                                                <fieldset class="rating">
                                                                                                    <input type="radio" id="star5" name="rating" value="5" /><label for="star5" title="Rocks!">5 stars</label>
                                                                                                    <input type="radio" id="star4" name="rating" value="4" /><label for="star4" title="Pretty good">4 stars</label>
                                                                                                    <input type="radio" id="star3" name="rating" value="3" /><label for="star3" title="Meh">3 stars</label>
                                                                                                    <input type="radio" id="star2" name="rating" value="2" /><label for="star2" title="Kinda bad">2 stars</label>
                                                                                                    <input type="radio" id="star1" name="rating" value="1" /><label for="star1" title="Sucks big time">1 star</label>
                                                                                                </fieldset>
                                                                                            </div>
                                                                                            <div class="col-md-3 login-right" style="padding-top: 5px;">
                                        <% if (user_t == null) {%>
                                        <input type="submit" value="Bạn phải đăng nhập để đánh giá" style="background-color: #FFD001; padding: 2px; font-style: strong;font-size: 12px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5" disabled>
                                        <% } else { %>
                                        <input type="submit" value="Đánh giá" style="background-color: #FFD001; padding: 2px; font-style: strong;font-size: 12px; box-shadow: none; border-radius: 5px; display: inline-block; line-height: 1.5">
                                        <% } %>
                                    </div>


                                </form>
                            </div>
                            </ul>  
                        </div>-->
                                        <%@ page import="net.tanesha.recaptcha.ReCaptcha"%>
                                        <%@ page import="net.tanesha.recaptcha.ReCaptchaFactory"%>  
                                        <script src="https://www.google.com/recaptcha/api.js" async defer></script>
                                        <div class="tab-1 resp-tab-content" aria-labelledby="tab_item-2">
                                            <ul class="tab_list">
                                                <!--                                                <li>Chưa có bình luận</li>-->

                                                <%
                                                    boolean isLogin = true;
                                                %>

                                                <%
                                                    if (user_t != null) {
                                                        out.println(
                                                                "<div>\n"
                                                                + "<a class=\"acount-btn\" id=\"comment\" href=\"#\">Gửi Bình Luận</a>\n"
                                                                + "</div>\n"
                                                                + "<form action=\"../CommentServlet?action=newcomment&ucid=" + user_t.getUid() + "&pid=" + x.getPid() + "\" method=\"post\" id=\"commentForm\" style=\"display: none\">\n"
                                                                + "<br>\n<div class=\"contact-form\">"
                                                                + "<textarea value=\"Enter your message here...\" maxlength=\"355\" id=\"commentBox\" name=\"content\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') { "
                                                                + "this.value = '';"
                                                                + "}\" required></textarea></div>\n"
                                                                + "<div class=\"g-recaptcha\" data-sitekey=\"6LewuwwUAAAAAKvnR3GcLNj7D9dCOrSKsu9NByaO\" align=\"left\"></div>\n"
                                                                + "<pre><input type=\"submit\" class=\"acount-btn\" value=\"Gửi Bình Luận:\"></pre>\n"
                                                                + "</form>\n"
                                                                + "<br/><br/>");
                                                %>
                                                <script>
                                                    var cmbox = document.getElementById("commentBox");
                                                    var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                                    function isValidCmbox() {
                                                            if (pattern.test(cmbox.value)) {
                                                                cmbox.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                                            } else {
                                                                    cmbox.setCustomValidity('');
                                                            }
                                                    }
                                                    cmbox.onchange = isValidCmbox;
                                                </script>
                                                
                                                <%
                                                    }
                                                %>

                                                <%
                                                    if (user_t == null) {
                                                        isLogin = false;
                                                        out.println("<br><h5><i>Vui lòng đăng nhập để gửi bình luận.</i></h5>");
                                                    }%>


                                                <%
                                                    ComResDAO crdao = new ComResDAO();
                                                    UserDAO udao = new UserDAO();
                                                    List<Comment> comments = crdao.getAllComment(x.getPid());
                                                    if (comments.size() > 0) {
                                                        for (int i = 0; i < comments.size(); i++) {
                                                            int cmid = comments.get(i).getCmid();
                                                            int ucid = comments.get(i).getUcid();
                                                            Comment cm = comments.get(i); //to process each comment
                                                            User utemp = udao.getOneUser(ucid); //to get User Name
                                                            List<Response> resp = crdao.getAllResponse(cmid);
                                                            out.print("<pre style=\"background-color: #ffcc99;\">" + cm.getDate() + " " + cm.getTime() + "<br/>&#9733;<b>" + utemp.getLast_name() + " " + utemp.getFirst_name() + "</b>&#9733; nói: " + cm.getContent());

                                                            if (isLogin == true) {
                                                                out.println(
                                                                        //"</div>\n" 
                                                                        "<br/><a class=\"acount-btn\" id=\"comment" + i + "\" href=\"#\">Gửi Phản Hồi</a>\n" + "</pre>\n" );
                                                                        //+ "</div>\n");
                                                                out.println(
                                                                        //"\n<div>\n" +

                                                                        
                                                                        "\n<form action=\"../CommentServlet?action=newresponse&ucid=" + user_t.getUid() + "&pid=" + x.getPid() + "&cmid=" + cm.getCmid() + "\" method=\"post\" id=\"commentForm" + i + "\" style=\"display: none\">\n"
                                                                        + "<br>\n<div class=\"contact-form\">"
                                                                        + "<textarea value=\"Enter your message here...\" maxlength=\"355\" id=\"rBox"+i+"\" name=\"content\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') { "
                                                                        + "this.value = '';"
                                                                        + "}\" required></textarea></div>\n"
                                                                        
                                                                        + "<pre><input type=\"submit\" class=\"acount-btn\" value=\"Gửi Phản Hồi:\"></pre>\n"
                                                                        + "</form>\n"
                                                                                
                                                                        + "<script type=\"text/javascript\">\n"
                                                                        + "$('#comment" + i + "').click(function (e) {\n"
                                                                        + "if ($('#commentForm" + i + "').is(\":visible\")) {\n"
                                                                        + "$('#commentForm" + i + "').hide(\"slow\");\n"
                                                                        + "} else {\n"
                                                                        + "$('#commentForm" + i + "').show(\"slow\");\n"
                                                                        + "}\n"
                                                                        + "e.preventDefault();\n"
                                                                        + "});\n"
                                                                        + "</script>\n");
                                                %>
                                                    <script>
                                                            var rs<%=i%> = document.getElementById("rBox<%=i%>");
                                                            var pattern = new RegExp(/[~`!@#$%\^&*+=\-\[\]\\';/{}|\\":<>\?]/);
                                                            function isValidRs<%=i%>() {
                                                                    if (pattern.test(rs<%=i%>.value)) {
                                                                        rs<%=i%>.setCustomValidity('Vui lòng không nhập ký tự đặc biệt!');
                                                                    } else {
                                                                        rs<%=i%>.setCustomValidity('');
                                                                    }
                                                            }
                                                            rs<%=i%>.onchange = isValidRs<%=i%>;
                                                    </script>
                                                <%          } else {
                                                                out.println("</pre>");
                                                            }

                                                            for (int j = 0; j < resp.size(); j++) {
                                                                int cmid2 = resp.get(j).getCmid();
                                                                int urid = resp.get(j).getUrid();
                                                                Response r = resp.get(j);
                                                                User utemp2 = udao.getOneUser(urid);
                                                %>
                                                <pre>   <%=r.getDate()%> <%=r.getTime()%><br/>   &#9733;<b><%=utemp2.getLast_name()%> <%=utemp2.getFirst_name()%></b>&#9733; nói: <%=r.getContent()%></pre>

                                                <%}
                                                        }
                                                    }%>

                                                <script type="text/javascript">
                                                    $('#comment').click(function (e) {
                                                        if ($('#commentForm').is(":visible")) {
                                                            $('#commentForm').hide("slow");
                                                        } else {
                                                            $('#commentForm').show("slow");
                                                        }
                                                        e.preventDefault();
                                                    });
                                                </script>
                                                <%--<%}%>--%>
                                            </ul>
                                        </div>

                                    </div>
                                </div>
                            </div>	
                            <h3 class="like">Sản phẩm cùng loại</h3>        			
                            <ul id="flexiselDemo3">
                                <%
                                    List<Product> productList = pd.getSimilarProduct(x);

                                    for (int i = 0; i < productList.size(); i++) {
                                        out.println(
                                                "<li>\n"
                                                + "<a href=\"" + "../Product/view.jsp?pid=" + productList.get(i).getPid() + "\">" + "<img src=" + "../" + productList.get(i).getP_img() + "1.jpg" + " class=\"img-responsive\" /></a>\n"
                                                + "<div class=\"grid-flex\"><a href=\"" + "view.jsp?pid=" + productList.get(i).getPid() + "\">" + productList.get(i).getPname() + "</a></div>\n"
                                                + "</li>");
                                    }
                                %>
                            </ul>
                            <script type="text/javascript">
                                $(window).load(function () {
                                    $("#flexiselDemo3").flexisel({
                                        visibleItems: 3,
                                        animationSpeed: 1000,
                                        autoPlay: true,
                                        autoPlaySpeed: 3000,
                                        pauseOnHover: true,
                                        enableResponsiveBreakpoints: true,
                                        responsiveBreakpoints: {
                                            portrait: {
                                                changePoint: 480,
                                                visibleItems: 1
                                            },
                                            landscape: {
                                                changePoint: 640,
                                                visibleItems: 2
                                            },
                                            tablet: {
                                                changePoint: 768,
                                                visibleItems: 3
                                            }
                                        }
                                    });
                                });
                            </script>
                            <script type="text/javascript" src="../js/jquery.flexisel.js"></script>
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
        <script defer src="../js/jquery.flexslider.js"></script>
        <link rel="stylesheet" href="../css/flexslider.css" type="text/css" media="screen" />

        <script>
                            $(window).load(function () {
                                $('.flexslider').flexslider({
                                    animation: "slide",
                                    controlNav: "thumbnails"
                                });
                            });
        </script>

    </body>
</html>		