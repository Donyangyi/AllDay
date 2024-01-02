<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>  




<!-- location_Sidebar -->
<div class="sidebar" align="center" >
   	<a href="${root}mypage/mypage_main">개인정보수정</a>
   	<a href="${root}mypage/mypage_paylist">결제내역</a>
   	<a href="${root}mypage/mypage_basket">장바구니</a>
</div>




