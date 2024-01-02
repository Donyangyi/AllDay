<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='root' value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>결제</title>

<!-- Bootstrap CDN -->
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous"></script>   
   
<style type="text/css">
	body{
		font-family: Yeongdeok Sea;
	}

	.priceTitle{
		width: 120px;
	}
	
	.deleteTitle{
		width: 150px;
	}
	
 	.nowishlist{
 		width: 100%;
 		/* text-align: center; */
		font-size: 18px;
		margin: 30px;
	}
	
	td img{
		width: 100px;
		height: 100px;
	}
	
	td>button {
		width: 120px;
		margin: 1px;
		border: 1px solid #642fd5;
		background: none;
		border-radius: 5px;
		color: #642fd5;
	}
	
	th, td {
		text-align: center;
	}
</style>
</head>
<body>

	<c:import url="/WEB-INF/views/include/top.jsp"></c:import>

	<div class="container" style="margin-top: 100px">

		<div class="row g-4 col-md-12">
			<div class="col-md-12">
				<div class="card shadow">
					<div class="card-body" style="min-height: 500px;">
					<h2>찜 목록 페이지</h2>
						<div class="form-product">
							<table class="table">
								<thead>
									<tr>
										<th scope="col" style="width: 100px;">번호</th>
										<th scope="col" style="width: 200px;">이미지</th>
										<th scope="col" style="width: 450px;">상품명</th>

										<th scope="col" class="priceTitle">가격</th>

										<th scope="col" class="deleteTitle">선택</th>
									</tr>
								</thead>
								<tbody>
								 	<!-- <tr>
								 	<td></td>
								 	<td></td>
										<td>
											<div class="nowishlist">찜한 상품이 없습니다.</div>
										</td>
								 	<td></td>
									</tr>  -->
									<c:choose>
										<c:when test="${empty showWish}">
											<tr>
											 	<td></td>
											 	<td></td>
												<td>
													<div class="nowishlist">찜한 상품이 없습니다.</div>
												</td>
										 		<td></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${showWish}" var="obj">
												<tr>
													<td>${obj.rownum}</td>
													<td><img src="${root}image/${obj.productImage}" alt="" /></td>
													<td>${obj.productName}</td>
													<td>${obj.retailPrice}</td>
													<td>
													<!-- 	<button onclick="location.href='{root}cart/cart_board'" id="cart_btn">장바구니담기</button> <br>
														<button onclick="location.href='{root}order/order_main'" id="order_btn">주문하기</button> <br> -->
														<!-- <button onclick="location.href='{root}product/product_delete'" id="delete_btn">삭제</button> -->
														<button onclick="location.href='${root}product/product_delete?productNo=${obj.productNo}'" id="delete_btn">삭제</button>
														
													</td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>
									 
									<!-- <tr>
										<td>2</td>
										<td>이미지2</td>
										<td>밈밈</td>

										<td>1,000</td>
									</tr> -->
									
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>
</body>
</html>


<%-- 
(완료)1. 마이페이지에서 찜목록 볼 수 있도록 주소 옮기기
(완료)2. 찜한 상품이 없습니다. -> 찜 추가시 리스트 형태로 늘려가기
(완료)3. 주문하기?장바구니담기? 경로 고치기
(완료)4. 찜 리스트에 이미지 추가하기
 --%>
<!-- 왼 - 가게주소(픽업장소) / 시간선택(팝업창? / max-오늘) / 주문자 / 주문상품(클릭시 상품상세페이지로 넘어가기) + 상품 더 담기(메인으로 이동) / 포장봉투선택(재사용/포장봉투/개인장바구니) / 주의사항(안가져가면 환불안해줌!) -->
<!-- 오 - 결제상세(금액) / 결제버튼(찐결제페이지 - 품절시(대체상품/부분취소/전체취소) / 결제수단(일반결제, 카드간편결제, 계좌 간편결제, 카카오or네이버etc)) -->