<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>数据文件-文件详情</title>
	<link type="text/css" href="${ctx}/resources/css/style.css" rel="stylesheet" />
	<script type="text/javascript" src="${ctx}/resources/js/main.js"></script>
	<script type="text/javascript" src="${ctx}/resources/js/comet4j.js"></script>
</head>
<script type="text/javascript">
/*页面初始化*/
$(function(){
	/*文件详情*/
	getData();
});
/*文件详情*/
function getData(){
	//数据文件id
	var dataFileId = '${dataFileId}';

	$.ajax({
		url:"${ctx}/modelsDataFile/findDataMark",
		type:'POST',
		data:{
			"dataFileId":dataFileId,
		},
		async: false,
		success:function(data){
			if (200 == data.code) {
                //处理数据文件
                dealDataFile(data.data);
			} else {
				jAlert(data.msg);
				console.error(data.msg);
			}
		}
	});
}
//处理数据文件
function dealDataFile(data) {
    //文件信息
    var fileInfo = data.dataFile;
    if(fileInfo != null) {
        var htmlContent = createFileInfo(fileInfo);
        $("#fileDetail").html(htmlContent);
    }

    //文件变量信息
    var fileValue = data.dataFileList.rowFileInfoList;
    var htmlContent = createFileValueTiTle(fileValue);
    $("#fileValueTitles").html(htmlContent);

    //文件变量值信息
    var fileValueTitle = data.fileInfoList;
    var fileValue = data.dataFileList.rowFileInfoList;
    if(fileValueTitle != null) {
        var htmlContent = createFileValue(fileValueTitle,fileValue);
        $("#fileValueTitle").html(htmlContent);
    }
}
//创建文件详情信息
function createFileInfo(data) {
	var htmlContent = "";
    htmlContent += "<div class='file-details-name-size'><em>"+ (data.name == null ? "" : data.name) +"</em><b>样本量："+ (data.size == null ? "" : data.size) +"</b></div>";
    htmlContent += "<p class='file-details-desc'>描述: <span>"+ (data.description == null ? "" : data.description) +"</span></p>";
    return htmlContent;
}
//创建文件变量信息
function createFileValueTiTle(fileValue) {
    var htmlContent = '';
    if(null == fileValue || "" == fileValue) {
        htmlContent += '<tr>';
        htmlContent += '<th>序号</th>';
        htmlContent += '<th>变量</th>';
        htmlContent += '<th class="j-table-cell-140">类型</th>';
        htmlContent += '</tr>';
	}else{
        htmlContent += '<tr>';
        htmlContent += '<th>序号</th>';
        htmlContent += '<th>变量</th>';
        htmlContent += '<th class="j-table-cell-140">类型</th>';
        //数据集合长度
        var len = fileValue.length;
        if(len<5){
            for(var i=0;i<len;i++){
                htmlContent += '<th>val'+(i+1)+'</th>';
			}
		}else{
            for(var i=0;i<5;i++){
                htmlContent += '<th>val'+(i+1)+'</th>';
            }
		}
        htmlContent += '</tr>';
    }
    return htmlContent;
}

