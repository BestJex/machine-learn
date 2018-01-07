<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ include file="../commons/taglibs.jsp"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>创建账号</title>
    <link rel="stylesheet" href="${ctx}/resources/css/style.css">
    <script src="${ctx}/resources/js/main.js"></script>
</head>
<style type="text/css">
    .create-account .j-input {
        width: 271px;
    }
</style>
<script type="text/javascript">
    $(function() {
        $("#roleId_select_box").on("click", "li", function () {
            $("#roleId").val($(this).attr("data-id"));
        })

        $.validator.addMethod("isOnlyLoginName", function(value,element) {
            var loginName = $.trim($("#loginName").val());
            var flag = false;
            $.ajax({
                type : 'POST',
                url : '${ctx}/user/checkLoginName',
                async:false,
                data : {
                    "loginName" : loginName
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
        }, "此账户已存在，请尝试其它账户");
        $.validator.addMethod("checkLoginName", function(value,element) {
            var loginName = $.trim($("#loginName").val());
            //var reg=/^[a-zA-Z0-9]{8,18}$/;
            var reg=/^(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{1,18}$/
            var regg=/^[a-zA-Z]{1,18}$/
            if(reg.test(loginName) || regg.test(loginName)){
                return true;
            }else{
                return false;
            }
            return true;
        }, "18位以内,英文或英文加数字组合");
        $.validator.addMethod("checkName", function(value,element) {
            var name = $.trim($("#name").val());
            var reg=/^[\u4E00-\u9FA5]{1,18}(?:·[\u4E00-\u9FA5]{1,18})*$/;
            var regg=/^[a-zA-Z]{1,18}$/
            if(reg.test(name)==false && regg.test(name)==false){
                return false;
            }
            return true;
        }, "姓名必须为18位以内的英文或中文");
        $.validator.addMethod("isPassword2", function(value,element) {
            var password = $("#password").val();
            //var reg=/^[a-zA-Z0-9]{8,18}$/;
            var reg=/^(?=.*?[a-zA-Z])(?=.*?[0-9])[a-zA-Z0-9]{8,18}$/
            if(reg.test(password)==false){
                return false;
            }
            return true;
        }, "密码必须为8-18位,数字字母组合");
        $.validator.addMethod("passwordSame2", function(value,element) {
            var password = $("#password").val();
            var password2 = $("#password2").val();
            if (password == password2) return true;
            return false;
        }, "两次密码输入不一致");
        $.validator.addMethod("isRoleId", function(value,element) {
            var roleId = $("#roleId").val();
            if (null!=roleId&&""!=roleId&&"0000"!=roleId) return true;
            return false;
        }, "请选择角色");
        $.validator.addMethod("isMobPhone", function(value,element) {
            var passport = /(^1[34578]{1}[0-9]{9}$)/;
            return this.optional(element) || (passport.test(value));
        }, "请输入正确的手机号码");
        $.validator.addMethod("isEmail", function(value,element) {
            var passport = /^([0-9A-Za-z_\-])+(\.[0-9A-Za-z_\-]+)*@([0-9A-Za-z_\-])+((\.\w+)+)$/;
            return this.optional(element) || (passport.test(value));
        }, "请输入正确的电子邮箱");
        $("#userAdd").validate({
            ignore: "",
            rules: {
                loginName: {
                    required: true,
                    isOnlyLoginName:true,
                    checkLoginName: true
                },
                name:{
                    required: true,
                    checkName:true
                },
                password: {
                    required: true,
                    isPassword2:true
                },
                password2:{
                    required: true,
                    passwordSame2: true
                },
                roleId:{
                    isRoleId: true
                },
                phone:{
                    isMobPhone: true
                },
                email: {
                    isEmail: true
                }
            },
            messages: {
                loginName:{
                    required:"请输入账号"
                },
                name:{
                    required:"请输入姓名"
                },
                password: {
                    required: "请输入密码"
                },
                password2: {
                    required: "请确认密码"
                }
            },
            errorPlacement: function(error, element) {
                if(element.is("input[name=loginName]")){
                    error.appendTo($("#loginName_error"));
                }
                if(element.is("input[name=name]")){
                    error.appendTo($("#name_error"));
                }
                if(element.is("input[name=password]")){
                    error.appendTo($("#password_error"));
                }
                if(element.is("input[name=password2]")){
                    error.appendTo($("#password2_error"));
                }
                if(element.is("input[name=roleId]")){
                    error.appendTo($("#roleId_error"));
                }
                if(element.is("input[name=phone]")){
                    error.appendTo($("#phone_error"));
                }
                if(element.is("input[name=email]")){
                    error.appendTo($("#email_error"));
                }
            },
        });
    });



    //保存新增的用户
    var checksubmitflg = false;
    function saveAddUser(){
        if (checksubmitflg == true) {
            return false;
        }
        checksubmitflg = true;
        var href = "${ctx}/user/toUserManagerPage";
        if($("#userAdd").valid()){
            var loginName =$("#loginName").val();
            var name=$("#name").val();
            var password=$("#password").val();
            var roleId=$("#roleId").val();
            var phone=$("#phone").val();
            var email=$("#email").val();
            $.ajax({
                url : "${ctx}/user/doAdd",
                type : 'POST',
                data : {
                    "loginName":loginName,
                    "name":name,
                    "password":password,
                    "roleId":roleId,
                    "phone":phone,
                    "email":email
                },
                success : function(data) {
                    if (data.result == 1) {
                        jAlert("用户添加成功!",href);
                    } else {
                        checksubmitflg = false;
                        jAlert("用户添加失败!",href);
                    }
                }
            });
        }else{
            checksubmitflg = false;
        }
    }
</script>
<body>
<img id="website-bgImg" class="website-bg website-bg-show" src="${ctx}/resources/img/bg.jpg" alt="星空万象">
<!-- //网站背景 -->
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
                    <h3>用户管理</h3>
                    <p>用户管理>>创建用户</p>
                </div>
            </div>
            <!-- //main-header -->
            <div class="create-account">
                <form action="" class="create-account-form" id="userAdd">
                    <div class="form-item clearfix">
                        <label class="j-label">账号*</label>
                        <div class="form-item-content">
                            <input class="j-input" id="loginName" name="loginName" value="" placeholder="请输入账号" type="text" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="loginName_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">姓名*</label>
                        <div class="form-item-content">
                            <input class="j-input" id="name" name="name" value="" placeholder="请输入姓名" type="text" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="name_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">密码*</label>
                        <div class="form-item-content">
                            <input class="j-input" id="password" name="password" value="" placeholder="请输入密码" type="password" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="password_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">确认密码*</label>
                        <div class="form-item-content">
                            <input class="j-input" id="password2" name="password2" value="" placeholder="请确认密码" type="password" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="password2_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">角色*</label>
                        <div class="form-item-content">
                            <div class="j-select">
                                <i class="j-select-arrow"></i>
                                <input type="hidden" id="roleId"  name="roleId" value="0000">
                                <div class="j-select-placeholder">请选择</div>
                                <div class="j-select-options">
                                    <ul id="roleId_select_box">
                                        <li class="active" data-id="0000">请选择</li>
                                        <c:forEach var="item" items="${roleList }">
                                            <li data-id="${item.id }">${item.name }</li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                            <p class="form-item-err" id="roleId_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">手机号码</label>
                        <div class="form-item-content">
                            <input class="j-input" id="phone" name="phone" value="" placeholder="请输入手机号码" type="text" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="phone_error"></p>
                        </div>
                    </div>
                    <div class="form-item clearfix">
                        <label class="j-label">邮箱</label>
                        <div class="form-item-content">
                            <input class="j-input" id="email" name="email" value="" placeholder="请输入邮箱" type="text" onkeyup="this.value=this.value.replace(/^ +| +$/g,'')">
                            <p class="form-item-err" id="email_error"></p>
                        </div>
                    </div>
                    <div class="clearfix">
                        <a href="javaScript:saveAddUser();" ><span class="j-button create-account-submit" >确认</span></a>
                        <a href="${ctx}/user/toUserManagerPage" ><span class="j-button create-account-submit" >取消</span></a>
                    </div>
                </form>
            </div>
            <!-- //create-account -->
        </div>
        <!-- //main -->
    </div>
    <!-- //content -->
</div>
<!-- //j-container -->

</body>
</html>