<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>  




<!-- location_Sidebar -->
<div class="sidebar" align="center" >
   	<a href="${root}event/event_main">진행 중인 이벤트</a>
   	<a href="${root}event/event_end">종료된 이벤트</a>
   	<a href="${root}event/event_winning">당첨자 발표</a>
</div>




