<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>模型报告</title>
    <link rel="stylesheet" href="${ctx}/resources/css/style.css">
</head>
<style type="text/css">
.line-chart-wrap{
    position: relative;
    margin: 0 60px 20px 0;
    width: 45%;
    height: 400px;
}
</style>

<body  >
<!--pop-->
<div class="model-pop">
    <div class="pop-box">
        <form id="extractModelsForm">
            <input type="hidden" id="programIds">
            <input type="hidden" id="dataFileIds">
            <input type="hidden" id="arithmeticIds">
            <input type="hidden" id="programNames">
            <input type="hidden" id="arithmeticNames">
            <div class="form-item clearfix">
                <div class="form-item-content">
                    <label class="j-label">模型名称</label>
                    <input type="text" class="j-input" id="modelName" name="modelName">
                    <p id="modelNameError" style="" class="form-item-err"></p>
                </div>
            </div>
            <div class="form-item clearfix">
                <div class="form-item-content">
                    <label class="j-label">模型描述</label>
                    <textarea class="file-description" id="modelDescription" name="modelDescription" cols="30" rows="5"></textarea>
                    <p id="modelDescriptionError" style="" class="form-item-err"></p>
                </div>
            </div>
            <div id="close_pop">
                <a class="j-button create-project-btn" href="javascript: confrimExtractModels();">
                    确定
                </a>
                <a  class="j-button create-project-btn" href="javascript:;">
                    取消
                </a>
            </div>
        </form>
    </div>
</div>
<div id="loader">
    <div class="cssload-loader">加载中</div>
</div>
<img id="website-bgImg" class="website-bg website-bg-show" src="${ctx}/resources/img/bg.jpg" alt="星空万象">
<div class="j-container">
    <%--头文件====开始--%>
    <jsp:include page="../commons/topHead.jsp"/>
    <%--头文件====结束--%>
    <div class="content">
        <%--导航栏====开始--%>
        <jsp:include page="../commons/leftNavigation.jsp"/>
        <%--导航栏====结束--%>


        <!-- //side-nav -->
        <div class="main">
            <div class="main-header clearfix">
                <div class="page-title">
                    <h3>实验室</h3>
                    <p>模型报告</p>
                </div>
            </div>
            <!-- //main-header -->
            <div class="model-report">
                <div class="model-base-info">
                    <table class="j-table model-base-info-table">
                        <tbody>
                        <tr>
                            <td>${programBasicInfoMap.name}</td>
                            <td>
                                数据表:
                                <p>${programBasicInfoMap.dataFileName}</p>
                            </td>
                            <td>
                                样本量:
                                <p>${programBasicInfoMap.dataSampleNum}</p>
                            </td>
                            <td>
                                算法:
                                <p>${programBasicInfoMap.arithmeticNames}</p>
                            </td>
                            <td>
                                创建时间:
                                <p>${programBasicInfoMap.createTime}</p>
                            </td>
                            <td>
                                用时:
                                <p>${programBasicInfoMap.castTime}</p>
                            </td>
                            <td>
                                模型配置:
                                <p>${programBasicInfoMap.modelConf}</p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="model-report-details">
                <div class="tab-switch algorithm-switch">
                    <c:forEach var="item" varStatus="status" items="${arithmeticList }">
                        <c:choose>
                            <c:when test="${status.index ==0 }">
                                <span class="j-button active">${item }</span>
                            </c:when>
                            <c:otherwise>
                                <span class="j-button">${item }</span>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </div>


                <div class="model-report-contents">


                    <c:forEach var="item" varStatus="status" items="${arithmeticList }">
                        <c:choose>
                            <c:when test="${status.index ==0 }">
                                <div class="model-report-content"  style="display: block">
                            </c:when>
                            <c:otherwise>
                                <div class="model-report-content">
                            </c:otherwise>
                        </c:choose>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>模型数据概览</span>
                                </div>
                                <div class="model-data-overview">
                                    <table class="j-table">
                                        <thead>
                                        <tr>
                                            <th></th>
                                            <th>样本量</th>
                                            <th>总维度</th>
                                            <th>入模维度</th>
                                            <th>重要变量</th>
                                            <th>正负样本比</th>
                                            <th>正样本率</th>
                                        </tr>
                                        </thead>
                                        <tbody id="modelDate_${status.index }">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>模型评价指标</span>
                                </div>
                                <div class="model-evaluation-index">
                                    <table class="j-table">
                                        <thead>
                                        <tr>
                                            <th></th>
                                            <th>AUC</th>
                                            <th>KS</th>
                                            <th>gini</th>
                                            <th>precision</th>
                                            <th>recall</th>
                                            <th>f1-score</th>
                                            <th>support</th>
                                        </tr>
                                        </thead>
                                        <tbody id="modelEvaluateIndex_${status.index }">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>ROC / KS曲线 -训练集</span>
                                </div>
                                <div class="roc-ks-chart clearfix">
                                    <div class="line-chart-wrap fl">
                                        <ul class="line-chart-legend">
                                            <li><i class="line-chart-legend-1"></i><span>tpr-Curve</span></li>
                                            <li><i class="line-chart-legend-2"></i><span>fpr-Curve</span></li>
                                            <li><i class="line-chart-legend-3"></i><span>ks-Curve</span></li>
                                        </ul>
                                        <div class="line-chart" id="chart_${status.index*4+1 }"></div>
                                    </div>
                                    <div class="line-chart-wrap fl">
                                        <div class="line-chart" id="chart_${status.index*4+2 }"></div>
                                    </div>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>ROC / KS曲线 -测试集</span>
                                </div>
                                <div class="roc-ks-chart clearfix">
                                    <div class="line-chart-wrap fl">
                                        <ul class="line-chart-legend">
                                            <li><i class="line-chart-legend-1"></i><span>tpr-Curve</span></li>
                                            <li><i class="line-chart-legend-2"></i><span>fpr-Curve</span></li>
                                            <li><i class="line-chart-legend-3"></i><span>ks-Curve</span></li>
                                        </ul>
                                        <div class="line-chart" id="chart_${status.index*4+3 }"></div>
                                    </div>
                                    <div class="line-chart-wrap fl">
                                        <div class="line-chart" id="chart_${status.index*4+4 }"></div>
                                    </div>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>Score分组详情 -训练集</span>
                                </div>
                                <div class="score-group">
                                    <table class="j-table">
                                        <thead>
                                        <tr>
                                            <th>预测概率区间</th>
                                            <th>负（0）样本量</th>
                                            <th>正（1）样本量</th>
                                            <th>样本量</th>
                                            <th>样本量占比</th>
                                            <th>IV</th>
                                            <th>正样本量占比</th>
                                            <th>预测正样本量占比</th>
                                        </tr>
                                        </thead>
                                        <tbody id="scoreGroup_${status.index }">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>概率分箱图 -训练集</span>
                                </div>
                                <div class="linebar-mixed">
                                    <div class="linebar-mixed-legend">
                                        <i></i>
                                        <span>样本数</span>
                                        <b></b>
                                        <span>实际正样本率</span>
                                        <p></p>
                                        <span>预测正样本率</span>
                                    </div>
                                    <div class="linebar-mixed-chart" id="linebar_mixed_chart_${status.index+1 }"></div>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>Score分组详情 -测试集</span>
                                </div>
                                <div class="score-group">
                                    <table class="j-table">
                                        <thead>
                                        <tr>
                                            <th>预测概率区间</th>
                                            <th>负（0）样本量</th>
                                            <th>正（1）样本量</th>
                                            <th>样本量</th>
                                            <th>样本量占比</th>
                                            <th>IV</th>
                                            <th>正样本量占比</th>
                                            <th>预测正样本量占比</th>
                                        </tr>
                                        </thead>
                                        <tbody id="scoreGroup1_${status.index }">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>概率分箱图 -测试集</span>
                                </div>
                                <div class="linebar-mixed">
                                    <div class="linebar-mixed-legend">
                                        <i></i>
                                        <span>样本数</span>
                                        <b></b>
                                        <span>实际正样本率</span>
                                        <p></p>
                                        <span>预测正样本率</span>
                                    </div>
                                    <div class="linebar-mixed-chart" id="linebar_mixed_chart1_${status.index+1 }"></div>
                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>TOP20变量IV值</span>
                                    <a id="sTop20_${status.index }" class="right">收　　起</a>
                                </div>
                                <div id="show_top20_${status.index }" class="linebar_IV_chart_${status.index }">

                                </div>
                                <div class="module-subtitle">
                                    <i></i>
                                    <span>变量重要性排序</span>
                                    <a id="sSort_${status.index }" class="right">收　　起</a>
                                </div>
                                <div id="show_sort_${status.index }" class="value-importance-sort">
                                    <table class="j-table">
                                        <thead>
                                        <tr>
                                            <th>序号</th>
                                            <th>变量名称（<span style="cursor: pointer" id="chineseChangeEnglish_${status.index }" onclick="chineseChangeEnglish('varImportanceSort_${status.index }','chineseChangeEnglish_${status.index }');">中文</span>）</th>
                                            <th>值</th>
                                            <th>重要性</th>
                                        </tr>
                                        </thead>
                                        <tbody id="varImportanceSort_${status.index }">

                                        </tbody>
                                    </table>
                                </div>
                                <div class="model-report-btns" id="download_${status.index }">

                                </div>
                                </div>
                    </c:forEach>


                </div>
            </div>
        </div>
        <!-- //main -->
    </div>
    <!-- content -->


