<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>数据文件-数据导入</title>
    <link type="text/css" href="${ctx}/resources/css/style.css" rel="stylesheet" />
    <script type="text/javascript" src="${ctx}/resources/js/main.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/ajaxfileupload.js"></script>
    <script type="text/javascript" src="${ctx}/resources/js/myValidate.js"></script>
</head>
<style type="text/css">
.select-file .text-box {
    width: 258px;
}
.select-file .j-input {
    width: 300px;
    color: #7c8ca5;
}
.select-file .j-select-placeholder {
    width: 257px;
}
/*input select start*/
.d-input {
    border: none;
    outline: none;
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
/*input select end*/
</style>
<script !src="">
var splitCodeArray = new Array();

$(function () {
    //定时清理error信息
    inputValInterVal();
    //文件名称赋值、校验
    fileNameVal();
    //分隔符集合赋值
    getSplitCodeArray();
    //输入框搜索
    getInputSearch();
});
/**
 * 获取分隔符集合
 */
function getSplitCodeArray(){
    splitCodeArray.push("逗号");
    splitCodeArray.push("制表符");
}
/**
 *  输入框搜索
 */
function getInputSearch(){
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
        var inputLabel =  $(this).parents(".j-select").find(".di input");
        inputLabel.val($(this).text());
    });
}
//数据文件-录入
var submitImportFlag = false;
function submitImportDataFile() {
    if (submitImportFlag) {return;}
    submitImportFlag = true;

    //必填校验
    if (!validateValue()) {
        submitImportFlag = false;
        return;
    } else {
        //携带值
        var fileName = $("#fileName").val();
        /*var fileType = $("#fileType").val();
        var fileCode = $("#fileCode").val();*/
        var splitCode = $("#splitCode").val();
        var nullValue = $("#nullValue").val();
        var targetName = $("#targetName").val();
        var indexName = $("#indexName").val();
        var description = $("#description").val();

        /*//文件后缀名称和选择的文件类型校验
        if (!validateFileLastName(fileType)) {
            jAlert("文件后缀名称和选择的文件类型不相符！");
            submitImportFlag = false;
            return;
        } else {*/
            //校验文件名称唯一
            if (validateName(fileName)) {
                //列表url
                var listUrl = "${ctx}/modelsDataFile/list";

                //显示load
                var loader = document.getElementById('loader');
                loader.style.display = 'block';

                $.ajaxFileUpload({
                    url : "${ctx}/modelsDataFile/doImportDataFile?fileName="+fileName+"&splitCode="+splitCode
                    +"&nullValue="+nullValue+"&targetName="+targetName+"&indexName="+indexName+"&description="+description,
                    secureuri : false,//是否需要安全协议
                    fileElementId : "dataFile",
                    dataType : "txt",
                    type : "POST",
                    async : false,
                    success : function(data) {
                        loader.style.display = 'none';

                        //转化obj类型
                        var reData = eval('(' + data + ')');

                        if(reData.code == 200){
                            var menuIndex = parseInt("${menuIndex}")+1;
                            listUrl = "${ctx}/modelsDataFile/list?menuIndex="+menuIndex;

                            jAlert("导入成功！", listUrl);
                        } else {
                            showMsg(reData.msg);
                            submitImportFlag = false;
                        }
                    }
                });
            }
        /*}*/
    }
}
/**
 * 显示错误信息
 */
function showMsg(msg) {
    //获取错误信息集合
    var errArray = createErrArray();

    //mark row column error
    if (msg.indexOf(",") > 0) {
        //err type/val
        var columnVal = msg.split(",");

        if (columnVal.length > 0) {
            //err type
            var errType = columnVal[0];

            if (errType == "103") {
                if (columnVal.length == 2) {
                    jAlert("填写的文件分隔符与文件中的不相符！");
                }
            } else if (errType == "104") {
                if (columnVal.length == 2) {
                    jAlert("文件中第"+columnVal[1]+"列列名称不符合规范！");
                } else {
                    jAlert("文件中第"+columnVal[1]+"列和第"+columnVal[2]+"列名称相同！");
                }
            } else if (errType == "105") {
                if (columnVal.length == 2) {
                    //row last value null
                    jAlert("文件中第"+columnVal[1]+"行最后一个值为空！");
                }
            } else if (errType == "106") {
                if (columnVal.length == 4) {
                    jAlert("文件中第"+columnVal[2]+"行第"+columnVal[3]+"列"+errArray[columnVal[1]]);
                } else {
                    jAlert("文件中第"+columnVal[4]+"列第"+columnVal[2]+"行和第"+columnVal[3]+"行"+errArray[columnVal[1]]);
                }
            } else {
                console.error("未识别错误！");
            }
        }
    } else {
        if (msg) {
            jAlert(errArray[msg]);
        } else {
            jAlert("导入失败！");
        }
    }
}
/**
 * 校验文件后缀名
 * @param name
 * @param type
 */
