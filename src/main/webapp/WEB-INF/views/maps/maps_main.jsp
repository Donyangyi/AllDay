<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AllDay</title>

<link href="${root }css/maps.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>


<!-- style -->
<style>

body{
	margin-top:120px;
}




</style>
<script>
$(document).ready(function(){
    // 초기 상태: 모든 pic-container 숨기기
    $(".container").hide();
    
    // 초기값 설정: #pic-container-jonggak 보이기
    $("#pic-container-jonggak").show();

    // select 요소 값 변경 시 이벤트 처리
    $("#imageSelect").change(function(){
        // 모든 pic-container 숨기기
        $(".container").hide();

        // 선택된 옵션에 맞는 pic-container 표시
        var selectedOption = $(this).val();
        if(selectedOption == "option1"){
            // 종각역점 관련 div 표시
            $("#pic-container-jonggak").show();
        } else if(selectedOption == "option2"){
            // 신논현점 관련 div 표시
            $("#pic-container-shinnonhyeon").show();
        } else if(selectedOption == "option3"){
            // 고속터미널점 관련 div 표시
            $("#pic-container-express-terminal").show();
        }
    });
});
</script>
</head>

<!-- topBar import -->
<c:import url="/WEB-INF/views/include/top.jsp" />

<body> 

<div class="pic-select">
	<select name="imageSelect" id="imageSelect">
        <option value="option1">종각역점</option>
        <option value="option2">신논현점</option>
        <option value="option3">고속터미널점</option>
    </select>
</div>
 
<div class="container" id="pic-container-jonggak">
	
	<div class="pic-container">
		<img src="../image/maps/Jonggak.png" alt="" />
	</div>
	
	<div class="info-container">
		<div class="info-container-2">
			<table>
				<tr>
					<td><h6>점포명</h6></td>
					<td><h6>종각역점</h6></td>
				</tr>
				<tr>
					<td><h6>상세주소</h6></td>
					<td><h6>서울특별시 종로구 종로12길 20</h6></td>
				</tr>
				<tr>
					<td><h6>전화번호</h6></td>
					<td><h6>02-****-****</h6></td>
				</tr>
			</table>
		</div>
		<div class="find-container">
			<td><h6>오시는길</h6></td>
			<td><h6>오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길</h6></td>
		</div>
	</div>
</div>

<div class="container" id="pic-container-shinnonhyeon">
	
	<div class="pic-container">
		<img src="../image/maps/Sinnonhyeon.png" alt="" />
	</div>
	
	<div class="info-container">
		<div class="info-container-2">
			<table>
				<tr>
					<td><h6>점포명</h6></td>
					<td><h6>신논현점</h6></td>
				</tr>
				<tr>
					<td><h6>상세주소</h6></td>
					<td><h6>서울특별시 강남구 봉은사로 114</h6></td>
				</tr>
				<tr>
					<td><h6>전화번호</h6></td>
					<td><h6>02-****-****</h6></td>
				</tr>
			</table>
		</div>
		<div class="find-container">
			<td><h6>오시는길</h6></td>
			<td><h6>오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길</h6></td>
		</div>
	</div>
</div>

<div class="container" id="pic-container-express-terminal">
	
	<div class="pic-container">
		<img src="../image/maps/ExpressBusTerminal.png" alt="" />
	</div>
	
	<div class="info-container">
		<div class="info-container-2">
			<table>
				<tr>
					<td><h6>점포명</h6></td>
					<td><h6>고속터미널점</h6></td>
				</tr>
				<tr>
					<td><h6>상세주소</h6></td>
					<td><h6>서울특별시 서초구 신반포로 177</h6></td>
				</tr>
				<tr>
					<td><h6>전화번호</h6></td>
					<td><h6>02-****-****</h6></td>
				</tr>
			</table>
		</div>
		<div class="find-container">
			<td><h6>오시는길</h6></td>
			<td><h6>오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길오시는길</h6></td>
		</div>
	</div>
</div>


<%-- 
<!-- bottom 하단바 부분 import -->
<c:import url="/WEB-INF/views/include/bottom.jsp" />
 --%>
</body>

</html>