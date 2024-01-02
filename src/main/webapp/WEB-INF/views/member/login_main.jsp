<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPage</title>
<link href="${root}css/login.css" rel="stylesheet">
<style type="text/css">
	body{
		font-family: Yeongdeok Sea;
	}
</style>
</head>
<body>

	<div class="container">
        <div class="logo">
            <a href="${root}main" target="_self">
                <img src="${root}image/Allday_Logo.png" alt="Logo">
            </a>
        </div>
        <div class="login-wrapper">
			<h2 style="text-align: left;">Login</h2>
			<c:if test="${fail==true}">
				<h3 style="display: flex;">로그인 실패</h3>
			</c:if>
			<form:form modelAttribute="tempLoginMemberBean" action="${root}member/login_pro" id="login-form" method="post">
				<form:input path="memberID" placeholder="ID" /> 
				<form:errors path="memberID" style="color:red;"></form:errors>
				<form:password path="memberPass" placeholder="Password" />
				<form:errors path="memberPass" style="color:red;"></form:errors>
				<label  for="remember-check"> 
					<!-- <input  type="checkbox" id="remember-check">아이디 저장하기 -->
				</label> 
				<input type="submit" value="Login" />
			</form:form>
			<form action="${root}member/register_main" id="login-form" method="get">
			<input type="submit" value="회원가입" style="margin-top: -10px; background-color: #6E6E78"/>
			</form>
        </div>
    </div>
</body>
</html>