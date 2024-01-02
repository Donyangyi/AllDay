<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>AllDay</title>
</head>
<body>

<form:form modelAttribute="findMemberIDBean" action="${root }find_acc/find_id_pro" method="post">

이름 : <form:input path="memberName" type="text" /><br>
이메일 : <form:input path="email" type="email" /><br>

<form:button type="submit" >아이디 찾기</form:button>

</form:form>

</body>
</html>