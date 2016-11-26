package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import dao.ProductDAO;
import java.util.List;
import model.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

static private org.apache.jasper.runtime.ProtectedFunctionMapper _jspx_fnmap_0;

static {
  _jspx_fnmap_0= org.apache.jasper.runtime.ProtectedFunctionMapper.getMapForFunction("fn:length", org.apache.taglibs.standard.functions.Functions.class, "length", new Class[] {java.lang.Object.class});
}

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write(" \n");
      out.write("\n");
      out.write("<!DOCTYPE HTML>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\n");
      out.write("        <title>Xưởng Mộc Cao Cấp Nguyễn Văn Quý - Bình Tân - TP.HCM</title>\n");
      out.write("        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n");
      out.write("        <script type=\"application/x-javascript\"> addEventListener(\"load\", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>\n");
      out.write("        <link href=\"css/bootstrap.css\" rel='stylesheet' type='text/css' />\n");
      out.write("        <script src=\"js/simpleCart.min.js\"></script>\n");
      out.write("        <script src=\"js/jquery.min.js\"></script>\n");
      out.write("        <link href=\"css/style.css\" rel='stylesheet' type='text/css' />\n");
      out.write("        <script src=\"js/jquery.easydropdown.js\"></script>\n");
      out.write("        <script src=\"js/jquery.magnific-popup.js\" type=\"text/javascript\"></script>\n");
      out.write("        <link href=\"css/magnific-popup.css\" rel=\"stylesheet\" type=\"text/css\">\n");
      out.write("\n");
      out.write("        <script>\n");
      out.write("            $(document).ready(function () {\n");
      out.write("                $('.popup-with-zoom-anim').magnificPopup({\n");
      out.write("                    type: 'inline',\n");
      out.write("                    fixedContentPos: false,\n");
      out.write("                    fixedBgPos: true,\n");
      out.write("                    overflowY: 'auto',\n");
      out.write("                    closeBtnInside: true,\n");
      out.write("                    preloader: false,\n");
      out.write("                    midClick: true,\n");
      out.write("                    removalDelay: 300,\n");
      out.write("                    mainClass: 'my-mfp-zoom-in'\n");
      out.write("                });\n");
      out.write("            });\n");
      out.write("        </script>\n");
      out.write("    </head>\n");
      out.write("\n");
      out.write("    <body>\n");
      out.write("        ");

            request.setCharacterEncoding("UTF-8");
            response.setCharacterEncoding("UTF-8");
        
      out.write("\n");
      out.write("\n");
      out.write("        \n");
      out.write("        \n");
      out.write("        \n");
      out.write("        <div class=\"header\">\t\n");
      out.write("            <div class=\"container\"> \n");
      out.write("                <div class=\"header-top\">\n");
      out.write("                    <div class=\"logo\">\n");
      out.write("                        <a href=\"index.jsp\"><h6>Xưởng Mộc</h6><h2>Nguyễn Văn Quý</h2></a>\n");
      out.write("                    </div>\n");
      out.write("                    <!--                    <div class=\"header_right\">\n");
      out.write("                                            <ul class=\"social\">\n");
      out.write("                                                <li><a href=\"#\"> <i class=\"fb\"> </i> </a></li>\n");
      out.write("                                                <li><a href=\"#\"><i class=\"tw\"> </i> </a></li>\n");
      out.write("                                                <li><a href=\"#\"><i class=\"utube\"> </i> </a></li>\n");
      out.write("                                                <li><a href=\"#\"><i class=\"pin\"> </i> </a></li>\n");
      out.write("                                                <li><a href=\"#\"><i class=\"instagram\"> </i> </a></li>\n");
      out.write("                                            </ul>\n");
      out.write("                                            <div class=\"lang_list\">\n");
      out.write("                                                <select tabindex=\"4\" class=\"dropdown\">\n");
      out.write("                                                    <option value=\"\" class=\"label\" value=\"\">VI</option>\n");
      out.write("                                                    <option value=\"1\">VI</option>\n");
      out.write("                                                    <option value=\"2\">EN</option>\n");
      out.write("                                                </select>\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"clearfix\"></div>\n");
      out.write("                                        </div>-->\n");
      out.write("                    <div class=\"clearfix\"></div>\n");
      out.write("                </div>  \n");
      out.write("                <div class=\"banner_wrap\">\n");
      out.write("                    <div class=\"bannertop_box\">\n");
      out.write("                        <ul class=\"login\">\n");
      out.write("                            ");

                                HttpSession s = request.getSession();
                                User user_t = (User) s.getAttribute("user");
                                if (user_t == null) {
                                    out.println("<li class=\"login_text\"><a href=\"../WebProj/User/login.jsp\">Đăng Nhập</a></li>");
                                    out.println("<li class=\"wish\"><a href=\"../WebProj/Product/wishlist.jsp\">D.S Mong Muốn</a></li>");
                                } else {
                                    out.println("<li class=\"login_text\"><a href=\"../WebProj/User/profile.jsp\">Xem profile</a></li>");
                                    if (user_t.getIsManager() == 1) {
                                        out.println("<li class=\"wish\"><a href=\"../WebProj/Product/storemanage.jsp\">Quản Lý Xưởng</a></li>");
                                    } else {
                                        out.println("<li class=\"wish\"><a href=\"../WebProj/Product/wishlist.jsp\">D.S Mong Muốn</a></li>");
                                    }
                                    out.println("<li class=\"logout\"><a href=\"controller.UserServlet?action=logout\">Đăng Xuất</a></li>");
                                }
                            
      out.write("\n");
      out.write("                            <div class='clearfix'></div>\n");
      out.write("                        </ul>\n");
      out.write("                        <div class=\"cart_bg\">\n");
      out.write("                            <ul class=\"cart\">\n");
      out.write("                                <a href=\"Transaction/checkout.jsp\">\n");
      out.write("                                    <h4><i class=\"cart_icon\"> </i><p>Giỏ hàng:  ");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.evaluateExpression("${fn:length(cart)}", java.lang.String.class, (PageContext)_jspx_page_context, _jspx_fnmap_0));
      out.write(" sản phẩm</p><div class=\"clearfix\"> </div></h4>\n");
      out.write("                                </a>\n");
      out.write("                            </ul>\n");
      out.write("                        </div>\n");
      out.write("                        <ul class=\"quick_access\">\n");
      out.write("                            <li class=\"view_cart\"><a href=\"Transaction/shoppingcart.jsp\">Xem giỏ hàng</a></li>\n");
      out.write("                            <li class=\"check\"><a href=\"Transaction/checkout.jsp\">Thanh toán</a></li>\n");
      out.write("                            <div class='clearfix'></div>\n");
      out.write("                        </ul>\n");
      out.write("                        <div class=\"search\">\n");
      out.write("                            <form method=\"post\" action=\"Product/search.jsp\">\n");
      out.write("                                <input type=\"text\" value=\"Tìm kiếm\" name=\"searchkeyword\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {\n");
      out.write("                                            this.value = 'Tìm kiếm';\n");
      out.write("                                        }\">\n");
      out.write("                                <input type=\"submit\" value=\"\">\n");
      out.write("                                <br><br>\n");
      out.write("\n");
      out.write("                                <!--                            <form method=\"post\" action=\"Product/search.jsp\">-->\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"login-right\">\n");
      out.write("                            <form method=\"post\" action=\"Product/search.jsp\">\n");
      out.write("                                <label style=\"background-color: white; padding-right: 35px\">\n");
      out.write("                                    Chọn sản phẩm theo mức giá\n");
      out.write("                                </label>\n");
      out.write("                                <select name=\"price\">\n");
      out.write("                                    <option>1.000.000 - 3.000.000</option>\n");
      out.write("                                    <option>3.000.000 - 5.000.000</option>\n");
      out.write("                                    <option>5.000.000 - 8.000.000</option>\n");
      out.write("                                    <option>Hơn 8.000.000</option>\n");
      out.write("                                </select>\n");
      out.write("\n");
      out.write("                                <input type=\"submit\" value=\"Tìm\">\n");
      out.write("                                <br><br>\n");
      out.write("                            </form>\n");
      out.write("                        </div>\n");
      out.write("                        <div class=\"welcome_box\">\n");
      out.write("                            ");
 if (user_t == null) {
      out.write("\n");
      out.write("                            <h3>Chào bạn,</h3>\n");
      out.write("                            ");
} else {
      out.write("\n");
      out.write("                            <h3>Chào ");
      out.print(user_t.getFirst_name());
      out.write(",</h3>\n");
      out.write("                            ");
}
      out.write("\n");
      out.write("                            <p>Chúc bạn có những khoảng thời gian mua sắm vui vẻ và tìm được những sản phẩm mà bạn mong muốn</p>\n");
      out.write("                        </div>\n");
      out.write("                    </div>\n");
      out.write("                    <div class=\"banner_right\">\n");
      out.write("                        <p style=\"font-size: 1.1em;\"><i>Chúng tôi chuyên sản xuất các sản phẩm nội thất đồ gỗ cho gia đình, khách sạn, trường học và văn phòng...</i></p>\n");
      out.write("                        <p style=\"font-size: 1.4em;\"><b>Hotline: 0938 200 871<b></p>\n");
      out.write("                                    <a href=\"Product/viewCate.jsp?cid=liv\" class=\"banner_btn\">MUA NGAY</a>\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class='clearfix'></div>\n");
      out.write("                                    </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"main\">\n");
      out.write("                                        <div class=\"content_box\">\n");
      out.write("                                            <div class=\"container\">\n");
      out.write("                                                <div class=\"row\">\n");
      out.write("                                                    <div class=\"col-md-3\">\n");
      out.write("                                                        <div class=\"menu_box\">\n");
      out.write("                                                            <a href=\"#\"><h3 class=\"menu_head\" style=\"font-size: 18px\" id=\"menubtn\"><img src=\"icons/menu.png\"><b>&nbsp;&nbsp;DANH MỤC</b></h3></a>\n");
      out.write("                                                            <ul class=\"nav\" id=\"menu\">\n");
      out.write("                                                                <li><a href=\"StoreInfor/about.jsp\"><img src=\"icons/user.png\"><b>&nbsp;&nbsp;GIỚI THIỆU VỀ CHÚNG TÔI</b></a></li>\n");
      out.write("                                                                        ");
