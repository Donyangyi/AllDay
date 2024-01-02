<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<body>
    
<c:import url="/WEB-INF/views/include/top.jsp"></c:import>

<div class="container" style="margin-top:100px">
    <div class="row">
        <div class="col-sm-8">
            <div class="card shadow">
                <div class="card-body">
                    <div class="form-group">
                        <label for="board_writer_name">작성자</label>
                        <input type="text" id="board_writer_name" name="board_writer_name" class="form-control" value="홍길동" disabled="disabled"/>
                    </div>
                    <div class="form-group">
                        <label for="board_date">작성날짜</label>
                        <input type="text" id="board_date" name="board_date" class="form-control" value="2018-7-20" disabled="disabled"/>
                    </div>
                    <div class="form-group">
                        <label for="board_subject">제목</label>
                        <input type="text" id="board_subject" name="board_subject" class="form-control" value="제목입니다" disabled="disabled"/>
                    </div>
                    <div class="form-group">
                        <label for="board_file">본문</label>
                        <img src="${root }image/imyong3.png" width="100%"/>   
                        <textarea id="board_content" name="board_content" class="form-control" rows="10" style="resize:none" disabled="disabled">본문입니다</textarea>
                    </div>
                    <div class="form-group">
                        <div class="text-right">
                            <a href="${root }nt_board/request_board" class="btn btn-primary">목록보기</a>
                            <a href="${root }board/modify" class="btn btn-info">수정하기</a>
                            <a href="${root }board/delete" class="btn btn-danger">삭제하기</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-4">
            <div class="card shadow">
                <div class="card-body">
                    <h5 class="card-title">댓글</h5>
                    <div class="form-group">
                        <label for="comment_writer_name">작성자</label>
                        <input type="text" id="comment_writer_name" name="comment_writer_name" class="form-control" />
                    </div>
                    <div class="form-group">
                        <label for="comment_content">댓글 내용</label>
                        <textarea id="comment_content" name="comment_content" class="form-control" rows="4" style="resize:none"></textarea>
                    </div>
                    <button class="btn btn-primary" onclick="saveComment()">댓글 등록</button>
                </div>
            </div>

            <!-- 임시로 저장된 댓글을 표시할 영역 -->
            <div id="commentList" class="mt-4"></div>
        </div>
    </div>
</div>

<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

<script>
    // 임시로 댓글을 저장할 배열
    var comments = [];

    // 댓글을 저장하는 함수
    function saveComment() {
        var writer = $("#comment_writer_name").val();
        var content = $("#comment_content").val();

        // 간단한 유효성 검사
        if (writer && content) {
            // 댓글 객체를 만들어 배열에 추가
            var comment = {
                writer: writer,
                content: content
            };
            comments.push(comment);

            // 저장된 댓글을 화면에 표시
            displayComments();

            // 입력 필드 초기화
            $("#comment_writer_name").val('');
            $("#comment_content").val('');
        } else {
            alert("작성자와 내용을 모두 입력하세요.");
        }
    }

    // 저장된 댓글을 화면에 표시하는 함수
    function displayComments() {
        var commentListHtml = "<ul>";
        for (var i = 0; i < comments.length; i++) {
            commentListHtml += "<li><strong>" + comments[i].writer + ":</strong> " + comments[i].content + "</li>";
        }
        commentListHtml += "</ul>";

        // 저장된 댓글을 commentList 영역에 삽입
        $("#commentList").html(commentListHtml);
    }
</script>

</body>
</html>