//创建文件变量和变量值信息
function createFileValue(fileValueTitle,fileValue) {
    var htmlContent = "";

    //数据集合长度
    var len = fileValueTitle.length;

    if (len == 0) {
        htmlContent += "<div class='file-details-name-size' style='text-align: center'><em>数据文件中暂无变量信息</em></div>";
	} else {
        for (var i = 0;i < len;i++) {
            //文件变量信息
            var myFileInfo = fileValueTitle[i];

            //变量类型：离散/连续
            var valueType = "";

            if (myFileInfo.type == 0) {
                valueType = "离散型变量";
			} else if (myFileInfo.type == 1) {
                valueType = "连续型变量";
			}

			htmlContent += "<tr>";
            htmlContent += "<input value='"+(myFileInfo.id)+"' type='hidden' />";
			htmlContent += "<td style='text-align: center'>"+(parseInt(i)+1)+"</td>";
			htmlContent += "<td style='text-align: center'>"+ (myFileInfo.name == null ? "" : myFileInfo.name) +"</td>";
			htmlContent += "<td style='text-align: center'>";
			htmlContent += "<div class='j-select'>";
			htmlContent += "<i class='j-select-arrow'></i>";
            htmlContent += "<input type='hidden' data-id='type' value='"+ myFileInfo.type +"' />";
			htmlContent += "<div style='text-align: center' class='j-select-placeholder'>"+ (valueType == null ? "" : valueType) +"</div>";
			htmlContent += "<div class='j-select-options'>";
			htmlContent += "<ul>";
			htmlContent += "<li>离散型变量</li>";
			htmlContent += "<li>连续型变量</li>";
			htmlContent += "</ul>";
			htmlContent += "</div>";
			htmlContent += "</div>";
			htmlContent += "</td>";
			if(null != fileValue && "" != fileValue){
                var lens = fileValue.length;
                if(lens<5){
                    for(var j=0;j<lens;j++){
                        //文件变量值信息
                        var myFileValue = fileValue[j].fileValueList;
                        htmlContent += "<td style='text-align: center'>"+(myFileValue[i].fileValue.value == null ? "" : myFileValue[i].fileValue.value)+"</td>";
                    }
                }else{
                    for(var j=0;j<5;j++){
                        //文件变量值信息
                        var myFileValue = fileValue[j].fileValueList;
                        htmlContent += "<td style='text-align: center'>"+(myFileValue[i].fileValue.value == null ? "" : myFileValue[i].fileValue.value)+"</td>";
                    }
                }
			}


            htmlContent += "</tr>";
		}
	}

	return htmlContent;
}
//select input 赋值
$(document).on('click','.j-select-options li',function(){
    var _self = $(this);

    //文件变量类型赋值
    var fileColumnType = "";

    if (_self.text() == "离散型变量") {
        fileColumnType = "0";
	} else if (_self.text() == "连续型变量") {
        fileColumnType = "1";
	}

    //input 赋值
    _self.parents('.j-select').find('input[data-id="type"]').val(fileColumnType);
});
//数据标记
function dataMark() {
    //数据文件id
    var id = '${dataFileId}';
    window.location.href = "${ctx}/modelsDataFile/dataMark?id="+id;
}
//变量分析
function dataAnalysis() {
    //数据文件id
    var id = '${dataFileId}';
    window.location.href = "${ctx}/modelsDataFile/varAnalysis?dataFileId="+id;
}
//保存数据标记
var markFlag = false;
function saveDataMark() {
    if (markFlag) {return;}
    markFlag = true;

    //数据文件id
    var dataFileId = '${dataFileId}';
    //input ids
    var inputIds = new Array();
    //input column type
	var columnTypes = new Array();
	//数组存储
	$("#fileValueTitle").find("tr").each(function () {
        inputIds.push($(this).find("input").eq(0).val());
        columnTypes.push($(this).find("input").eq(1).val());
    })
	//文件详情url
	var findInfoUrl = "${ctx}/modelsDataFile/fileInfo?id="+dataFileId;
	var findInfoUrl2 = "${ctx}/modelsDataFile/varAnalysis?dataFileId="+dataFileId;

    $.ajax({
        url:"${ctx}/modelsDataFile/saveDataMark",
        type:'POST',
        data:{
            "dataFileId":dataFileId,
            "inputIds":inputIds.join(","),
            "columnTypes":columnTypes.join(",")
        },
        async: false,
        success:function(data){
            if (200 == data.code) {
                //显示load
                var loader = document.getElementById('loader');
                loader.style.display = 'block';
                (function() {
                    JS.Engine.start('${ctx}/message/conn');
                    JS.Engine.on({
                        val : function(info){//侦听一个channel
                            var fileId=info.data.id;
                            var name=info.data.name;
                            if (dataFileId==fileId){
                                if (info.code=='0000'){
                                    loader.style.display = 'none';
                                    jAlert("文件“"+name+"”,获取变量信息成功", findInfoUrl2 + "&isUpdate=1");
                                }else{
                                    jAlert("文件“"+name+"”,获取变量失败", findInfoUrl + "&isUpdate=1");
                                }
							}
                        }
                    });
                })();

            } else {
                jAlert("修改失败", findInfoUrl + "&isUpdate=0");
                console.error(data.msg);
                markFlag = false;
            }
        }
    });
}

//返回上一层
function cancelDataMark() {
    //数据文件id
    var dataFileId = '${dataFileId}';
    window.location.href = "${ctx}/modelsDataFile/fileInfo?id="+dataFileId+"&isUpdate=0";
}
</script>
<body>
<img id="website-bgImg" class="website-bg website-bg-show" src="${ctx}/resources/img/bg.jpg" alt="星空万象">
<div id="loader" style="display: none">
	<div class="cssload-loader">变量分析中</div>
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
					<p>文件详情</p>
				</div>
				<div class="value-analysis-btn fr">
					<span class="j-button" onclick="dataMark();">类型标记</span>
					<span class="j-button" onclick="dataAnalysis();">变量分析</span>
				</div>
			</div>
			<!-- //main-header -->
			<div class="file-details">
				<div class="file-details-header">
					<div class="file-details-icon"></div>
					<div id="fileDetail" class="file-details-header-right"></div>
				</div>
				<!-- //file-details-header -->
				<div class="value-info">
					<table class="j-table" style="width: 100%;">
						<thead id="fileValueTitles">
							<%--表头列名--%>

						</thead>
						<tbody id="fileValueTitle"></tbody>
					</table>
					<div style="margin-top: 75px; text-align: center;">
						<span class="j-button" onclick="saveDataMark();">确定</span>
						<span style="margin-left: 20px;" class="j-button" onclick="cancelDataMark();">取消</span>
					</div>
				</div>
				<!-- //value-info -->
			</div>
			<!-- //file-details -->
		</div>
		<!-- //main -->
	</div>
	<!-- //content -->
</div>
<!-- //j-container -->
</body>
</html>