function validateFileLastName(type) {
    //文件名称
    var fileName = $("#source_file_name").text();
    return (fileName.substring((fileName.indexOf(".")+1)) == type) ? true : false;
}
//创建错误集合
function createErrArray(){
    //错误集合
    var errArray = new Array();

    //参数为空 params null
    errArray["101"] = "导入失败，请联系管理员！";
    //code
    errArray["102"] = "填写的文件编码和解析的文件编码格式不一致！";
    //split code
    errArray["103"] = "文件分隔符为中文格式！";
    //column
    errArray["104"] = "文件列名称不符合规范！";
    //index name not in file
    errArray["107"] = "填写的index name不是文件中的列名！";
    //target name not in file
    errArray["108"] = "填写的target name不是文件中的列名！";
    /**
     * 106下还有三种情况
     *  标志位1 106
     *  标志位2 1-index列/target列中有空值，2-index列中有相同的值，3-target列中有不是0和1的值
     *  标志位3 行号
     *  标志位4 列号
     */
    errArray["1"] = "为空值！";
    errArray["2"] = "存在相同值！";
    errArray["3"] = "值不是0和1！";

    return errArray;
}
/**
 * 验证文件名称唯一
 */
function validateName(name) {
    //validate is pass
    var flag = true;

    $.ajax({
        url:"${ctx}/modelsDataFile/validateName",
        type:'POST',
        data:{
            "name":name
        },
        async: false,
        success:function(data){
            if (200 == data.code) {
                $("#fileNameCheckError").hide();
            } else {
                flag = false;
                $("#fileNameCheckError").show();
                $("#fileNameCheckError").text(data.msg);
            }
        }
    });

    return flag;
}
//必填校验
function validateValue() {
    var passFlag = false;

    //input id
    var inputIdsArr = new Array();
    //校验规则
    var rulesArr = new Array();

    //文件名称
    var fileName = $('#source_file_name').text();
    $("#file").val(fileName);

    //校验有没有选择文件
    inputIdsArr.push("file");
    rulesArr.push("require");

    //测试用例
    $("#dataFileForm").find("input[data-id='1']").each(function (i, obj) {
        inputIdsArr.push($(this).attr("id"));
        rulesArr.push("require");
    });

    /*调用自定义校验方法*/
    myValidateEasy(
        {
            items : inputIdsArr,
            rules : rulesArr,
            success : function (data) {
                passFlag = true;
            }
        }
    );

    return passFlag;
}
//定时清理error信息
function inputValInterVal(obj){
    //添加定时器处理标识
    var initCount = setInterval(function () {
        //其他input
        var inputVal = $(obj).val();
        var inputId = $(obj).attr("id");
        if (inputVal != "") {
            $("#"+inputId+"Error").hide();

            //clear interval
            clearInterval(initCount);
        }
    }, 100);
}
/**
 * input select split code
 */
function matchName(obj) {
    var inputVal = obj.value;
    var liHtml = "";
    $.each(splitCodeArray, function (i, obj) {
        if ("" == inputVal) {
            liHtml += "<li>"+obj+"</li>";
        } else if (obj.indexOf(inputVal) >= 0) {
            liHtml += "<li>"+obj+"</li>";
        }
    });
    if ("" == liHtml) {
        liHtml += "<li></li>"
    }

    $(obj).parent().next().find("ul").html(liHtml);
}
//select input 赋值
$(document).on('click','.j-select-options li',function(){
    var _self = $(this);
    //input 赋值
    _self.parents('.j-select').find("input").val(_self.text());

    //清理error
    var inputId = _self.parents('.j-select').find("input").attr("id");
    if ($("#"+inputId).val != "") {
        $("#"+inputId+"Error").hide();
    }
});
//文件名称赋值
function fileNameVal() {
    $(document).on("change", "#dataFile", function(){
    /*$('#dataFile').on('change',function(){*/
        var _this = $(this);
        var filename = _this.get(0).files[0].name;

        //校验文件格式
        var flag = fileNameValidate(filename);

        if (flag) {
            $('#source_file_name').html(filename);
            //隐藏的文件input赋值
            $("#file").val(filename);
            if (filename != "") {
                $("#fileError").hide();
            }
        } else {
            jAlert("上传文件格式错误！请上传.csv文件或者.txt文件");
            return;
        }
    });
}
//导入校验后缀
function fileNameValidate(fileName) {
    var flag = false;

    var isCsv = fileName.indexOf('.csv');
    var isTxt = fileName.indexOf('.txt');
    if (isCsv > 0 || isTxt > 0) {
        flag = true;
    }

    return flag;
}
</script>
<body>
<img id="website-bgImg" class="website-bg website-bg-show" src="${ctx}/resources/img/bg.jpg" alt="星空万象">
<div id="loader" style="display: none">
    <div class="cssload-loader">导入中</div>
