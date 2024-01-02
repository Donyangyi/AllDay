<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<style>
body {
	margin-top: 120px;
	font-family: Yeongdeok Sea;
	position: relative; /* Relative positioning for body */
}

.btn-primary {
	color: #fff;
	background-color: #642FD5;
	border-color: #642FD5;
	font-family: Yeongdeok Sea;
}

.bottom-container {
	position: absolute;
	bottom: 0;
	width: 100%;
}
</style>
<body style="min-height: 0px;">
	<c:import url="/WEB-INF/views/include/top.jsp"></c:import>
	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root}withdraw_pro" method="post"
							modelAttribute="modifywithdrawMemberBean">
							<div class="form-group">
								<form:label path="memberPass">비밀번호</form:label>
								<form:input type="password" path="memberPass"
									class="form-control" />
								<form:errors path="memberPass" style="color:red" />
							</div>
							<div class="form-group">
								<div class="text-right">
									<form:button type="submit" class="btn btn-primary">회원 탈퇴</form:button>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Container at the bottom -->
	<div class="bottom-container" style="top: 400px;">
		<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>
	</div>
</body>
</html>
