<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>AllDay</title>
	
	<link href="${root }css/main_section.css" rel="stylesheet" />
	<link rel="stylesheet" href="${root }css/font.css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- <script src="https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.0.0/bundles/stomp.umd.min.js"></script> -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js" integrity="sha512-1QvjE7BtotQjkq8PxLeF6P46gEpBRXuskzIVgjFpekzFVF4yjRgrQvTG1MTOJ3yQgvTteKAcO7DSZI92+u/yZw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- <script src="/webjars/jquery/jquery.min.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script> -->
    <link href="${root }css/styles.css" rel="stylesheet" />
	
	<style>
		body {
			margin: 0 auto;
			padding: 0;
			margin-top: 120px;
			font-family: Yeongdeok Sea;
		}
		
		.subindex_greenbox {
			padding: 16px 17px 0;
			border-radius: 12px;
			box-shadow: 2px 2px 14px 0 rgba(0, 164, 73, .08);
			background-color: #fff;
			box-sizing: border-box;
			border: 1px solid #642FD5; /* 변경된 부분 */
			border-radius: 12px;
		}
		
	</style>
	
	<script>
	/*
    $(document).ready(function() {
        $("#sendMessage").click(function() {
            var userMessage = $("#message").val();
            $.ajax({
                url: "${root}chatbot", // 서버의 엔드포인트 URL
                type: "POST",
                contentType: "application/x-www-form-urlencoded; charset=UTF-8", // 데이터 형식 지정
                data: { message: userMessage }, // 'message' 매개변수 사용
                dataType: "json",
                success: function(response) {
                    $("#chat").append("<div>User: " + userMessage + "</div>");
                    $("#chat").append("<div>Bot: " + response + "</div>");
                },
                error: function(xhr, status, error) {
                    $("#chat").append("<div>Error: " + error + "</div>");
                }
            });
        });
    });
	*/
	
	$(document).ready(function() {
	    $("#sendMessage").click(function() {
	        var userMessage = $("#message").val();
	        $.ajax({
	            url: "${root}chatbot", // 서버의 엔드포인트 URL
	            type: "POST",
	            contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	            data: { message: userMessage }, 
	            dataType: "json", // 응답 타입을 JSON으로 설정
	            success: function(response) {
	                // JSON 응답 처리
	                $("#chat").append("<div>User: " + userMessage + "</div>");
	                $("#chat").append("<div>Bot: " + response.content + "</div>"); // JSON 필드에 접근하여 표시

	                // 입력란 비우기
	                $("#message").val('');
	            },
	            error: function(xhr, status, error) {
	                $("#chat").append("<div>Error: " + error + "</div>");
	            }
	        });
	    });
	});
</script>
</head>

<!-- top 상단바 부분 import -->
<c:import url="/WEB-INF/views/include/top.jsp" />

<body>
<div>
	<div class="container">
		<!-- search-bar-section start -->
      <div class="search-bar-section">
         <form action="${root}product/product_main" method="get" class="search-bar" role="search">
            <input class="search-bar-input" type="text" name="keyword"
               placeholder="   검색어를 입력해주세요" style="height: 55px;">
            <button class="search-button" type="submit" style="height: auto;">Search</button>
         </form>
      </div>
      <!-- search-bar-section end -->

	<!-- 이벤트상품(carousel) -->
		<div class="main-event-carousel">
			<div class="card-shadow">

				<div class="image-carousel" id="myCarousel">
					<div class="image-section" id="imageSection">
						<div class="image-wrapper">
							<img src="${root}image/event/12_event_3.jpg" alt="Slide 3">
						</div>
						<div class="image-wrapper">
							<img class="slide-img" src="${root}image/event/12_event_1.jpg"
								alt="Slide 1">
						</div>
						<div class="image-wrapper">
							<img src="${root}image/event/12_event_2.jpg" alt="Slide 2">
						</div>
						<div class="image-wrapper">
							<img src="${root}image/event/12_event_3.jpg" alt="Slide 3">
						</div>
						<div class="image-wrapper">
							<img src="${root}image/event/12_event_1.jpg" alt="Slide 1">
						</div>
					</div>
				</div>

				<div class="carousel-btn-wrapped">
					<button class="carousel-btn carousel-btn-prev"
						onclick="prevSlide()">&lt;</button>
					<button class="carousel-btn carousel-btn-next"
						onclick="nextSlide()">&gt;</button>
				</div>

				<div class="carousel-indicators" id="carouselIndicators">
					<div class="carousel-indicator" onclick="currentSlide(0)"></div>
					<div class="carousel-indicator" onclick="currentSlide(1)"></div>
					<div class="carousel-indicator" onclick="currentSlide(2)"></div>
				</div>
			</div>
		</div>


		<!-- 상품목록 -->
		<div class="product-container" style="margin-bottom: 30px;">

			<div class="pop-up-title">
				<span>인기상품 TOP4</span>
			</div>
			
			<div class="pop-up-product-wrapped">
				<c:forEach items="${soldProducts}" var="obj">
					<div class="pop-up-product-section">
						<a href="${root}product/product_detail?productNo=${obj.productNo}" class="pop-up-product-link">
							<img src="${root}image/${obj.productImage}" class="pop-up-product-image">
							<span class="pop-up-product-name">${obj.productName}</span>
						</a>
					</div>
				</c:forEach>
			</div>
			
			
			<div class="pop-up-title">
				<span>Chat Bot</span>
			</div>

			<div class="container subindex_greenbox"
				style="margin: auto; min-height: 200px; display: flex;">
				<!-- 챗봇 응답 표시 영역 -->
				<div id="chat" style="height: 200px; overflow-y: auto;"></div>
			</div>
			<!-- 챗봇 입력 폼 -->
			<div class="chatbot-form" style="margin-top: 10px;">
				<input class="search-bar-input" style="height: 40px; width: 92%; border-radius: 12px 0px 0px 12px;" type="text" id="message" placeholder="메시지를 입력하세요">
				<button class="search-button" style="height: 40px; border-radius: 0px 12px 12px 0px; padding-top: inherit;" id="sendMessage" >Send</button>
			</div>

		</div>
	
	</div>
	<!-- bottom 하단바 부분 import -->
	
	<script src="${root }js/main_carousel.js"></script>
	<c:import url="/WEB-INF/views/include/bottom.jsp" />
</body>

</html>