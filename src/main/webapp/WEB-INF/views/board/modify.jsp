<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>수정하기</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

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
					<form:form action="${root }board/modify_pro" method="post" modelAttribute="modifyPostBean" enctype="multipart/form-data">
						<form:hidden path="postNo"/>
						<form:hidden path="boardNo"/>
						<input type="hidden" name="page" value="${page}"/>
							<div class="form-group">
								<form:label path="memberName">작성자</form:label>
								<form:input path="memberName" class='form-control' readonly="true" />
							</div>

							<div class="form-group">
								<form:label path="creationDate">작성날짜</form:label>
								<form:input path="creationDate" class='form-control' readonly='true' />
							</div>

							<div class="form-group">
								<form:label path="title">제목</form:label>
								<form:input path="title" class='form-control' />
								<form:errors path="title" style='color:red' />
							</div>

							<div class="form-group">
								<form:label path="postContent">내용</form:label>
								<form:textarea path="postContent" class="form-control"	rows="10" style="resize:none" />
								<form:errors path="postContent" style='color:red' />
							</div>
							<div class="form-group">
							<label for="board_file">첨부 이미지</label> 
                        	<c:if test="${modifyPostBean.attachment != null}">
								<img src="${root }upload/${modifyPostBean.attachment}" width="100%"/>
								<form:hidden path="attachment"/>
							</c:if>
							<form:input type="file" path="uploadAttachment" class="form-control" accept="image/*"/>
										
						</div>
						<div class="form-group">
							<div class="text-right">
								<form:button class="btn btn-primary">수정완료</form:button>
								<a href="${root}board/read?boardNo=${boardNo}&postNo=${postNo}&page=${page}" class="btn btn-info">취소</a>
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

