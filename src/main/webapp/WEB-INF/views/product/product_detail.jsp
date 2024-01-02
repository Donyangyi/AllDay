

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> --%>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!-- 상품 상세페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>하루종일편의점</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<script type="text/javascript">
/*
function toggleWishlist(productNo) {
    $.ajax({
        url: '${root}/product/toggleWishlist',
        type: 'POST',
        datatype: text,
        success: function(isAdded) {
            if (isAdded) {
                alert('상품이 찜 목록에 추가되었습니다.');
                // 찜 버튼의 상태 또는 텍스트를 변경하는 코드
                // 예: $('#like_btn').text('찜 해제');
            } else {
                alert('상품이 찜 목록에서 삭제되었습니다.');
                // 찜 버튼의 상태 또는 텍스트를 변경하는 코드
                // 예: $('#like_btn').text('찜하기');
            }
            // 찜 목록이 보여지는 부분을 업데이트하는 로직이 필요할 수 있습니다.
            // 예: updateWishlistUI();
        },
        error: function(error) {
            console.error(error);
            alert('오류가 발생했습니다.');
        }
    });
}

// 찜 목록 UI 업데이트 함수 (예시)
function updateWishlistUI() {
    // 찜 목록을 갱신하는 로직
    // 예: AJAX 요청을 통해 찜 목록을 다시 불러와서 표시
}
*/

/* 	function addProductToWishlist(productNo) {
		$.ajax({
			url : '',
			type : '',
			datatype : '',
			success : function() {

			}
		});
	}
 */
</script>

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${root }css/styles.css" rel="stylesheet" />
<style type="text/css">
body{
		font-family: Yeongdeok Sea;
	}
.prod_content {
	width: 1050px;
	/* border: 5px solid blue; */
	margin: auto;
	text-align: center;
	margin-top: 150px;
}

.prod_location {
	width: 975px;
	/* border: 2px solid red; */
	margin: 30px;
	display: inline-block;
	text-align: center;
}

.prod_img {
	width: 50%;
	/* 		width: 370px;
		height: 370px; */
	/* height: 300px; */
	/* border: 2px solid orange; */
	/* border-left: 1px orange; */
	border-right: gray solid 1px;
	float: left;
	/* overflow: auto; */
}

	.prod_location{
   		/* width:100%; */
   		/* display: inline-block; */
		/* border: 2px solid yellow; */
		text-align: center;
    }
 
	.img_location{
		list-style: none;
		display: inline-block;
		/* border: 2px solid orange; */
		padding: 0px;
		margin: 0px auto;
		width: 1005px;
	}

.prod_img img {
	width: 300px;
	height: 300px;
	/* border: 2px green solid; */
}

.prod_text {
	width: 50%;
	/* height: 300px; */
	/* border: 2px solid yellow; */
	font-family: 'Yeongdeok Sea';
	text-align: left;
	float: left;
	margin: 0px;
}

.prod_name {
	width: 100%;
	height: 70px;
	/* border: 2px solid purple; */
	margin-left: 20px;
	font-size: 30px;
	align-items: center;
}

.prod_price {
	width: 100%;
	height: 70px;
	/* border: 2px solid gray; */
	margin-left: 20px;
	font-size: 25px;
}

.prod_priceTitle, .prod_nutTitle{
	width: 20%;
	height: 100%;
	float: left;
	font-size: 20px;
	color: gray;
	/* border: 2px red solid; */
}

.prod_priceContent{
	
	height: 100%;
	float: left;
	font-weight: bold;
	font-size: 25px;
	margin: 0px;
	margin-top: -5px;
	padding: 0px;
	/* border: 2px yellow solid; */
}

.prod_quantityContent{
	height: 100%;
	float: left;
	
	font-size: 25px;
	margin-left: 30px;
	margin-top: -5px;
	padding: 0px;
	/* border: 2px yellow solid; */
}

.prod_nut {
	width: 100%;
	height: 70px;
	margin-left: 20px;
}
/* 
.prod_nutTitle{
	width: 100%;
	height: 100%;
	
}
 */
.prod_nutContent{
	width: 100%;
	height: 100%;
	font-size: 18px;
}

.prod_reservation {
	width: 100%;
	height: 70px;
	/* border: 2px solid olive; */
	margin-left: 20px;
	font-size: 18px;
}

#like_btn {
	width: 40px;
	height: 40px;
	border-radius: 40px;
	/* border-color: rgb(221, 221, 221);
    border-bottom-color: rgb(221, 221, 221);
    border-left-color: rgb(221, 221, 221);
    border-top-color: rgb(221, 221, 221);
    border-right-color: rgb(221, 221, 221); */
    background: none;
    border: 2px solid #6a24fe;
	margin: 0px;
}

