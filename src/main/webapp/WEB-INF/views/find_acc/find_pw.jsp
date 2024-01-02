<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<form:form modelAttribute="findMemberPWBean" action="${root }find_acc/find_pw_pro" method="post">

아이디 : <form:input path="MemberID" type="text"/><br />
이름 : <form:input path="MemberName" type="text"/><br />
<form:button type="submit">비밀번호 찾기</form:button>

</form:form>

</body>
</html>