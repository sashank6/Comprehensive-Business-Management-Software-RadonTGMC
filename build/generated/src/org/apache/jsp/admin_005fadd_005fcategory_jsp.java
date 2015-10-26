package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.IOException;

public final class admin_005fadd_005fcategory_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

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
      out.write("\n");
      out.write("\n");
      out.write(" \n");
      out.write("    ");

    HttpSession ses=request.getSession();
    long userid;
    try
    {
    userid=Long.parseLong((String)ses.getAttribute("userid"));
    if(userid!=666)
    throw new  IOException("Invalid User");
    }
    catch(Exception e)
    {
    response.sendRedirect("home.jsp");
    }
    
    
     
      out.write("\n");
      out.write("   \n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("    <head>\n");
      out.write("        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n");
      out.write("        <title>Add Category</title>\n");
      out.write("        <link rel=\"stylesheet\" type=\"text/css\" href=\"style.css\"/>\n");
      out.write("    </head>\n");
      out.write("    <body>\n");
      out.write("            <h1>\n");
      out.write("        <a href=\"admin_home.jsp\" style=\"color:white\">Project Radon</a>\n");
      out.write("        <a href=\"logout.jsp\" style=\"float:right; color:white; font-size:16px; \">Log out</a>\n");
      out.write("    </h1>\n");
      out.write("    \n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<ul>\n");
      out.write("    <li><a>Retailers</a>\n");
      out.write("        <ul>\n");
      out.write("            <li><a href=\"admin_view_retailer_list.jsp\">View Retailers</a></li>\n");
      out.write("            <li><a href=\"admin_view_retailer_pending.jsp\">Pending Orders</a></li>\n");
      out.write("            <li><a href=\"retailer_order_status.jsp\">Order Status</a></li>\n");
      out.write("                \n");
      out.write("        </ul>\n");
      out.write("    \n");
      out.write("    </li>\n");
      out.write("    <li><a>Vendors</a>\n");
      out.write("    <ul>\n");
      out.write("        <li><a href=\"admin_view_vendor_list.jsp\">View Vendors</a></li>\n");
      out.write("        <li><a href=\"admin_raise_po.jsp\">Raise Purchase Order</a></li>\n");
      out.write("        <li><a href=\"admin_view_po.jsp\">View Purchase Orders</a></li>\n");
      out.write("        <li><a href=\"admin_approve_pay.jsp\">Approve Payments</a></li>\n");
      out.write("    </ul>\n");
      out.write("        </li>\n");
      out.write("    <li><a>Transactions</a>\n");
      out.write("    <ul>\n");
      out.write("        <li><a href=\"admin_view_cash_position.jsp\">View Cash Position</a></li>\n");
      out.write("        <li><a href=\"admin_view_account_statement.jsp\">View Account Statement</a></li>\n");
      out.write("        <li><a href=\"add_cash_transaction.jsp\">Add Cash Transaction</a></li>\n");
      out.write("    </ul>\n");
      out.write("        </li>\n");
      out.write("    <li><a>Inventory</a>\n");
      out.write("    <ul>\n");
      out.write("        <li><a href=\"admin_view_res_inv.jsp\">View reserve Inventory</a></li>\n");
      out.write("        <li><a href=\"admin_view_act_inv.jsp\">View Active Inventory</a></li>\n");
      out.write("        <li><a href=\"admin_add_quantity.jsp\">Add Quantity</a></li>\n");
      out.write("    </ul></li>\n");
      out.write("    <li><a>Products</a>\n");
      out.write("    <ul>\n");
      out.write("        <li><a href=\"admin_view_cat.jsp\">View Category</a></li>\n");
      out.write("        <li><a href=\"admin_add_category.jsp\">Add Category</a></li>\n");
      out.write("        <li><a href=\"admin_add_product_sale.jsp\">Add New Product</a></li>\n");
      out.write("    </ul>\n");
      out.write("        </li>\n");
      out.write("        <li><a>Messages</a>\n");
      out.write("            <ul>\n");
      out.write("                <li><a href=\"admin_view_message.jsp\">View Messages</a></li>\n");
      out.write("                <li><a href=\"admin_send_message.jsp\">Send Message</a></li>\n");
      out.write("            </ul></li>\n");
      out.write("</ul>\n");
      out.write("<br/>\n");
      out.write("<br/>\n");
      out.write("        <form action=\"admin_add_cat\" method=\"POST\">\n");
      out.write("            <table border=\"1\">\n");
      out.write("                <tr>\n");
      out.write("                    <td>Parent Category</td>\n");
      out.write("                    <td><input type=\"text\" name=\"parcat\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td>Child Category</td>\n");
      out.write("                    <td><input type=\"text\" name=\"chicat\"/></td>\n");
      out.write("                </tr>\n");
      out.write("                <tr>\n");
      out.write("                    <td colspan=\"2\"><input type=\"submit\" value=\"Add Category\"/></td>\n");
      out.write("                </tr>\n");
      out.write("            </table>\n");
      out.write("        </form>\n");
      out.write("    </body>\n");
      out.write("</html>\n");
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