.wishImg{
	width: 24px;
}

#reservation_btn {
	width: 150px;
	height: 40px;
	border-radius: 20px;
	margin-top: 40px;
	margin-left: 10px;
	border: none;
	background-color: #6a24fe;
	color: white;
	font-weight: bold;
	border-color: #6a24fe;
}

#cart_btn {
	width: 150px;
	height: 40px;
	border-radius: 20px;
	margin: 10px;
	background: none;
	border-color: #6a24fe;
	color: #6a24fe;
}

.prod_full {
	width: 975px;
	min-height: 100px;
	/* border: 2px solid maroon;  */
	/* font-size: 30px; */
	margin: 30px;
}

.nav {
	justify-content: center;
}
/* 	
	.prod_nut{
		width: 250px;
		border: 1px red;
		margin: 20px;
	} */
.recommend {
	padding-left: 65px;
	text-align: left;
	font-weight: bold;
	font-family: 'Yeongdeok Sea';
    font-size: 18px;
}

.prod_recLocation{

}

.img_recLocation{
	list-style: none;
	display: inline-block;
	/* border: 2px solid orange; */
	padding: 0px;
	padding-left: 40px;
	margin: 0px auto;
	width: 1005px;
}

.prod_recList {
	width: 200px;
	/* height: 350px; */
	/* border: 1px solid gray; */
	float: left;
	margin: 15px;
}
.prod_recList:hover {
		
	    box-shadow: 0 0 3px 3px lightgray;
	}

.prod_recItem {
	border: 1px black;
	/* background-color: yellow; */
	font-family: 'Yeongdeok Sea';
	
}

.prod_recImg {
	width: 150px;
	height: 170px;
	/* border: 1px solid black; */
	margin: 0px auto;
}

.prod_recImg img {
	width: 150px;
	height: 150px;
}

.prod_recText {
	width: 180px;
	height: 100px;
	/* border: 1px black; */
	font-size: 18px;
	border-top: 1px dotted;
	padding-top: 10px;
	margin: 0px auto;
}

.prod_recName {
	width: 180px;
	height: 40px;
	/* border: 1px black; */
	text-align: center;
	padding-bottom: 20px;
	margin: 0px;
}

.prod_recPrice {
	max-width: 180px;
	height: 20px;
	text-align: center;
}

.img_comment {
	width: 20px;
	height: 25px;
	align-items: center;
}
</style>