</div>
<!-- //网站背景 -->
<div class="j-container">
    <%--头文件====开始--%>
    <jsp:include page="../commons/topHead.jsp"/>
    <!-- //header -->
    <div class="content">
        <%--导航栏====开始--%>
        <jsp:include page="../commons/leftNavigation.jsp"/>
        <%--导航栏====结束--%>
        <!-- //side-nav -->
        <div class="main">
            <div class="main-header clearfix">
                <div class="page-title">
                    <h3>数据文件</h3>
                    <p>数据导入</p>
                </div>
            </div>
            <!-- //main-header -->
            <div id="select_file">
                <div class="select-file">
                    <form id="dataFileForm" action="" class="select-file-form">
                        <div class="form-item clearfix">
                            <label for="dataFile" class="j-label">选择文件</label>
                            <div class="form-item-content">
                                <div class="text-box" id="source_file_name"></div>
                                <input id="file" type="hidden">
                                <div class="browser-file">
                                    <input id="dataFile" name="dataFile" class="browser-file-ipt" type="file">
                                    <div class="j-button browser-file-btn">
                                        <i class="browser-file-icon"></i>
                                        <span>浏览</span>
                                    </div>
                                </div>
                                <p id="fileError" style="display: none" class="form-item-err">请选择文件</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="fileName" class="j-label">文件名称</label>
                            <div class="form-item-content">
                                <input id="fileName" type="text" class="j-input" data-id="1" onchange="inputValInterVal(this);" onblur="validateName(this.value);">
                                <p id="fileNameError" style="display: none" class="form-item-err">请输入文件名称</p>
                                <p id="fileNameCheckError" style="display: none" class="form-item-err"></p>
                            </div>
                        </div>
                        <%--<div class="form-item clearfix">
                            <label for="fileType" class="j-label">文件类型</label>
                            <div class="form-item-content">
                                <div class="j-select">
                                    <i class="j-select-arrow"></i>
                                    <input id="fileType" data-id="1" type="hidden">
                                    <div class="j-select-placeholder"></div>
                                    <div class="j-select-options">
                                        <ul>
                                            <li>csv</li>
                                            <li>txt</li>
                                        </ul>
                                    </div>
                                </div>
                                <p id="fileTypeError" style="display: none" class="form-item-err">请选择文件类型</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="fileCode" class="j-label">编码类型</label>
                            <div class="form-item-content">
                                <div class="j-select">
                                    <i class="j-select-arrow"></i>
                                    <input id="fileCode" data-id="1" type="hidden">
                                    <div class="j-select-placeholder"></div>
                                    <div class="j-select-options">
                                        <ul>
                                            <li>GBK</li>
                                            <li>UTF-8</li>
                                        </ul>
                                    </div>
                                </div>
                                <p id="fileCodeError" style="display: none" class="form-item-err">请选择编码类型</p>
                            </div>
                        </div>--%>
                        <div class="form-item clearfix">
                            <label for="splitCode" class="j-label">文件分隔符</label>
                            <div class="form-item-content">
                                <div class="j-select fl">
                                    <i class="j-select-arrow"></i>
                                    <div class="di project-item-select">
                                        <input id="splitCode" type="text" data-id="1" class="j-input d-input val"
                                               onclick="matchName(this)" onkeyup="matchName(this)" onchange="inputValInterVal(this);">
                                    </div>
                                    <div class="j-select-options-i">
                                        <ul></ul>
                                    </div>
                                </div>
                                <p id="splitCodeError" style="display: none" class="form-item-err">请输入文件分隔符</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="nullValue" class="j-label">缺失值</label>
                            <div class="form-item-content">
                                <input id="nullValue" type="text" data-id="0" class="j-input fl" onchange="inputValInterVal(this);">
                                <div class="text-box fl">变量内容为空的表达方式</div>
                                <p id="nullValueError" style="display: none" class="form-item-err">请输入</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="targetName" class="j-label">目标变量列名</label>
                            <div class="form-item-content">
                                <input id="targetName" type="text" data-id="1" class="j-input fl" onchange="inputValInterVal(this);">
                                <p id="targetNameError" style="display: none" class="form-item-err">请输入目标变量列名</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="indexName" class="j-label">样本索引列名</label>
                            <div class="form-item-content">
                                <input id="indexName" type="text" data-id="1" class="j-input fl" onchange="inputValInterVal(this);">
                                <p id="indexNameError" style="display: none" class="form-item-err">请输入样本索引列名</p>
                            </div>
                        </div>
                        <div class="form-item clearfix">
                            <label for="description" class="j-label">文件描述</label>
                            <div class="form-item-content">
                                <textarea id="description" class="file-description" cols="30" rows="5"></textarea>
                                <%--<p class="form-item-err">错误提示</p>--%>
                            </div>
                        </div>
                        <div class="clearfix">
                            <span class="j-button select-file-submit" onclick="submitImportDataFile();">导入</span>
                        </div>

                    </form>
                </div>
            </div>
            <!-- //select-file -->
        </div>
        <!-- //main -->
    </div>
    <!-- //content -->
</div>
<!-- //j-container -->
</body>
</html>