<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!--내 주변매장 페이지임, 지점정보 클릭시 바로 내 주변매장 페이지로 이동  -->
<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>AllDay</title>
		<link href="${root }css/styles.css" rel="stylesheet" />
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
	</head>
	<body>
	<!--기본요소  -->
		<c:import url="/WEB-INF/views/include/top.jsp"/>
		<c:import url="/WEB-INF/views/include/location_sidebar.jsp"/>
	
	<!--본문  -->
		<h3 align="center">지점위치</h3>
		<h3 align="center">지도 aPI 사용</h3>
		

	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
  </body>
</html>