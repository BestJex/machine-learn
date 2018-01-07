<%--
  Created by IntelliJ IDEA.
  User: zhaotm
  Date: 2017/11/21
  Time: 11:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>实验室-创建项目 </title>
    <link type="text/css" href="${ctx}/resources/css/style.css" rel="stylesheet" />
    <style type="text/css">
        .form-item-err {
            display: none;
        }
        .d-input {
            border: none;
            outline: none;
        }
        .create-project .di {
            width: 230px;
            color: #4fa0ef;
        }
        .di {
            padding: 0 25px 0 15px;
            height: 34px;
            font-size: 14px;
            line-height: 34px;
            background-color: rgba(6, 34, 71,0.5);
            border: 1px solid rgb(55, 91, 148);
            border-radius: 4px;
            cursor: pointer;
        }
        .j-select-options-i {
            /*background-color: white;*/
            position: absolute;
            top: 50px;
            left: 0;
            z-index: 999;
            display: none;
            width: 100%;
            max-height: 150px;
            overflow-y: auto;
        }
        .j-select-options-i ul{
            background-color: rgba(6,34,71,0.7);
            color: #4fa0ef;
        }
        .j-select-options-i li:hover {
            background-color: #104983;
        }
        .j-select-options-i li {
            display: block;
            padding: 8px 20px 8px 13px;
            font-size: 14px;
            line-height: 14px;
            cursor: pointer;
        }
    </style>
    <script type="text/javascript" src="${ctx}/resources/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/myValidate.js"></script>
    <script type="text/javascript">
        $(function () {

            //新增和修改
            if ("" == $("#programId").val()) {
                $("#programId").val(-1);
                $("#pName").text("创建项目")
            } else {
                selectDataFile();
                showAi();
            }

            //算法回显示
            function showAi() {
                var spanHtml = "";
                var arithmeticNames = "${program.arithmeticNames}";
                var arithmeticNameArr = arithmeticNames.split(",");

                $.each(arithmeticNameArr, function (i, value) {
                    spanHtml += '<span class="algorithm-queue-item"><b></b><i></i><em>'+value+'</em></span>';
                    $(".algorithm").each(function () {
                        if ($(this).text() == value) {
                            $(this).addClass("selected");
                            return false;
                        }
                    });
                });
                $("#algorithm_queue").html(spanHtml);
            }

            //下拉回显示
            $("#file").text($("#dataFileName").val());

            //输入框搜索
            $(document).on("click", ".di", function (e) {
                var _this = $(this);
                var arrow = _this.siblings('.j-select-arrow');
                var menuDiv = _this.parents('.j-select').find('.j-select-options-i');

                arrow.toggleClass('active');
                menuDiv.slideToggle();
                $(document).one('click',function(){
                    arrow.removeClass('active');
                    $(".j-select-options-i").slideUp();
                });

                e.stopPropagation();
            });

            //li选中
            $(document).on('click','.j-select-options-i li',function(){
                var inputArr =  $(this).parents(".j-select").find(".di input");

                inputArr.eq(0).val($(this).attr("data-id"));
                inputArr.eq(1).val($(this).text());
            });

            //单选
            $(document).on('click', '.j-check i', function () {
                $(".j-check i").removeClass("checked");
                $(this).addClass("checked");
                $(this).parent().parent().find("input").val($(this).attr("data-id"));
            });
        });


        var infoList = [];
        function selectDataFile(obj) {
            if (obj) {
                $("#dataFileId").val($(obj).attr("data-id"));
                $("#dataFileName").val($(obj).text());
            }

            $.ajax({
                url:"${ctx}/program/dataFileInfoList",
                type:"POST",
                dataType:"json",
                data: {"fileId": $("#dataFileId").val()},
                success:function (data) {
                    if (200 == data.code) {
                        infoList = data.data;
                    } else {
                        jAlert("数据标记加载失败");
                    }
                }
            });
        }

        function matchName(obj) {
            var liHtml = "";

            $.each(infoList, function () {
                if ("" == obj.value) {
                    liHtml += "<li data-id='"+this.id+"'>"+this.name+"</li>";
                } else if (this.name.indexOf(obj.value) >= 0) {
                    liHtml += "<li data-id='"+this.id+"'>"+this.name+"</li>";
                }
            });
            if ("" == liHtml) {
                liHtml += "<li data-id=''></li>"
            }

            $(obj).parent().next().find("ul").html(liHtml);
        }

        //保存或者提交
        var submitFlag = false;
        function save(status) {
            if (true == submitFlag) {return;}
            submitFlag = true;
            //算法赋值
            var aIdArr = new Array();
            var aNameArr = new Array();
            $(".algorithm-queue-item em").each(function () {
                var name = $(this).text();

                $(".algorithms span").each(function () {
                    if (name == $(this).text()) {
                        aIdArr.push($(this).attr("data-id"));
                        aNameArr.push(name);
                        submitFlag = false;
                        return false;
                    }
                });
            });
            $("#arithmeticIds").val(aIdArr.join(","));
            $("#arithmeticNames").val(aNameArr.join(","));

            //状态赋值
            $("#status").val(status);

            //填充id和rule
            var idArry = new Array();
            var ruleArry = new Array();
            $(".val").each(function () {
                var id = $(this).attr("id");
                if (!id) {
                    id = $(this).attr("name");
                }
                var rule = $(this).attr("data-att");
                if(!rule) {return;}

                if (rule.indexOf(",") > 0) {
                    var ruleS = rule.split(",");
                    var ruleSArr = new Array();

                    for (var i=0; i<ruleS.length; i++) {
                        ruleSArr.push(ruleS[i]);
                    }
                    ruleArry.push(ruleSArr);
                } else {
                    ruleArry.push(rule);
                }
                idArry.push(id);

            });

            var pass = false;

                myValidate(
                {
                    formId: 'frm',
                    items: idArry,
                    rules: ruleArry,
                    errorClass: "form-item-err",
                    success: function () {
                        pass = true;
                    },
                    errorPlacement: function (error, element) {
                        element.parents(".p-p").find("p").show();
                    }
                }
            );
            if(pass){
                $.ajax({
                    url:"${ctx}/program/addOrEditSave",
                    type:"POST",
                    dataType:"json",
                    data: $("#frm").serialize(),
                    success:function (data) {
                        if (200 == data.code) {
                            if (0 == status) {
                                jAlert("保存成功");
                            } else {
                                jAlert("提交成功");
                            }
                            window.location.href = "${ctx}/program/index";
                        } else {
                            submitFlag = false;
                            if(999 == data.msg){
                                jAlert("项目名称已存在，请修改名称后再提交");
                            }else{
                                if (0 == status) {
                                    jAlert("保存失败");
                                } else {
                                    jAlert("提交失败");
                                }
                            }
                        }
                    }
                });
            }else{
                submitFlag = false;
                return;
            }
        }


    </script>
