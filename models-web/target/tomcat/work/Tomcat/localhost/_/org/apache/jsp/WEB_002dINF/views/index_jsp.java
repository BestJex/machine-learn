/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/7.0.47
 * Generated at: 2017-12-22 06:19:27 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp.WEB_002dINF.views;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class index_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private javax.el.ExpressionFactory _el_expressionfactory;
  private org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
    _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");

    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"+ request.getServerName() + ":" + request.getServerPort()+ path ;
    request.setAttribute("ctx",basePath);

      out.write("\r\n");
      out.write("<!doctype html>\r\n");
      out.write("<html lang=\"en\">\r\n");
      out.write("<head>\r\n");
      out.write("    <link rel=\"icon\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/favicon.ico\" type=\"image/x-icon\">\r\n");
      out.write("    <meta charset=\"UTF-8\">\r\n");
      out.write("    <meta http-equiv=\"X-UA-Compatible\" content=\"ie=edge\">\r\n");
      out.write("    <title>机器学习</title>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/css/swiper.min.css\">\r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/js/swiper.min.js\"></script>\r\n");
      out.write("    <link rel=\"stylesheet\" href=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/css/style.css\">\r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/js/main.js\"></script>\r\n");
      out.write("    <script src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/js/jquery-1.7.1.min.js\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("    function toFunctionPage(index,url){\r\n");
      out.write("        if(null != url && \"\" != url){\r\n");
      out.write("            window.location.href = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("\"+url + \"?menuIndex=\"+index;\r\n");
      out.write("        }\r\n");
      out.write("    }\r\n");
      out.write("</script>\r\n");
      out.write("<body>\r\n");
      out.write("<img id=\"website-bgImg\" class=\"website-bg website-bg-show\" src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/bg.jpg\" alt=\"星空万象\">\r\n");
      out.write("<!-- //website-bg -->\r\n");
      out.write("<div class=\"j-container\">\r\n");
      out.write("    <div class=\"header\" id=\"header\">\r\n");
      out.write("        ");
      out.write("\r\n");
      out.write("        ");
      org.apache.jasper.runtime.JspRuntimeLibrary.include(request, response, "commons/topHead.jsp", out, false);
      out.write("\r\n");
      out.write("        ");
      out.write("\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- //header -->\r\n");
      out.write("    <div class=\"content index-two\">\r\n");
      out.write("        <div class=\"swiper-container swiper-container1\" id=\"swiper-container1\">\r\n");
      out.write("            <div class=\"swiper-wrapper\">\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide1\" data-history=\"slide1\">\r\n");
      out.write("                    <div class=\"demo\" style=\"cursor: pointer\" onclick=\"toFunctionPage('开发者','')\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/in_bg4.png\" alt=\"\">\r\n");
      out.write("                        <div class=\"pop\">\r\n");
      out.write("                            <span>开发者</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide2\" data-history=\"slide2\">\r\n");
      out.write("                    <div class=\"demo\" style=\"cursor: pointer\" onclick=\"toFunctionPage('0','/modelsDataFile/importDataFile')\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/in_bg1.png\" alt=\"\">\r\n");
      out.write("                        <div class=\"pop\">\r\n");
      out.write("                            <span>数据<br>文件</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide3\" data-history=\"slide3\">\r\n");
      out.write("                    <div class=\"demo\" style=\"cursor: pointer\" onclick=\"toFunctionPage('2','/program/toAddProgramPage')\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/in_bg2.png\" alt=\"\">\r\n");
      out.write("                        <div class=\"pop\">\r\n");
      out.write("                            <span>实验室</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide4\" data-history=\"slide4\">\r\n");
      out.write("                    <div class=\"demo\" style=\"cursor: pointer\" onclick=\"toFunctionPage('4','/modelsLibrary/toModelsListPage')\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/in_bg3.png\" alt=\"\">\r\n");
      out.write("                        <div class=\"pop\">\r\n");
      out.write("                            <span>模型库</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide5\" data-history=\"slide5\">\r\n");
      out.write("                    <div class=\"demo\" style=\"cursor: pointer\" onclick=\"toFunctionPage('5','/user/toUserManagerPage')\">\r\n");
      out.write("                        <img src=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ctx}", java.lang.String.class, (javax.servlet.jsp.PageContext)_jspx_page_context, null, false));
      out.write("/resources/img/in_bg5.png\" alt=\"\">\r\n");
      out.write("                        <div class=\"pop\">\r\n");
      out.write("                            <span>个人<br>中心</span>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("        <div class=\"swiper-container swiper-container2\" id=\"swiper-container2\">\r\n");
      out.write("            <div class=\"swiper-wrapper\">\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide1\" data-history=\"slide1\">\r\n");
      out.write("                    <div class=\"demo\">\r\n");
      out.write("                        <div><span>|</span>开发者</div>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            技术文档\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide2\" data-history=\"slide2\">\r\n");
      out.write("                    <div class=\"demo\">\r\n");
      out.write("                        <div><span>|</span>数据文件</div>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            数据导入、统计、变量分析\r\n");
      out.write("                            <br>\r\n");
      out.write("                            1、数据导入:系统支持CSV、TXT两种格式文件导入,可解析GBK、UTF-8两种编码类型，用户自定\r\n");
      out.write("                            义分隔符、缺失值、样本唯一索引、目标变量等。\r\n");
      out.write("                            <br>\r\n");
      out.write("                            2、变量分析:数据导入成功后，支持数据预览、变量类型识别及调整、变量分析等功能，分析维度\r\n");
      out.write("                            包括IV值、变量关联性、离散性和连续变量的分类统计等，并支持结果下载。\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide3\" data-history=\"slide3\">\r\n");
      out.write("                    <div class=\"demo\">\r\n");
      out.write("                        <div><span>|</span>实验室</div>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            建模项目的创建、配置、模型训练及结果展示\r\n");
      out.write("                            <br>\r\n");
      out.write("                            1、创建项目:选择需要建模的数据文件，并标记样本唯一索引、目标变量，选择要执行的算法，并进行模式配\r\n");
      out.write("                            置(演示、快速、精准、高可靠)\r\n");
      out.write("                            <br>\r\n");
      out.write("                            2、模型报告:项目执行完成后，可查询模型报告，包括数据概览、模型评价指标、ROC/KS曲线(训练\r\n");
      out.write("                            集合测试集)、SCORE分组详情/概率分箱图(训练集和测试集)、TOP20变量IV值、变量重要性排序等\r\n");
      out.write("                            <br>\r\n");
      out.write("                            3、用户可下载详细模型报告，也可将模型提取至模型库\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide4\" data-history=\"slide4\">\r\n");
      out.write("                    <div class=\"demo\">\r\n");
      out.write("                        <div><span>|</span>模型库</div>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            模型的预测及对比\r\n");
      out.write("                            <br>\r\n");
      out.write("                            1、模型对比:提供两两模型间的数据集基本信息、模型评价指标、预测概率、重要变量对比等。\r\n");
      out.write("                            <br>\r\n");
      out.write("                            2、模型预测：提供有监督测试和无监督测试两种，页面展示预测结果并支持下载\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"swiper-slide swiper-slide5\" data-history=\"slide5\">\r\n");
      out.write("                    <div class=\"demo\">\r\n");
      out.write("                        <div><span>|</span>个人中心</div>\r\n");
      out.write("                        <p>\r\n");
      out.write("                            用户、角色管理\r\n");
      out.write("                        </p>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("    </div>\r\n");
      out.write("    <!-- //content -->\r\n");
      out.write("</div>\r\n");
      out.write("<!-- j-container -->\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<script language=\"javascript\">\r\n");
      out.write("    var Swiper1 = new Swiper('#swiper-container1',{\r\n");
      out.write("        mousewheel: true,\r\n");
      out.write("        initialSlide :2,\r\n");
      out.write("        slideToClickedSlide:true,\r\n");
      out.write("        effect : 'coverflow',\r\n");
      out.write("        slidesPerView: 4,\r\n");
      out.write("        centeredSlides: true,\r\n");
      out.write("        coverflowEffect: {\r\n");
      out.write("            rotate: 0,\r\n");
      out.write("            depth: 100,\r\n");
      out.write("            stretch: 0,\r\n");
      out.write("            modifier: 2,\r\n");
      out.write("            slideShadows : false\r\n");
      out.write("        },\r\n");
      out.write("    });\r\n");
      out.write("    var Swiper2 = new Swiper('#swiper-container2',{\r\n");
      out.write("        initialSlide :2,\r\n");
      out.write("        mousewheel: true,\r\n");
      out.write("        effect : 'cube',\r\n");
      out.write("    })\r\n");
      out.write("    Swiper1.controller.control = Swiper2;//Swiper1控制Swiper2，需要在Swiper2初始化后\r\n");
      out.write("    Swiper2.controller.control = Swiper1;//Swiper2控制Swiper1，需要在Swiper1初始化后\r\n");
      out.write("</script>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try { out.clearBuffer(); } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