</div>
<!-- j-container -->
<script src="${ctx}/resources/js/echarts.min.js"></script>
<script src="${ctx}/resources/js/main.js"></script>
<script src="${ctx}/resources/js/varChineseAndEnglish.js"></script>
<script type="text/javascript">
    <%--//初始化中英文对应关系--%>
    <%--var varLanguage = "";--%>
    <%--$(function(){--%>
        <%--//获取中英文对应关系--%>
        <%--varLanguage = getChinsesAndEnglish(${dataFileId},"${ctx}/varLanguage/getChinsesAndEnglish");--%>
    <%--})--%>
    //中英文切换
    function chineseChangeEnglish(htmlId,thId){
        languageChange(htmlId,thId,getChinsesAndEnglish(${dataFileId},"${ctx}/varLanguage/getChinsesAndEnglish"));
    }
</script>
<script type="text/javascript">
//    var loading =  new jLoading('加载中');
//    setTimeout(function(){
//        loading.hide();
//    },1500)

    //该项目所采用算法id list
    var arithmeticIdList = ${arithmeticIdList};
    //该项目所采用算法name list
    var arithmeticNameList = ${arithmeticNameList };
    //模型数据分析结果 list
    var modelDateAnalyInfoList = ${modelDateAnalyInfoList};
    //模型数据评价指标list list
    var modelDateEvaluateIndexList = ${modelDateEvaluateIndexList};
    //变量重要性排序 list
    var varImportanceSortList = ${varImportanceSortList};
    //Score分组详情 list ---训练集
    var scoreGroupList = ${scoreGroupList};
    //Score分组详情 list ---测试集
    var scoreGroupList1 = ${scoreGroupList2};

    //曲线数据list
    var roc_option_1 = new Array;
    var roc_option_2 = new Array;
    var roc_option_3 = new Array;
    var roc_option_4 = new Array;
    var abscissa1 = new Array;
    var abscissa2 = new Array;
    var abscissa3 = new Array;
    var abscissa4 = new Array;

    //分箱数据list
    var dataList1 = new Array;
    var dataList2 = new Array;
    var dataList3 = new Array;
    var dataList4 = new Array;

    //分箱数据2list
    var dataList11 = new Array;
    var dataList12 = new Array;
    var dataList13 = new Array;
    var dataList14 = new Array;

    //分箱要排除的对象
    var dataLineMsg = "All";


    /**
     * 实验室算法选择
     */
    $(document).on('click','.algorithm-switch span',function(){
        var _this = $(this);
        _this.addClass('active').siblings('span').removeClass('active')
        var index = _this.index();
        $('.model-report-content').eq(index).fadeIn(200).siblings('div').fadeOut(200);
        if(null != arithmeticIdList && arithmeticIdList.length>0){
            for(var i = 0; i<arithmeticIdList.length;i++){
                if(index == i){
                    //控制重要变量div的收缩
                    divVarHidden(i);
                    //生成曲线图
                    getLineChartData("${programId}",arithmeticIdList[i],i);
                    //生成分箱图 ---训练集
                    if(null != scoreGroupList && scoreGroupList.length>0){
                        dataList1 = new Array;
                        dataList2 = new Array;
                        dataList3 = new Array;
                        dataList4 = new Array;
                        for(var j = 0; j<scoreGroupList.length;j++){
                            if(arithmeticIdList[i] == scoreGroupList[j].arithmeticId ){
                                if(dataLineMsg != scoreGroupList[j].binsScore){
                                    dataList1.push(scoreGroupList[j].binsScore);
                                    dataList2.push(scoreGroupList[j].total);
                                    dataList3.push(scoreGroupList[j].badPer);
                                    dataList4.push(scoreGroupList[j].modelPvalue);
                                }
                            }
                        }
                        probabilityChart('linebar_mixed_chart_'+(i+1),dataList1,dataList2,dataList3,dataList4);
                    }
                    //生成分箱图 ---测试集
                    if(null != scoreGroupList1 && scoreGroupList1.length>0){
                        dataList11 = new Array;
                        dataList12 = new Array;
                        dataList13 = new Array;
                        dataList14 = new Array;
                        for(var j = 0; j<scoreGroupList1.length;j++){
                            if(arithmeticIdList[i] == scoreGroupList1[j].arithmeticId ){
                                if(dataLineMsg != scoreGroupList1[j].binsScore){
                                    dataList11.push(scoreGroupList1[j].binsScore);
                                    dataList12.push(scoreGroupList1[j].total);
                                    dataList13.push(scoreGroupList1[j].badPer);
                                    dataList14.push(scoreGroupList1[j].modelPvalue);
                                }
                            }
                        }
                        probabilityChart('linebar_mixed_chart1_'+(i+1),dataList11,dataList12,dataList13,dataList14);
                    }
                    //生成IV top20柱状图
                    getModelIVListData("${programId}",arithmeticIdList[i],i);
                }
            }
        }
    });

    //初始化数据
    $(function(){
        if(null != arithmeticIdList && arithmeticIdList.length>0){
            /**
             * 初始化模型数据概览
             */
            if(null != modelDateAnalyInfoList && modelDateAnalyInfoList.length>0){
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    for(var j = 0; j<modelDateAnalyInfoList.length;j++){
                        if(arithmeticIdList[i] == modelDateAnalyInfoList[j].arithmeticId ){
                            //类型：0：训练集；1：测试集
                            if(modelDateAnalyInfoList[j].type == 0){
                                htmlContent += '<tr>';
                                htmlContent += '<td class="with-bg">训练集</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].sampleNum == null ? "" : modelDateAnalyInfoList[j].sampleNum)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].sumDimensionality == null ? "" : modelDateAnalyInfoList[j].sumDimensionality)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].intoDimensionality == null ? "" : modelDateAnalyInfoList[j].intoDimensionality)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].importanceVar == null ? "" : modelDateAnalyInfoList[j].importanceVar)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].plusMinusRate == null ? "" : parseFloat(modelDateAnalyInfoList[j].plusMinusRate).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].plusRate == null ? "" : parseFloat((modelDateAnalyInfoList[j].plusRate)*100).toFixed(2)+'%')+'</td>';
                                htmlContent += '</tr>';
                            }
                            if(modelDateAnalyInfoList[j].type == 1){
                                htmlContent += '<tr>';
                                htmlContent += '<td class="with-bg">测试集</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].sampleNum == null ? "" : modelDateAnalyInfoList[j].sampleNum)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].sumDimensionality == null ? "" : modelDateAnalyInfoList[j].sumDimensionality)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].intoDimensionality == null ? "" : modelDateAnalyInfoList[j].intoDimensionality)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].importanceVar == null ? "" : modelDateAnalyInfoList[j].importanceVar)+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].plusMinusRate == null ? "" : parseFloat(modelDateAnalyInfoList[j].plusMinusRate).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateAnalyInfoList[j].plusRate == null ? "" : parseFloat((modelDateAnalyInfoList[j].plusRate)*100).toFixed(2)+'%')+'</td>';
                                htmlContent += '</tr>';
                            }
                        }
                    }
                    if("" == htmlContent || null == htmlContent){
                        htmlContent += '<tr>';
                        htmlContent += '<td class="with-bg">训练集</td>';
                        htmlContent += '<td style="text-align:center" colspan="6">暂无数据</td>';
                        htmlContent += '</tr>';
                        htmlContent += '<tr>';
                        htmlContent += '<td class="with-bg">测试集</td>';
                        htmlContent += '<td style="text-align:center" colspan="6">暂无数据</td>';
                        htmlContent += '</tr>';
                    }
                    $("#modelDate_"+i).html(htmlContent);
                }
            }else{
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    htmlContent += '<tr>';
                    htmlContent += '<td class="with-bg">训练集</td>';
                    htmlContent += '<td style="text-align:center" colspan="6">暂无数据</td>';
                    htmlContent += '</tr>';
                    htmlContent += '<tr>';
                    htmlContent += '<td class="with-bg">测试集</td>';
                    htmlContent += '<td style="text-align:center" colspan="6">暂无数据</td>';
                    htmlContent += '</tr>';
                    $("#modelDate_"+i).html(htmlContent);
                }
            }
            /**
             * 初始化模型指标评价数据
             */
            if(null != modelDateEvaluateIndexList && modelDateEvaluateIndexList.length>0){
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    for(var j = 0; j<modelDateEvaluateIndexList.length;j++){
                        if(arithmeticIdList[i] == modelDateEvaluateIndexList[j].arithmeticId ){
                            //类型：0：训练集；1：测试集
                            if(modelDateEvaluateIndexList[j].type == 0){
                                htmlContent += '<tr>';
                                htmlContent += '<td class="with-bg">训练集</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].auc == null ? "" : parseFloat(modelDateEvaluateIndexList[j].auc).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].ks == null ? "" : parseFloat(modelDateEvaluateIndexList[j].ks).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].gini == null ? "" : parseFloat(modelDateEvaluateIndexList[j].gini).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].precisions == null ? "" : parseFloat(modelDateEvaluateIndexList[j].precisions).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].recall == null ? "" : parseFloat(modelDateEvaluateIndexList[j].recall).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].f1Score == null ? "" : parseFloat(modelDateEvaluateIndexList[j].f1Score).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].support == null ? "" : modelDateEvaluateIndexList[j].support)+'</td>';
                                htmlContent += '</tr>';
                            }
                            if(modelDateEvaluateIndexList[j].type == 1){
                                htmlContent += '<tr>';
                                htmlContent += '<td class="with-bg">测试集</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].auc == null ? "" : parseFloat(modelDateEvaluateIndexList[j].auc).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].ks == null ? "" : parseFloat(modelDateEvaluateIndexList[j].ks).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].gini == null ? "" : parseFloat(modelDateEvaluateIndexList[j].gini).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].precisions == null ? "" : parseFloat(modelDateEvaluateIndexList[j].precisions).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].recall == null ? "" : parseFloat(modelDateEvaluateIndexList[j].recall).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].f1Score == null ? "" : parseFloat(modelDateEvaluateIndexList[j].f1Score).toFixed(4))+'</td>';
                                htmlContent += '<td>'+(modelDateEvaluateIndexList[j].support == null ? "" : modelDateEvaluateIndexList[j].support)+'</td>';
                                htmlContent += '</tr>';
                            }
                        }
                    }
                    if("" == htmlContent || null == htmlContent){
                        htmlContent += '<tr>';
                        htmlContent += '<td class="with-bg">训练集</td>';
                        htmlContent += '<td style="text-align:center" colspan="7">暂无数据</td>';
                        htmlContent += '</tr>';
                        htmlContent += '<tr>';
                        htmlContent += '<td class="with-bg">测试集</td>';
                        htmlContent += '<td style="text-align:center" colspan="7">暂无数据</td>';
                        htmlContent += '</tr>';
                    }
                    $("#modelEvaluateIndex_"+i).html(htmlContent);
                }
            }else{
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    htmlContent += '<tr>';
                    htmlContent += '<td class="with-bg">训练集</td>';
                    htmlContent += '<td style="text-align:center" colspan="7">暂无数据</td>';
                    htmlContent += '</tr>';
                    htmlContent += '<tr>';
                    htmlContent += '<td class="with-bg">测试集</td>';
                    htmlContent += '<td style="text-align:center" colspan="7">暂无数据</td>';
                    htmlContent += '</tr>';
                    $("#modelEvaluateIndex_"+i).html(htmlContent);
                }
            }
            /**
             * 初始化变ROS/KS曲线
             */
            getLineChartData("${programId}",arithmeticIdList[0],0);
            /**
             * 初始化Score分组详情 ---训练集
             */
            if(null != scoreGroupList && scoreGroupList.length>0){
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    for(var j = 0; j<scoreGroupList.length;j++){
                        if(arithmeticIdList[i] == scoreGroupList[j].arithmeticId ){
                            htmlContent += '<tr>';
                            htmlContent += '<td>'+(scoreGroupList[j].binsScore == null ? "" : scoreGroupList[j].binsScore)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].good == null ? "" : scoreGroupList[j].good)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].bad == null ? "" : scoreGroupList[j].bad)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].total == null ? "" : scoreGroupList[j].total)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].factor == null ? "" : parseFloat((scoreGroupList[j].factor)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].iv == null ? "" : parseFloat(scoreGroupList[j].iv).toFixed(4))+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].badPer == null ? "" : parseFloat((scoreGroupList[j].badPer)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '<td>'+(scoreGroupList[j].modelPvalue == null ? "" : parseFloat((scoreGroupList[j].modelPvalue)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '</tr>';
                        }
                    }
                    if("" == htmlContent || null == htmlContent){
                        htmlContent += '<tr>';
                        htmlContent += '<td style="text-align:center" colspan="8">暂无数据</td>';
                        htmlContent += '</tr>';
                    }
                    $("#scoreGroup_"+i).html(htmlContent);
                }
            }else{
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    htmlContent += '<tr>';
                    htmlContent += '<td style="text-align:center" colspan="8">暂无数据</td>';
                    htmlContent += '</tr>';
                    $("#scoreGroup_"+i).html(htmlContent);
                }
            }
            /**
             * 初始化概率分箱图 ---训练集
             */
            if(null != scoreGroupList && scoreGroupList.length>0){
                for(var j = 0; j<scoreGroupList.length;j++){
                    if(arithmeticIdList[0] == scoreGroupList[j].arithmeticId ){
                        if(dataLineMsg != scoreGroupList[j].binsScore){
                            dataList1.push((scoreGroupList[j].binsScore == null ? "" : scoreGroupList[j].binsScore));
                            dataList2.push((scoreGroupList[j].total == null ? "" : scoreGroupList[j].total));
                            dataList3.push((scoreGroupList[j].badPer == null ? "" : scoreGroupList[j].badPer));
                            dataList4.push((scoreGroupList[j].modelPvalue == null ? "" : scoreGroupList[j].modelPvalue));
                        }
                    }
                }
                probabilityChart('linebar_mixed_chart_1',dataList1,dataList2,dataList3,dataList4);
            }
            /**
             * 初始化Score分组详情 ---测试集
             */
            if(null != scoreGroupList1 && scoreGroupList1.length>0){
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    for(var j = 0; j<scoreGroupList1.length;j++){
                        if(arithmeticIdList[i] == scoreGroupList1[j].arithmeticId ){
                            htmlContent += '<tr>';
                            htmlContent += '<td>'+(scoreGroupList1[j].binsScore == null ? "" : scoreGroupList1[j].binsScore)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].good == null ? "" : scoreGroupList1[j].good)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].bad == null ? "" : scoreGroupList1[j].bad)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].total == null ? "" : scoreGroupList1[j].total)+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].factor == null ? "" : parseFloat((scoreGroupList1[j].factor)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].iv == null ? "" : parseFloat(scoreGroupList1[j].iv).toFixed(4))+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].badPer == null ? "" : parseFloat((scoreGroupList1[j].badPer)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '<td>'+(scoreGroupList1[j].modelPvalue == null ? "" : parseFloat((scoreGroupList1[j].modelPvalue)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '</tr>';
                        }
                    }
                    if("" == htmlContent || null == htmlContent){
                        htmlContent += '<tr>';
                        htmlContent += '<td style="text-align:center" colspan="8">暂无数据</td>';
                        htmlContent += '</tr>';
                    }
                    $("#scoreGroup1_"+i).html(htmlContent);
                }
            }else{
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    htmlContent += '<tr>';
                    htmlContent += '<td style="text-align:center" colspan="8">暂无数据</td>';
                    htmlContent += '</tr>';
                    $("#scoreGroup1_"+i).html(htmlContent);
                }
            }
            /**
             * 初始化概率分箱图 ---测试集
             */
            if(null != scoreGroupList1 && scoreGroupList1.length>0){
                for(var j = 0; j<scoreGroupList1.length;j++){
                    if(arithmeticIdList[0] == scoreGroupList1[j].arithmeticId ){
                        if(dataLineMsg != scoreGroupList1[j].binsScore){
                            dataList11.push((scoreGroupList1[j].binsScore == null ? "" : scoreGroupList1[j].binsScore));
                            dataList12.push((scoreGroupList1[j].total == null ? "" : scoreGroupList1[j].total));
                            dataList13.push((scoreGroupList1[j].badPer == null ? "" : scoreGroupList1[j].badPer));
                            dataList14.push((scoreGroupList1[j].modelPvalue == null ? "" : scoreGroupList1[j].modelPvalue));
                        }
                    }
                }
                probabilityChart('linebar_mixed_chart1_1',dataList11,dataList12,dataList13,dataList14);
            }
            /**
             * 初始化变量值IV top20柱状图
             */
            getModelIVListData("${programId}",arithmeticIdList[0],0);
            /**
             * 初始化变量重要性排序
             */
            if(null != varImportanceSortList && varImportanceSortList.length>0){
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var int = 0;
                    var htmlContent = '';
                    for(var j = 0; j<varImportanceSortList.length;j++){
                        if(arithmeticIdList[i] == varImportanceSortList[j].arithmeticId ){
                            int += 1;
                            htmlContent += '<tr>';
                            htmlContent += '<td>'+int+'</td>';
                            htmlContent += '<td>'+(varImportanceSortList[j].varName == null ? "" : varImportanceSortList[j].varName)+'</td>';
                            htmlContent += '<td>'+(varImportanceSortList[j].gain == null ? "" : (varImportanceSortList[j].gain).toFixed(2))+'</td>';
                            htmlContent += '<td>'+(varImportanceSortList[j].pctImportance == null ? "" : parseFloat((varImportanceSortList[j].pctImportance)*100).toFixed(2)+'%')+'</td>';
                            htmlContent += '</tr>';
                        }
                    }
                    if("" == htmlContent || null == htmlContent){
                        htmlContent += '<tr>';
                        htmlContent += '<td style="text-align:center" colspan="4">暂无数据</td>';
                        htmlContent += '</tr>';
                    }
                    $("#varImportanceSort_"+i).html(htmlContent);
                }
            }else{
                for(var i = 0; i<arithmeticIdList.length;i++){
                    var htmlContent = '';
                    htmlContent += '<tr>';
                    htmlContent += '<td style="text-align:center" colspan="4">暂无数据</td>';
                    htmlContent += '</tr>';
                    $("#varImportanceSort_"+i).html(htmlContent);
                }
            }
            /**
             * 下载链接
             */
            for(var i = 0; i<arithmeticIdList.length;i++){
                var htmlContent = '';
                htmlContent += '<a href="javascript:downloadFile(${programId},'+arithmeticIdList[i]+',1);"><span class="j-button">下载预测结果</span></a>';
                htmlContent += '<a href="javascript:downloadFile(${programId},'+arithmeticIdList[i]+',2);"><span class="j-button">下载项目分析结果</span></a>';
                var arithmeticName = arithmeticNameList[i];
                htmlContent += '<a href="javascript:void(0);" onclick=extractModels(${programId},${programBasicInfoMap.dataFileId},'+arithmeticIdList[i]+',"${programBasicInfoMap.name}","'+arithmeticName+'") ><span class="j-button">提取模型</span></a>';
                $("#download_"+i).html(htmlContent);
            }
        }
        //控制重要变量div的收缩
        divVarHidden(0);
    });

    //下载文件
    function downloadFile(programId,arithmeticId,type) {
        window.location.href="${ctx}/modelsReport/downloadFiles?programId="+programId+"&arithmeticId="+arithmeticId+"&type="+type;
        <%--if(!isNull(programId)&&!isNull(arithmeticId)&&!isNull(type)){--%>
            <%--$.ajax({--%>
                <%--url : "${ctx}/modelsReport/downloadFile",--%>
                <%--type : 'POST',--%>
                <%--data : {--%>
                    <%--"programId":programId,--%>
                    <%--"arithmeticId":arithmeticId,--%>
                    <%--"type":type--%>
                <%--},--%>
                <%--success : function(data) {--%>
                    <%--if(null != data && ""!=data){--%>
                        <%--if (500 == data.code){--%>
                            <%--jAlert(data.msg);--%>
                        <%--}else{--%>
                            <%--jAlert("下载文件失败");--%>
                        <%--}--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>
        <%--}else{--%>
            <%--jAlert("传参错误！");--%>
        <%--}--%>
    }


$(function(){
    $.validator.addMethod("isOnlyModelName", function(value,element) {
        var modelName = $.trim($("#modelName").val());
        var flag = false;
        $.ajax({
            type : 'POST',
            url : '${ctx}/modelsLibrary/isOnlyModelName',
            async:false,
            data : {
                "modelName" : modelName
            },
            success : function(data) {
                if (data.result == 0) {
                    flag = false;
                }else{
                    flag = true;
                }
            }
        })
        return flag;
    }, "此名称已存在，请尝试其它名称");
    $.validator.addMethod("isRepetitionExtract", function(value,element) {
        var programIds = $.trim($("#programIds").val());
        var arithmeticIds = $.trim($("#arithmeticIds").val());
        var flag = false;
        $.ajax({
            type : 'POST',
            url : '${ctx}/modelsLibrary/isRepetitionExtract',
            async:false,
            data : {
                "programIds" : programIds,
                "arithmeticIds":arithmeticIds
            },
            success : function(data) {
                if (data.result == 0) {
                    flag = false;
                }else{
                    flag = true;
                }
            }
        })
        return flag;
    }, "该模型已提取过，请勿重复提取");
    $("#extractModelsForm").validate({
        ignore: "",
        rules: {
            modelName: {
                required: true,
                isOnlyModelName:true,
                isRepetitionExtract:true
            },
            modelDescription: {
                required: true
            }
        },
        messages: {
            modelName:{
                required:"请输入模型名称"
            },
            modelDescription:{
                required:"请输入模型描述"
            }
        },
        errorPlacement: function(error, element) {
            if(element.is("input[name=modelName]")){
                error.appendTo($("#modelNameError"));
            }
            if(element.is("textarea[name=modelDescription]")){
                error.appendTo($("#modelDescriptionError"));
            }
        },
    });
})

    //提取模型
    function extractModels(programId,dataFileId,arithmeticId,programName,arithmeticName) {
        $("#programIds").val("");
        $("#dataFileIds").val("");
        $("#arithmeticIds").val("");
        $("#programNames").val("");
        $("#arithmeticNames").val("");
        $("#modelName").val("");
        $("#modelDescription").val("");
        $("#modelNameError").html("");
        $("#modelDescriptionError").html("");

        //提取模型弹窗
        var modelPop = document.querySelector(".model-pop");
        var closePop = document.getElementById("close_pop");
        var closeBtns = closePop.children;
        modelPop.style.display = "block";
        closeBtns[1].onclick = function () {
            modelPop.style.display = "none";
        }

        $("#programIds").val(programId);
        $("#dataFileIds").val(dataFileId);
        $("#arithmeticIds").val(arithmeticId);
        $("#programNames").val(programName);
        $("#arithmeticNames").val(arithmeticName);
    }

    //确定提取模型
    function confrimExtractModels() {
        if($("#extractModelsForm").valid()){
            var programId = $("#programIds").val();
            var dataFileId = $("#dataFileIds").val();
            var arithmeticId = $("#arithmeticIds").val();
            var programName = $("#programNames").val();
            var arithmeticName = $("#arithmeticNames").val();
            var modelName = $("#modelName").val();
            var description = $("#modelDescription").val();
            if(null != programId && null != dataFileId && null != arithmeticId && null != modelName){
                $.ajax({
                    url : "${ctx}/modelsLibrary/extractModels",
                    type : 'POST',
                    data : {
                        "programId":programId,
                        "arithmeticId":arithmeticId,
                        "dataFileId":dataFileId,
                        "programName":programName,
                        "arithmeticName":arithmeticName,
                        "modelName":modelName,
                        "description":description
                    },
                    success : function(data) {
                        var modelPop = document.querySelector(".model-pop");
                        modelPop.style.display = "none";
                        if(200 == data.code){
                            var menuIndex = parseInt("${menuIndex}")+1;
                            listUrl = "${ctx}/modelsLibrary/toModelsListPage?menuIndex="+menuIndex;
                            jAlert(data.data,listUrl);
                        }else{
                            jAlert(data.msg);
                        }
                    }
                });
            }
        }
    }



    //异步获取echars数据
    function getLineChartData(programId,arithmeticId,index){
        var loader = document.getElementById('loader');
        loader.style.display = 'block';
        $.ajax({
            url : "${ctx}/modelsReport/getLineChartData",
            type : 'POST',
            data : {
                "programId":programId,
                "arithmeticId":arithmeticId
            },
            success : function(data) {
                creatLineChar(data,index);
                loader.style.display = 'none';
            }
        });
    }

    //异步获取echars数据
    function getModelIVListData(programId,arithmeticId,index){
        $.ajax({
            url : "${ctx}/modelsReport/getModelIVListData",
            type : 'POST',
            data : {
                "programId":programId,
                "arithmeticId":arithmeticId
            },
            success : function(data) {
                creatIVChar(data,index);
            }
        });
    }
    //处理echars数据
    var xArr = new Array();
    var totalArr = new Array();
    var perArr = new Array();
    function creatIVChar(data,index){
        if(!isNull(data)){
            data = eval(data);
            var len = data.length;
            $(".linebar_IV_chart_"+index).html("");
            for(var i=0;i<len;i++){
                var htmlContent = "";
                htmlContent += '<div class="linebar-mixed mLinebar-mixed">';
                htmlContent += '<div class="linebar-mixed-top">'+data[i].varName+'</div>';
                htmlContent += '<div class="linebar-mixed-legend"><i></i><span>样本数量</span><b></b><span>正样本率</span></div>';
                htmlContent += '<div class="linebar-mixed-chart" id="mlinebar_IV_chart_'+index+'_'+i+'"></div>';
                htmlContent += '</div>';
                $(".linebar_IV_chart_"+index).append(htmlContent);
                xArr = new Array();
                totalArr = new Array();
                perArr = new Array();
                xArr = (data[i].bins).split("=");
                totalArr = (data[i].total).split("=");
                perArr = (data[i].badPer).split("=");;
                var id = "mlinebar_IV_chart_"+index+"_"+i;
                loadIVCharts(xArr,totalArr,perArr,id);
            }
        }
        divTopHidden(index);
    }

    function loadIVCharts(xArr,totalArr,perArr,id){
        var myChart = echarts.init(document.getElementById(id));
        //显示echarts
        var option = {
            title: {show:false},
            color:['#028de2','#fcdc6f'],
            grid:[{
                left: 60,bottom: 30,right: 70,top: 50
            }],
            //                        tooltip:{show:true,trigger:'axis'},
            tooltip: {
                trigger: 'axis',
                formatter: function (params, ticket, callback) {
                    //x轴名称
                    var name = params[0].name;
                    //图表title名称
                    var seriesName = params[0].seriesName;
                    //值
                    var value = params[0].value;
                    //图表title名称
                    var seriesName1 = params[1].seriesName;
                    //值
                    var value1 = parseFloat((params[1].value)*100).toFixed(2)+'%';
                    return name+'<br /><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + params[0].color + '"></span>' + seriesName + ': '+value+'<br /><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + params[1].color + '"></span>'+ seriesName1 + ': '+value1+'<br />'
                }
            },
            legend:{show:false},
            xAxis:{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff'},
                data:xArr
            },
            yAxis:[{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff',margin: 60,textStyle:{align:'left'}},
                splitLine:{show:false},

            },{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff'},
                splitLine:{show:false}
            }],
            series:[
                {
                    type: 'bar',
                    name: '样本数量',
                    barWidth: '30%',
                    data:totalArr
                },
                {
                    type: 'line',
                    name: '正样本率',
                    yAxisIndex:1,
                    symbol:'none',
                    data:perArr
                }
            ]
        };
        myChart.setOption(option);
    };

    //处理echars数据
    function creatLineChar(data,index){
        if(!isNull(data)){
            var lineMap1 = data.lineMap1;
            var lineMap2 = data.lineMap2;
            var lineMap3 = data.lineMap3;
            var lineMap4 = data.lineMap4;
            if(!isNull(lineMap1)){
                abscissa1 = lineMap1.line1Abscissa;
                roc_option_1 = [
                    {
                        type: 'line',
                        name:'tpr',
                        symbol:'none',
                        smooth:true,
                        data:lineMap1.line1Tpr
                    },
                    {
                        type: 'line',
                        name:'fpr',
                        symbol:'none',
                        smooth:true,
                        data:lineMap1.line1Ks
                    },
                    {
                        type: 'line',
                        name:'ks',
                        symbol:'none',
                        smooth:true,
                        data:lineMap1.line1Fpr
                    }
                ];
            }
            if(!isNull(lineMap2)){
                abscissa2 = lineMap2.line2Abscissa;
                roc_option_2 = [
                    {
                        type: 'line',
                        name:'auc',
                        symbol:'none',
                        smooth:true,
//                        markLine : {
//                            smooth:true,
//                            itemStyle : {
//                                normal: {
//                                    color:'#ff00ff',
//                                    borderWidth:1,
//                                    borderColor:'rgba(30,144,255,0.5)'
//                                }
//                            },
//                            data : [
//                                [{type : 'min',name: '最小值'}, {type : 'max',name: '最大值'}]
//                            ]
//                        },
                        data:lineMap2.line2Auc
                    }
                ];
            }
            if(!isNull(lineMap3)){
                abscissa3 = lineMap3.line3Abscissa;
                roc_option_3 = [
                    {
                        type: 'line',
                        name:'tpr',
                        symbol:'none',
                        smooth:true,
                        data:lineMap3.line3Tpr
                    },
                    {
                        type: 'line',
                        name:'fpr',
                        symbol:'none',
                        smooth:true,
                        data:lineMap3.line3Ks
                    },
                    {
                        type: 'line',
                        name:'ks',
                        symbol:'none',
                        smooth:true,
                        data:lineMap3.line3Fpr
                    }
                ];
            }
            if(!isNull(lineMap4)){
                abscissa4 = lineMap4.line4Abscissa;
                roc_option_4 = [
                    {
                        type: 'line',
                        name:'auc',
                        symbol:'none',
                        smooth:true,
                        data:lineMap4.line4Auc
                    }
                ];
            }
            for(var i = 4*index+1; i<4*index+5;i++){
                if(i == 4*index+1 || i == 4*index+3){
                    lineChart('chart_'+i,eval('roc_option_'+(i-4*index)),eval('abscissa'+(i-4*index)));
                }else{
                    lineChart1('chart_'+i,eval('roc_option_'+(i-4*index)),eval('abscissa'+(i-4*index)));
                }
            }
//            if(0 == index){
//                for(var i = 1; i<5;i++){
//                    if(i == 1 || i == 3){
//                        lineChart('chart_'+i,eval('roc_option_'+i),eval('abscissa'+i));
//                    }else{
//                        lineChart1('chart_'+i,eval('roc_option_'+i),eval('abscissa'+i));
//                    }
//                }
//            }else if(1 == index){
//                for(var i = 5; i<9;i++){
//                    if(i == 5 || i == 7){
//                        lineChart('chart_'+i,eval('roc_option_'+(i-4)),eval('abscissa'+(i-4)));
//                    }else{
//                        lineChart1('chart_'+i,eval('roc_option_'+(i-4)),eval('abscissa'+(i-4)));
//                    }
//                }
//            }else if(2 == index){
//                for(var i = 9; i<13;i++){
//                    if(i == 9 || i == 11){
//                        lineChart('chart_'+i,eval('roc_option_'+(i-8)),eval('abscissa'+(i-8)));
//                    }else{
//                        lineChart1('chart_'+i,eval('roc_option_'+(i-8)),eval('abscissa'+(i-8)));
//                    }
//                }
//            }
        }
    }

    /**
     * ROC/KS曲线
     */
    function lineChart(id,series,abscissa){
        console.log(abscissa)
        var myChart = echarts.init(document.getElementById(id));
        var option = {
            title: { show: false },
            backgroundColor:'none',
            color: ['#028de2','#54ca62','#fcdc6f'],
            grid:[{
                left: 25,right: 30,top: 10,bottom: 20
            }],
            tooltip:{show:true,trigger:'axis'},
            xAxis:{
                boundaryGap: false,
               /* axisLabel : {//坐标轴文本标签
                    show: true,
                    color: '#c0d7ff',
                    fontSize:12,
                    interval : 9,
                    showMinLabel:true,
                    showMaxLabel:true,
                    formatter:function(value){
                        console.log(value);
                        return value;
                    }
                },*/
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff',interval : 9},
                data:abscissa
            },
            yAxis:{
                max: 1,
                interval: 0.1,
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color:'#c0d7ff'},
                splitLine:{show:false}
            },
            series:series
        }
        myChart.setOption(option);
    };
    /**
     * ROC/KS曲线
     */
    function lineChart1(id,series,abscissa){
        console.log(abscissa)
        var myChart = echarts.init(document.getElementById(id));
        var option = {
            title: { show: false },
            backgroundColor:'none',
            color: ['#028de2','#54ca62','#fcdc6f'],
            grid:[{
                left: 25,right: 30,top: 10,bottom: 20
            }],
//            tooltip:{show:true,trigger:'axis'},
            xAxis:{
                boundaryGap: false,
                /* axisLabel : {//坐标轴文本标签
                 show: true,
                 color: '#c0d7ff',
                 fontSize:12,
                 interval : 9,
                 showMinLabel:true,
                 showMaxLabel:true,
                 formatter:function(value){
                 console.log(value);
                 return value;
                 }
                 },*/
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff',interval : 9},
                data:abscissa
            },
            yAxis:{
                max: 1,
                interval: 0.1,
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color:'#c0d7ff'},
                splitLine:{show:false}
            },
            series:series
        }
        myChart.setOption(option);
    };





    /**
     * 折现柱图混合图
     */
    function probabilityChart(id,dataList1,dataList2,dataList3,dataList4){
        var myChart = echarts.init(document.getElementById(id));
        var option = {
            title: {show:false},
            color:['#028de2','#fcdc6f','#e93e40'],
            grid:[{
                left: 70,bottom: 30,right: 70,top: 50
            }],
//            tooltip:{show:true,trigger:'axis'},
            tooltip: {
                trigger: 'axis',
                formatter: function (params, ticket, callback) {
                    //x轴名称
                    var name = params[0].name;
                    //图表title名称
                    var seriesName = params[0].seriesName;
                    //值
                    var value = params[0].value;
                    //图表title名称
                    var seriesName1 = params[1].seriesName;
                    //值
                    var value1 = parseFloat((params[1].value)*100).toFixed(2)+'%';
                    //图表title名称
                    var seriesName2 = params[2].seriesName;
                    //值
                    var value2 = parseFloat((params[2].value)*100).toFixed(2)+'%';
                    return name+'<br /><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + params[0].color + '"></span>' + seriesName + ': '+value+'<br /><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + params[1].color + '"></span>'+ seriesName1 + ': '+value1+'<br /><span style="display:inline-block;margin-right:5px;border-radius:10px;width:9px;height:9px;background-color:' + params[2].color + '"></span>'+ seriesName2 + ': '+value2+'<br />'
                }
            },
            legend:{show:false},
            xAxis:{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff'},
                data:dataList1
            },
            yAxis:[{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff'},
                splitLine:{show:false}
            },{
                axisLine:{lineStyle:{color: '#103763'}},
                axisTick:{lineStyle:{color: '#7c808c'}},
                axisLabel:{fontSize:12,color: '#c0d7ff'},
                splitLine:{show:false}
            }],
            series:[
                {
                    type: 'bar',
                    name: '样本数',
                    barWidth: '30%',
                    data:dataList2
                },
                {
                    type: 'line',
                    name: '实际正样本率',
                    yAxisIndex:1,
                    smooth:true,
                    symbol:'none',
                    data:dataList3
                },
                {
                    type: 'line',
                    name: '预测正样本率',
                    yAxisIndex:1,
                    smooth:true,
                    symbol:'none',
                    data:dataList4
                }
            ]
        };
        myChart.setOption(option);
    };


//  显示全部
//   获取dom
function divVarHidden(index) {
//    var loader = document.getElementById('loader');
//    loader.style.display = 'none';

    var sortBtn = document.getElementById('sSort_'+index);
    var sort = document.getElementById('show_sort_'+index);

    //  如果内容少，不要显示全部按钮
    if(sort.offsetHeight<130){
        sortBtn.style.display = 'none';
    }

    //    超过高度隐藏
    sort.style.overflow = 'hidden';

    var btnKey2 = 0;

    //  当为0时显示全部
    sortBtn.onclick = function(){
        btnKey2++;
        if(btnKey2 %2 == 1){
            sort.style.height = 124 + 'px';
            sortBtn.innerHTML = '显示全部';
        }else{
            sort.style.height = 'auto';
            sortBtn.innerHTML = '收　　起';
            if(sort.offsetHeight>130){
                sortBtn.style.display = 'block';
            }
        }
    }
}

function divTopHidden(index) {
//    var loader = document.getElementById('loader');
//    loader.style.display = 'none';

    var topBtn = document.getElementById('sTop20_'+index);
    var top20 = document.getElementById('show_top20_'+index);

    //  如果内容少，不要显示全部按钮
    if(top20.offsetHeight<780){
        topBtn.style.display = 'none';
    }

    //    超过高度隐藏
    top20.style.overflow = 'hidden';

    var btnKey1 = 0;

    //  当为0时显示全部
    topBtn.onclick = function(){
        btnKey1++;
        console.log(btnKey1);
        if(btnKey1 %2 == 1){
            top20.style.height = 770 + 'px';
            topBtn.innerHTML = '显示全部';
        }else{
            top20.style.height = 'auto';
            topBtn.innerHTML = '收　　起';
            if(top20.offsetHeight>780){
                topBtn.style.display = 'block';
            }
        }
    }
}


    //判空
    function isNull(data){
        if(null == data || "" == data || "undefined" == typeof(data)){
            return true;
        }else{
            return false;
        }
    }
</script>
</body>
</html>