<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/" />

<script>

alert("회원님의 패스워드는"+"${findMemberPWBean.memberPass}"+"입니다.")
location.href="${root}member/login_main"

</script>