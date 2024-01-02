<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>하루종일 게시판</title>
    <!-- Bootstrap CDN -->
    <link href="${root }css/styles.css" rel="stylesheet" />
	<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

    <!-- 추가된 CSS -->
    <style>
body {
	background-color: #f4f4f4; /* 배경색 추가 */
	font-family: Yeongdeok Sea;
}

#mainContent {
	margin: 20px auto; /* 상하 여백 추가 */
	max-width: 800px; /* 최대 너비 설정 */
	padding: 15px; /* 패딩 추가 */
	background-color: white; /* 배경색 */
	border-radius: 8px; /* 모서리 둥글게 */
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 그림자 추가 */
}

.card {
	margin-bottom: 20px; /* 카드 하단 여백 추가 */
}

.posts_left {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	padding: 15px;
	margin-bottom: 20px;
}

.comment, .comment_detail {
	margin-bottom: 10px;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
}

.btn-info {
	background-color: #17a2b8;
	border-color: #17a2b8;
}

.btn-danger {
	background-color: #dc3545;
	border-color: #dc3545;
}

/* 댓글 섹션 스타일 */
.comment-container {
	margin-top: 20px;
}

.form-control:disabled, .form-control[readonly] {
	background-color: white;
}

#commentSection {
	background-color: #ffffff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* 반응형 디자인 */
@media ( max-width : 768px) {
	#mainContent {
		margin: 10px;
		max-width: 100%;
	}
}

.comment_delete_button_container {
	text-align: right; /* 버튼을 오른쪽으로 정렬 */
}

.comment_delete_button:hover {
    background-color: #FE2E2E; /* 마우스 오버 시 배경색 변경 */
}
</style>
    <script type="text/javascript">
    	function addComment(){
    		var commentContent = document.getElementById('comment_content').value;
            var url = '${root}board/read_pro?boardNo=${boardNo}&postNo=${postNo}&page=${page}&comment_content=' + commentContent;
            location.href = url;
    	}
    	
    	
    	 // 페이지 로드 시 함수 초기화
        $(document).ready(function() {
            $('.comment_delete_button').click(function(){
                var commentNum = $(this).data('comment-no');
                var memberNum = $(this).data('member-no');

                $.ajax({
                    url: "${root}board/deleteComment?commentNo=" + commentNum + "&memberNo=" + memberNum
                    	/* "${root}board/deleteComment/" + commentNum + "/" + memberNum */,
                    type: "DELETE", 
                    success: function(result){
                        alert("댓글이 삭제 되었습니다!");
                        location.reload();
                    },
                    error: function(xhr, status, error){
                        /* alert("삭제 중 오류가 발생했습니다!" + xhr.status + xhr.statusText); */
                        if(xhr.status === 403){
                        	if(${loginUserBean.memberLogin} == false){
                        		// 서버가 403 Forbidden(권한부족) 반환 처리
                                alert('댓글을 삭제할 권한이 없습니다.');
                            	location.href='${root}member/login_main';
                        	} else {
                        		alert('댓글을 삭제할 권한이 없습니다.');
                        	}
                        } else{
                        	// 기타 오류 처리
                            alert('오류가 발생했습니다: ' + xhr.responseText);
                        }
                    }	
                });
            });
    	});
    	 
    </script>
    
</head>
<body>

<c:import url="/WEB-INF/views/include/top.jsp"></c:import>

<div class="container" style="margin-top:100px">
	<div class="row justify-content-center">
		
		<div class="col-sm-8">
			<div class="card shadow">
				<div class="card-body">
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="${readPostBean.memberName}" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="board_date" name="board_date" class="form-control" value="${readPostBean.creationDate}" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="board_subject" name="board_subject" class="form-control" value="${readPostBean.title}" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="board_content" name="board_content" class="form-control" rows="10" style="resize:none"  disabled="disabled">${readPostBean.postContent}</textarea>
					</div>
					
					<c:if test="${readPostBean.attachment != null}">
						<div class="form-group">
							<label for="board_file">첨부 이미지</label>
							<img src="${root }upload/${readPostBean.attachment}" alt="" width="100%"/>						
						</div>
					</c:if>
					<div class="form-group">
						<div class="text-right">
							<a href="${root }board/board_detail?boardNo=${boardNo}&page=${page}" class="btn btn-primary">목록보기</a>
							<c:if test="${loginUserBean.memberNo == readPostBean.memberNo}">
								<a href="${root }board/modify?boardNo=${boardNo}&postNo=${postNo}&page=${page}" class="btn btn-info">수정하기</a>
								<a href="${root }board/delete?boardNo=${boardNo}&postNo=${postNo}" class="btn btn-danger">삭제하기</a>
							</c:if>
						</div>
					</div>
				</div> 
			</div>
		</div>
		
		<div class="col-sm-8">
			<!-- 댓글 작성 블록 -->
		    <div id="commentSection" class="card mt-4 shadow">
		        <div class="card-body">
		            <h5 class="card-title">댓글</h5>
		            <div class="form-group">
		                <label for="comment_content">댓글 내용</label>
		                <textarea id="comment_content" name="comment_content" class="form-control" rows="4" style="resize:none"></textarea>
		            </div>
		            <button class="btn btn-primary" onclick="addComment()">댓글 등록</button>
		        </div>
		    </div>
		    <!-- 댓글 확인 블록 -->
			<c:forEach items="${commentBeans}" var="commentBean">
				<div class="posts_left">
					<div class="posts_comment">
						<div class="comment">
							<b >${commentBean.memberName}</b><br>
							<b >${commentBean.commentDate}</b>
						</div>
						<div class="comment_detail">
							<p>${commentBean.commentText}</p>
						</div>
			            <div class="comment_delete_button_container">
			                <button class="btn comment_delete_button" data-comment-no="${commentBean.commentNo}" data-member-no="${commentBean.memberNo}">삭제</button>
			            </div>
					</div>
				</div>
			</c:forEach>
		</div>
		
	</div>
</div>
    
<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

 <script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
		crossorigin="anonymous"></script>
		
</body>
</html>