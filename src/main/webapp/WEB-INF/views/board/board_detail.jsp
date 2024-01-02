<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>하루종일 게시판</title>
<!-- Bootstrap CDN -->
<link href="${root }css/styles.css" rel="stylesheet" />
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>





<style>
	body {
		margin: 0 auto;
		padding: 0;
		font-family: Yeongdeok Sea;
	}
	
	.card-title{
		width:100%;
		justify-content: center;
		font-size: 16pt;
	
	
</style>


</head>
<body>
<!-- topbar -->
<c:import url="/WEB-INF/views/include/top.jsp"></c:import>
<!-- 게시글 리스트 -->
<div class="board-card-container" style="margin: 130px 300px 30px 300px ;">
   
         <h6 class="card-title" style="display: flex; font-size: 20pt">${boardName}</h6>
         <table class="table table-hover" id='board_list'>
            <thead>
               <tr>
                  <th class="text-center d-none d-md-table-cell">글번호</th>
                  <th class="w-50">제목</th>
                  <th class="text-center d-none d-md-table-cell">작성자</th>
                  <th class="text-center d-none d-md-table-cell">작성날짜</th>
               </tr>
            </thead>
            <tbody>
               <c:forEach items="${postList}" var="obj">
               <tr>
                  <td class="text-center d-none d-md-table-cell">${obj.postNo}</td>
                  <td><a href='${root}board/read?boardNo=${boardNo}&postNo=${obj.postNo}&page=${page}'>${obj.title}</a></td>
                  <td class="text-center d-none d-md-table-cell">${obj.memberName}</td>
                  <td class="text-center d-none d-md-table-cell">${obj.creationDate}</td>
               </tr>
               </c:forEach>
            </tbody>
         </table>
         
         <div class="d-none d-md-block">
            <ul class="pagination justify-content-center">
               <c:choose>
               <c:when test="${pageBean.prevPage <= 0}">
                  <li class="page-item disabled">
                     <a href="#" class="page-link">이전</a>
                  </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a href="${root}board/main?boardNo=${boardNo}&page=${pageBean.prevPage}" class="page-link">이전</a>
                  </li>
               </c:otherwise>
               </c:choose>
            
            <c:forEach var="idx" begin="${pageBean.min}" end="${pageBean.max}">
               <c:choose>
               <c:when test="${idx == pageBean.currentPage}">
                  <li class="page-item active">
                  <a href="${root}board/board_detail?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
               </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a href="${root}board/board_detail?boardNo=${boardNo}&page=${idx}" class="page-link">${idx}</a>
                  </li>
               </c:otherwise>
               </c:choose>
            </c:forEach>
               <c:choose>
               <c:when test="${pageBean.max >= pageBean.pageCnt }">
                  <li class="page-item disabled">
                     <a href="#" class="page-link">다음</a>
                  </li>
               </c:when>
               <c:otherwise>
                  <li class="page-item">
                     <a href="${root}board/main?boardNo=${boardNo}&page=${pageBean.nextPage}" class="page-link">다음</a>
                  </li>
               </c:otherwise>
               </c:choose>
            </ul>
         </div>
         <div class="text-right" style="display: flex; flex-direction: row-reverse;">
            <a href="${root}board/write?boardNo=${boardNo}" class="btn btn-primary">글쓰기</a>
         </div>
     	
</div>

<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>

</body>
</html>