</head>
<body>
<img id="website-bgImg" class="website-bg website-bg-show" src="${ctx}/resources/img/bg.jpg" alt="星空万象">
<!-- //网站背景 -->
<div class="j-container">
    <!--页面头部 start -->
    <%@ include file="../commons/topHead.jsp"%>
    <!--页面头部 end -->

    <!-- center.html start -->
    <div class="content">
        <!--页面左侧导航栏 start -->
        <%@ include file="../commons/leftNavigation.jsp"%>
        <!-- 页面左侧导航栏 end -->

        <!-- 右侧内容.html start -->
        <div class="main">
            <div class="main-header clearfix">
                <div class="page-title">
                    <h3>实验室</h3>
                    <p id="pName">修改项目</p>
                </div>
            </div>
            <!-- //main-header -->

            <div class="create-project">
                <form id="frm">
                    <input type="hidden" name="id" id="programId" value="${program.id}" />
                    <input type="hidden" name="status" id="status" />
                    <div class="module-title">
                        <span class="module-title-icon create-project-step-icon1"></span>
                        <b>项目信息</b>
                    </div>
                    <div class="project-item clearfix">
                        <div class="project-item-left">
                            <span class="j-label fl">项目名称</span>
                            <div class="fl p-p">
                                <input type="text" class="j-input val" name="name" id="name" value="${program.name}"
                                       placeholder="请输入项目名称" maxlength="20" data-att="require" />
                                <p class="form-item-err">请输入项目名称</p>
                            </div>
                        </div>
                        <div class="project-item-right">
                            <span class="j-label project-item-label fl">选择文件</span>
                            <div class="j-select fl p-p">
                                <i class="j-select-arrow"></i>
                                <div class="j-select-placeholder project-item-select" id="file"></div>
                                <input type="hidden" name="dataFileId" id="dataFileId" value="${program.dataFileId}" />
                                <input type="hidden" name="dataFileName" id="dataFileName" class="val" value="${program.dataFileName}" data-att="require" />
                                <div class="j-select-options">
                                    <ul>
                                        <c:forEach items="${fileList}" var="file">
                                            <li data-id="${file.id}" title="${file.name}" onclick="selectDataFile(this);">${file.name}</li>
                                        </c:forEach>
                                        <c:if test="${empty fileList}">
                                            <li data-id=""></li>
                                        </c:if>
                                    </ul>
                                </div>
                                <p class="form-item-err">请选择文件</p>
                            </div>
                        </div>
                    </div>

                    <div class="module-title">
                        <span class="module-title-icon create-project-step-icon2"></span>
                        <b>数据标记</b>
                    </div>
                    <div class="project-item clearfix">
                        <div class="project-item-left">
                            <span class="j-label fl">目标变量列名</span>
                            <div class="fl p-p">
                                <div class="j-select fl">
                                    <i class="j-select-arrow"></i>
                                    <div class="di project-item-select">
                                        <input type="hidden" name="targetId" id="targetId" value="${program.targetId}" />
                                        <input type="text" class="j-input d-input val" name="targetName" id="targetName" value="${program.targetName}"
                                               placeholder="请输入名称搜索标记" maxlength="20" onclick="matchName(this)" onkeyup="matchName(this)" data-att="require" />
                                    </div>
                                    <div class="j-select-options-i">
                                        <ul></ul>
                                    </div>
                                </div>
                                <p class="form-item-err">请输入目标变量列名</p>
                            </div>
                        </div>
                        <div class="project-item-right">
                            <span class="j-label project-item-label fl">样本索引列名</span>
                            <div class="fl p-p">
                                <div class="j-select fl">
                                    <i class="j-select-arrow"></i>
                                    <div class="di project-item-select">
                                        <input type="hidden" name="indexId" id="indexId" value="${program.indexId}" />
                                        <input type="text" class="j-input d-input val" name="indexName" id="indextName" value="${program.indexName}"
                                               placeholder="请输入名称搜索标记" maxlength="20" onclick="matchName(this)" onkeyup="matchName(this)" data-att="require" />
                                    </div>
                                    <div class="j-select-options-i">
                                        <ul></ul>
                                    </div>
                                </div>
                                <p class="form-item-err">请输入样本索引列名</p>
                            </div>
                        </div>
                    </div>

                    <div class="module-title">
                        <span class="module-title-icon create-project-step-icon3"></span>
                        <b>算法选择</b>
                    </div>
                    <div class="algorithms">
                        <div>
                            <c:forEach items="${arithmeticList}" var="arithmetic">
                                <span class="algorithm" data-id="${arithmetic.id}">${arithmetic.showName}</span>
                            </c:forEach>
                        </div>
                        <div class="algorithm-excuting p-p">
                            <span class="fl">当前算法执行顺序:</span>
                            <input type="hidden" name="arithmeticIds" id="arithmeticIds" value="${program.arithmeticIds}" />
                            <input type="hidden" name="arithmeticNames" id="arithmeticNames" class="val" value="${program.arithmeticNames}" data-att="require" />
                            <div class="algorithm-queue" id="algorithm_queue"></div>
                            <p class="form-item-err">请至少选择一种算法</p>
                        </div>

                        <div class="model-config">
                            <span class="fl">模型配置</span>
                            <div class="model-config-switch">
                                <c:if test="${empty program.modelConf}">
                                    <input type="hidden" name="modelConf" value="0" />
                                </c:if>
                                <c:if test="${!empty program.modelConf}">
                                    <input type="hidden" name="modelConf" value="${program.modelConf}" />
                                </c:if>
                                <span class="j-check"><i data-id="0" class="checked"></i><b>演示</b></span>
                                <span class="j-check"><i data-id="1"></i><b>快速</b></span>
                                <span class="j-check"><i data-id="2"></i><b>精确</b></span>
                                <span class="j-check"><i data-id="3"></i><b>高可靠</b></span>
                            </div>
                        </div>
                    </div>

                    <div>
                        <span class="j-button start-create" onclick="save(0)" >保存</span>
                        <span class="j-button start-create" onclick="save(1)" >开始</span>
                    </div>
                </form>
            </div>
        </div>
        <!-- 右侧内容.html end -->
    </div>
    <!-- center.html end -->
</div>
</body>
</html>