</head>
<body>

	<!-- 상단바 가져오기 -->
	<c:import url="/WEB-INF/views/include/top.jsp" />

	<!-- 사이드바 가져오기 -->
	<c:import url="/WEB-INF/views/include/product_sidebar.jsp" />

	<div class="prod_content">

		<div class="prod_location">
			<div class="prod_img">
				<img src="${root }image/${readProductBean.productImage}" />
			</div>
			<div class="prod_text">
				<div class="prod_name">
					
				
				${readProductBean.productName}</div>
				<div class="prod_price">
					<div class="prod_priceTitle">
						가격
					</div>
					<div class="prod_priceContent">
						${readProductBean.retailPrice} 원 
					</div>
					<div class="prod_quantityContent">
						(${readProductBean.stockQuantity} 개 남음)
					</div>
				</div>
				
				<div class="prod_nut">
					<div class="prod_nutTitle">
						영양정보
					</div>
					<div class="prod_nutContent">
						${readProductBean.nutrition}</div>						
					</div>
				
				<div class="prod_reservation">
				<!-- 
					<c:if test="${memberNo != null}">
						<%-- <button onclick="location.href='${root }product/product_like?productNo=${productNo}'" id="like_btn">찜</button> --%>
						<button onclick="toggleWishlist('${productNo}')" id="like_btn">
							<img alt="찜" src="${root}image/noheart.png">
						</button>
					</c:if>
				 -->
					
					<c:if test="${memberNo != null}">
					    <button onclick="toggleWishlist('${readProductBean.productNo}')" id="like_btn">
					        <img class="wishImg" src="${root}image/product_like/${wishlistImage}" alt="찜" />
					    </button>
					</c:if>
					<!-- 
					<c:if test="${memberNo != null}">
					    <button onclick="location.href='${root}product/toggleWishlist?productNo=${productNo}'" id="like_btn">
					        <c:choose>
					            <c:when test="${isWishlisted}">
					                <img alt="찜 해제" src="${root}image/heart.png">
					            </c:when>
					            <c:otherwise>
					                <img alt="찜" src="${root}image/noheart.png">
					            </c:otherwise>
					        </c:choose>
					    </button>
					</c:if>
					 -->
					<c:choose>
						<c:when test="${readProductBean.stockQuantity == 0}">
							<button id="reservation_btn" disabled="disabled">품절상품</button>
							<button onclick="location.href='${root}cart/cart_pro?productName=${readProductBean.productName}&retailPrice=${readProductBean.retailPrice}&stockQuantity=${readProductBean.stockQuantity}'"
							id="cart_btn" disabled="disabled">장바구니</button>
						</c:when>
						<c:otherwise>
							<button
								onclick="location.href='${root }customer_order/customer_order'"
								id="reservation_btn">구매하기</button>
							<button
								onclick="location.href='${root}cart/cart_pro?productName=${readProductBean.productName}&retailPrice=${readProductBean.retailPrice}&stockQuantity=${readProductBean.stockQuantity}'"
								id="cart_btn">장바구니</button>
						</c:otherwise>
					</c:choose>

					<%-- 					
					<button onclick="location.href='${root }customer_order/customer_order'" id="reservation_btn">예약하기</button>
					<button onclick="location.href='${root }cart/cart_pro?productName=${readProductBean.productName}&retailPrice=${readProductBean.retailPrice}'" id="cart_btn">장바구니</button>
 --%>
				</div>
			</div>
		</div>
		<div class="prod_full">
			<p class="recommend">이런 상품은 어떠신가요?</p>
			<%-- <table border="">
				<tr>
					<td>
						<div class="prod_nut">${readProductBean.nutrition}</div>
					</td>
				</tr>
			</table>
 --%>
			<div class="prod_recLocation">
				<ul class="img_recLocation">
					<c:forEach items="${recommProd}" var="obj">
						<li class="prod_recList">
							<div class="prod_recItem">
								<div class="prod_recImg">
									<a href="${root }product/product_detail?productNo=${obj.productNo}">
										<img src="${root}image/${obj.productImage}" class="recImgDetail" alt="상품이미지" />
									</a>
								</div>
								<div class="prod_recText">
									<div class="prod_recName">
										${obj.productName}
									</div>
									<div class="prod_recPrice">${obj.retailPrice}원</div>
								</div>
							</div>
						</li>
					</c:forEach>
				</ul>
			</div>

		</div>

	</div>
	
	<%-- 
	<!-- 하단바 가져오기 -->
	<c:import url="/WEB-INF/views/include/bottom.jsp" />
	 --%>
	 
	 
	 <script type="text/javascript">
	function toggleWishlist(productNo) {
	    $.ajax({
	        url: '${root}product/toggleWishlist/' + productNo,
	        type: 'GET',
	        dataType: 'json', // 예상되는 서버의 응답 데이터 유형
	        success: function(response) {
	            // 서버로부터 찜 여부에 따라 이미지를 변경합니다.
	            var imagePath = response.isWishlisted ? '${root}image/product_like/heart.png' : '${root}image/product_like/noheart.png';
	            $('#like_btn img').attr('src', imagePath);
	            console.log("성공은 했음 : ", imagePath)
	        },
	        error: function(xhr, status, error) {
	            console.error(xhr.status);
	        }
	    });
	}
	
	$(document).ready(function() {
	    var productNo = '${readProductBean.productNo}'; // 현재 페이지의 상품 번호
	    toggleWishlist(productNo);
	});
/*
	function checkWishlistOnLoad(productNo) {
	    $.ajax({
	        url: '${root}product/checkWishlist/' + productNo,
	        type: 'GET',
	        dataType: 'json',
	        success: function(response) {
	            var imagePath = response.isWishlisted ? '${root}image/product_like/heart.png' : '${root}image/product_like/noheart.png';
	            $('#like_btn img').attr('src', imagePath);
	        },
	        error: function(xhr, status, error) {
	            console.error("찜 확인 오류", xhr.status);
	        }
	    });
	}
*/
</script>
<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>
</body>

</html>

<%-- 상품 상세페이지에서 할 일
(완료)1. 영양정보 api 끌어오기
2. 댓글 기능 구현
(완료)3. 이미지, 상품명, 가격 받아서 넘어오기
(완료)4. if(재고수량==0)이라면 예약하기x 품절, 장바구니x 어둡게 터치불가능하게 disable? 기능
(완료)5. 찜 0->찜한 상품이 없습니다. 1~ -> 리스트 형식으로 추가 
 --%>