<%@ page language="java" pageEncoding="UTF-8"%>

<div class="header" id="header">
	<div class="header-content">
		<a class="header-logo" href="${ctx}/index"></a>
		<a class="logo-name" href="${ctx}/index">机器学习平台</a>
		<div class="header-crtl">
			<span class="header-crtl-arrow"></span>
			<ul class="header-crtl-list">
				<li onclick="logout();">退出</li>
			</ul>
		</div>
		<span class="login-name">${risk_crm_user.loginName}</span>
	</div>
</div>


<script type="text/javascript">
    //退出确认
    function logout() {
        $.post('${ctx}/logout', function(result) {
            window.location.href='${ctx }/login';
        }, 'json');
    }
</script>