if (user_t != null && user_t.getIsManager() == 0) {
      out.write("\n");
      out.write("                                                                <li><a href=\"Product/compare.jsp\"><img src=\"icons/compare.png\"><b>&nbsp;&nbsp;BẤM ĐỂ SO SÁNH NGAY</b></a></li>\n");
      out.write("                                                                        ");
}
      out.write("\n");
      out.write("                                                                <li><a href=\"Product/viewCate.jsp?cid=liv\"><img src=\"icons/living.png\"><b>&nbsp;&nbsp;PHÒNG KHÁCH</b></a></li>\n");
      out.write("                                                                <li><a href=\"Product/viewCate.jsp?cid=bed\"><img src=\"icons/bed.png\"><b>&nbsp;&nbsp;PHÒNG NGỦ</b></a></li>\n");
      out.write("                                                                <li><a href=\"Product/viewCate.jsp?cid=kit\"><img src=\"icons/dining.png\"><b>&nbsp;&nbsp;NHÀ BẾP</b></a></li>\n");
      out.write("                                                                <li><a href=\"Product/viewCate.jsp?cid=off\"><img src=\"icons/work.png\"><b>&nbsp;&nbsp;VĂN PHÒNG</b></a></li>\n");
      out.write("                                                                <li><a href=\"Product/viewCate.jsp?cid=acc\"><img src=\"icons/shelf.png\"><b>&nbsp;&nbsp;PHỤ KIỆN</b></a></li>\n");
      out.write("                                                                <li><a href=\"StoreInfor/contact.jsp\"><img src=\"icons/contact.png\"><b>&nbsp;&nbsp;LIÊN HỆ</b></a></li>\n");
      out.write("                                                            </ul>\n");
      out.write("                                                        </div>\n");
      out.write("\n");
      out.write("                                                        <script type=\"text/javascript\">\n");
      out.write("                                                            $('#menubtn').click(function (e) {\n");
      out.write("                                                                if ($('#menu').is(\":visible\")) {\n");
      out.write("                                                                    $('#menu').hide(\"slow\");\n");
      out.write("                                                                } else {\n");
      out.write("                                                                    $('#menu').show(\"slow\");\n");
      out.write("                                                                }\n");
      out.write("                                                                e.preventDefault();\n");
      out.write("                                                            });\n");
      out.write("                                                        </script>\n");
      out.write("\n");
      out.write("                                                        <div class=\"tags\">\n");
      out.write("                                                            <h4 class=\"tag_head\">Thẻ Tìm Kiếm Nhanh</h4>\n");
      out.write("                                                            <ul class=\"tags_links\">\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Tủ Bếp\">Tủ Bếp</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Bàn Làm Việc\">Bàn Làm Việc</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Giường Ngủ\">Giường Ngủ</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Ghế Gỗ\">Ghế Gỗ</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Tủ Tivi\">Tủ Tivi</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Khung Gương\">Khung Gương</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Sang Trọng\">Sang Trọng</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Cao Cấp\">Cao Cấp</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Hiện đại\">Hiện Đại</a></li>\n");
      out.write("                                                                <li><a href=\"Product/search.jsp?searchkeyword=Cổ điển\">Cổ Điển</a></li>\n");
      out.write("                                                            </ul>\n");
      out.write("                                                        </div>\n");
      out.write("                                                    </div>\n");
      out.write("                                                    <div class=\"col-md-9\">\n");
      out.write("                                                        <h3 class=\"m_1\">Sản phẩm mới</h3>\n");
      out.write("                                                        ");

                                                            ProductDAO pd = new ProductDAO();
                                                            List<Product> productList = pd.getAllProduct();

                                                            for (int i = 0; i < productList.size(); i++) {
                                                                String url = "Product/view.jsp?pid=" + productList.get(i).getPid();
                                                                if (i % 3 == 0) {
                                                                    out.println("<div class=\"content_grid\">");
                                                                }

                                                                if (i % 3 != 2 && i != productList.size() - 1) {
                                                                    out.println(
                                                                            "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem\">\n"
                                                                            + "<a href=\"Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                            + "<div class=\"inner_content clearfix\">\n"
                                                                            + "<div class=\"product_image\">\n"
                                                                            + "<img src=\"" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
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
                                                                            + "</div>\n");
                                                                }

                                                                if (i % 3 == 2 || i == productList.size() - 1) {
                                                                    out.println(
                                                                            "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem last_1\">\n"
                                                                            + "<a href=\"Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                            + "<div class=\"inner_content clearfix\">\n"
                                                                            + "<div class=\"product_image\">\n"
                                                                            + "<img src=\"" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
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
                                                        
      out.write("\n");
      out.write("\n");
      out.write("                                                        <h3 class=\"m_2\">Sản Phẩm Đang Giảm Giá</h3>\n");
      out.write("                                                        ");

                                                            productList = pd.getAllDiscountProduct();

                                                            for (int i = 0; i < productList.size(); i++) {
                                                                String url = "Product/view.jsp?pid=" + productList.get(i).getPid();
                                                                if (i % 3 == 0) {
                                                                    out.println("<div class=\"content_grid\">");
                                                                }

                                                                if (i % 3 != 2 && i != productList.size() - 1) {
                                                                    out.println(
                                                                            "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem\">\n"
                                                                            + "<a href=\"Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                            + "<div class=\"inner_content clearfix\">\n"
                                                                            + "<div class=\"product_image\">\n"
                                                                            + "<img src=\"" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
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
                                                                            + "</div>\n");
                                                                }

                                                                if (i % 3 == 2 || i == productList.size() - 1) {
                                                                    out.println(
                                                                            "<div class=\"col_1_of_3 span_1_of_3 simpleCart_shelfItem last_1\">\n"
                                                                            + "<a href=\"Product/view.jsp?pid=" + productList.get(i).getPid() + "\">\n"
                                                                            + "<div class=\"inner_content clearfix\">\n"
                                                                            + "<div class=\"product_image\">\n"
                                                                            + "<img src=\"" + productList.get(i).getP_img() + "1.jpg" + "\" class=\"img-responsive\" alt=\"\"/>\n"
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
                                                        
      out.write("\n");
      out.write("                                                    </div>\n");
      out.write("                                                </div>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("\n");
      out.write("                                        <div class=\"container\">\n");
      out.write("                                            <div class=\"instagram_top\">\n");
      out.write("                                                <div class=\"instagram text-center\">\n");
      out.write("                                                    <h3>Kết Nối Với Chúng Tôi</h3>\n");
      out.write("                                                </div>\n");
      out.write("                                                <ul class=\"footer_social\">\n");
      out.write("                                                    <li><a href=\"#\"><i class=\"tw\"> </i> </a></li>\n");
      out.write("                                                    <li><a href=\"#\"> <i class=\"fb\"> </i> </a></li>\t\t\t\n");
      out.write("                                                    <li><a href=\"#\"><i class=\"pin\"> </i> </a></li>\n");
      out.write("                                                    <div class=\"clearfix\"></div>\n");
      out.write("                                                </ul>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"footer\">\n");
      out.write("                                        <div class=\"container\">\n");
      out.write("                                            <div class=\"footer-grid\">\n");
      out.write("                                                <h3>Thông Tin Liên Hệ</h3>\n");
      out.write("                                                <p class=\"footer_desc\">\n");
      out.write("                                                    <b><u>Cơ Sở 1</u><br/></b>\n");
      out.write("                                                    Địa chỉ: 449/22 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>\n");
      out.write("                                                    ĐT: 0938 200 871\n");
      out.write("                                                </p>\n");
      out.write("                                                <p class=\"footer_desc\">\n");
      out.write("                                                    <b><u>Cơ Sở 2</u><br/></b>\n");
      out.write("                                                    Địa chỉ: 449/38/6 đường Hương Lộ 2, phường Bình Trị Đông, quận Bình Tân, TP.HCM<br/>\t\t\t\t\t\n");
      out.write("                                                    ĐT: (08) 5407 0556\n");
      out.write("                                                </p>\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"footer-grid\">\n");
      out.write("                                                <h3>Danh Mục</h3>\n");
      out.write("                                                <ul class=\"list1\">\n");
      out.write("                                                    <li><a href=\"index.jsp\">Trang chủ</a></li>\n");
      out.write("                                                    <li><a href=\"StoreInfor/about.jsp\">Giới Thiệu Về Chúng Tôi</a></li>\n");
      out.write("                                                    <li><a href=\"Product/viewCate.jsp?cid=liv\">Nội Thất Phòng Khách</a></li>\n");
      out.write("                                                    <li><a href=\"Product/viewCate.jsp?cid=bed\">Nội Thất Phòng Ngủ</a></li>\n");
      out.write("                                                    <li><a href=\"Product/viewCate.jsp?cid=kit\">Nội Thất Nhà Bếp</a></li>\n");
      out.write("                                                    <li><a href=\"Product/viewCate.jsp?cid=off\">Nội Thất Văn Phòng</a></li>\n");
      out.write("                                                    <li><a href=\"Product/viewCate.jsp?cid=acc\">Phụ Kiện Trang Trí</a></li>\n");
      out.write("                                                    <li><a href=\"StoreInfor/contact.jsp\">Liên Hệ Với Chúng Tôi</a></li>\n");
      out.write("                                                </ul>\n");
      out.write("                                            </div>\n");
      out.write("\n");
      out.write("                                            <div class=\"footer-grid\">\n");
      out.write("                                                <h3>Đăng Ký Nhận Tin</h3>\n");
      out.write("                                                <p class=\"footer_desc\">Chúng tôi sẽ cập nhật thông tin sản phẩm mới nhất và các chương trình khuyến mãi nhanh chóng và kịp thời đến bạn</p>\n");
      out.write("                                                <div class=\"search_footer\">\n");
      out.write("                                                    <form method=\"post\" action=\"../WebProj/SubscriberServlet?action=add\">\n");
      out.write("                                                        <input type=\"text\" class=\"text\" value=\"Email\" name=\"email\" onfocus=\"this.value = '';\" onblur=\"if (this.value == '') {\n");
      out.write("                                                                    this.value = 'Email';\n");
      out.write("                                                                }\">\n");
      out.write("                                                        <input type=\"submit\" value=\"Đăng Ký\">\n");
      out.write("                                                    </form>\n");
      out.write("                                                </div>\n");
      out.write("                                                <img src=\"images/payment.png\" class=\"img-responsive\" alt=\"\"/>\n");
      out.write("                                            </div>\n");
      out.write("                                            <div class=\"clearfix\"> </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    <div class=\"footer_bottom\">\n");
      out.write("                                        <div class=\"container\">\n");
      out.write("                                            <div class=\"copy\">\n");
      out.write("                                                <p>Chủ cơ sở : NGUYỄN VĂN QUÝ<br/>Copyright &copy; 2015 Xưởng Mộc Cao Cấp Nguyễn Văn Quý. Phát triển bởi <a href=\"#\" target=\"_blank\">HKT Software Solution</a> </p>\n");
      out.write("                                            </div>\n");
      out.write("                                        </div>\n");
      out.write("                                    </div>\n");
      out.write("                                    </body>\n");
      out.write("                                    </html>\t\t");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
