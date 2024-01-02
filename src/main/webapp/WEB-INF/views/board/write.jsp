<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>글쓰기</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
    
<style>
body{
	font-family: Yeongdeok Sea;
}
</style>
</head>
<body>

<c:import url="/WEB-INF/views/include/top.jsp"></c:import>

<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form:form action="${root}board/write_pro " method="post" modelAttribute="writePostBean" enctype="multipart/form-data">
					<div class="form-group">
					<form:hidden path="boardNo" />
						<form:label path="title">제목</form:label>
						<form:input path="title" class="form-control"/>
						<form:errors path="title" style="color:red;"></form:errors>
					</div>
							<div class="form-group">
								<form:label path="postContent">내용</form:label>
								<form:textarea path="postContent" class="form-control"	rows="10" style="resize:none" />
								<form:errors path='postContent' style='color:red' />
							</div>
							<div class="form-group">
								<form:label path="uploadAttachment">첨부 이미지</form:label>
								<form:input type='file' path='uploadAttachment' class="form-control" accept="image/*" />
							</div>
							<div class="form-group">
						<div class="text-right">
							<form:button type="submit" class="btn btn-primary">작성하기</form:button>
						</div>
					</div>
					
					</form:form>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>

<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

</body>
</html>
