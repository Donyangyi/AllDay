<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
	<head>
	    <meta charset="UTF-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1">
	    <title> AllDay :: COMMUNITY </title>
	    <link rel="stylesheet" href="${root}css/board_main.css" />
	    <link href="${root }css/styles.css" rel="stylesheet" />
		<style>
		body {
			margin: 0 auto;
			padding: 0;
			font-family: Yeongdeok Sea;
		}
		
		.more-button {
		   display: flex;
		   justify-content: center;
		   align-items: center;
		}
		</style>
		
		
	</head>
	<body>
		<!-- topbar -->
		<c:import url="/WEB-INF/views/include/top.jsp" />

		<div class="board-wrapped">	
			<!-- 커뮤니티 섹션 -->
			<div class="board-container">
				<div class="main-title">
					<span>COMMUNITY</span>
				<!-- 여기에 추가적인 커뮤니티 섹션 내용 -->
				</div>
	
				<!-- 게시판 미리보기 부분 -->
				<div class="board-card-container">
					<c:forEach var="sub_list" items="${list}" varStatus="idx">
						<div class="card-wrapped">
							<div class="card-body">
								<div class="board-title">
									<span>${board_list[idx.index].boardName}</span>
								</div>
								
								<div class="card-table" id='board_list'>
									<div class="card-title">
										<span class="card-title-text content-number">글번호</span>
										<span class="card-title-text content-title">제목</span>
										<span class="card-title-text content-date">작성날짜</span>
									</div>
									
									<div class="card-content">
										<table>
											<c:forEach var="obj" items="${sub_list}">
												<tr>
													<td class="content-line card-content-text content-number">${obj.postNo}</td>
													<td class="content-line card-content-text content-title"><a href='${root }board/read?boardNo=${board_list[idx.index].boardNo}&postNo=${obj.postNo}&page=1'>${obj.title}</a></td>
													<td class="content-line card-content-text content-date">${obj.creationDate}</td>
												</tr>
											</c:forEach>
										</table>
		                     		</div>
		                     		<span class="more-button">
										<a href="${root }board/board_detail?boardNo=${board_list[idx.index].boardNo}" class="board-btn">더보기</a>
									</span>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		
	<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>
		
	</body>


	
</html>
