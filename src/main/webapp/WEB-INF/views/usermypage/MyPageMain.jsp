<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />
<!-- 폼폼 태그 추가함  -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html style="height: 700px;">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="${root}css/account.min.css" rel="stylesheet">
<link rel="stylesheet" href="${root }css/font.css" />
<title>미니 프로젝트</title>

<!-- Bootstrap CDN 링크 추가 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script>
	
</script>
<style>
body {
	margin-top: 120px;
	font-family: Yeongdeok Sea;
}

.container {
	width: 50%;
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

.btn_accent {
	border: solid 1px rgba(0, 206, 113, 0.18);
	background-color: #642FD5; /* 변경된 부분 */
}

.btn_accent .text {
	color: white;
}

a {
	color: white;
	text-decoration: none;
	background-color: transparent;
	-webkit-text-decoration-skip: objects;
}

.subindex_onebox {
	position: relative;
	padding: 19px 17px 18px;
	border-radius: 12px;
	box-shadow: 1px 1px 10px 0 rgba(72, 75, 108, .08);
	border: 1px solid #642FD5;
	background-color: #fff;
	box-sizing: border-box;
}

.btn_accent, .btn_edit, .btn_logout {
	display: inline-block;
	min-width: 44px;
	padding: 2px 9px 3px;
	border-radius: 4px;
	border: 1px solid #642FD5;
	box-sizing: border-box;
	text-align: center;
	background-color: #642FD5; /* 추가된 부분 */
	border-radius: 12px;
}

@media ( min-width : 1024px) {
	.naverid .header {
		position: relative;
		display: table-cell;
		width: 395px;
		background-color: #fff;
		box-shadow: 1px 1px 10px 0 rgba(72, 75, 108, .08);
		border-left: 1px solid rgba(0, 0, 0, .08);
		border: 1px solid #642FD5; /* 보라색 테두리 추가 */
		vertical-align: top;
		z-index: 1;
	}
}

.row_item .item_text {
	font-size: 18px;
	font-weight: 700;
	line-height: 24px;
	letter-spacing: -.2px;
	color: #303038;
}

.info_title .title_text {
	display: inline-block;
	font-size: 14px;
	font-weight: 700;
	line-height: 17px;
	letter-spacing: -.4px;
	color: #303038;
}

.profile_area {
	padding: 2px 20px 8px;
	text-align: center;
	box-sizing: border-box
}

.everyday {
	position: relative;
	height: 48px;
	padding: 13px 10px 10px 56px;
	box-sizing: border-box;
	border-radius: 12px;
}

@media ( min-width : 1024px) {
	.naverid .container {
		display: table-cell;
		width: 100%;
		vertical-align: top;
	}
}

thead, tfoot {
	background-color: #642FD5;
	color: #fff;
}

tbody {
	background-color: #e4f0f5;
}

caption {
	padding: 10px;
	caption-side: bottom;
}

table {
	border-collapse: collapse;
	border: 2px solid rgb(200, 200, 200);
	letter-spacing: 1px;
	font-family: sans-serif;
	font-size: 0.8rem;
}

th {
	border: 1px solid #642FD5;
	border-color: white;
	padding: 12px 9px;
	font-size: 1.2rem;
	font-family: Yeongdeok Sea;
}

td {
	border: 1px solid #642FD5;
	padding: 10px 20px; /* 간격을 늘리기 위해 padding을 늘립니다. */
	font-size: 1.2rem; /* 필요한대로 글꼴 크기를 조절합니다. */
	background-color: white;
	font-family: Yeongdeok Sea;
}

.subindex_onebox1 {
	width: 100%;
	height: 500px;
	position: relative;
	padding: 19px 17px 18px;
	border-radius: 12px;
	box-shadow: 1px 1px 10px 0 rgba(72, 75, 108, .08);
	border: 1px solid #642FD5;
	background-color: #fff;
	box-sizing: border-box;
	font-family: Yeongdeok Sea;
}
</style>

</head>
<body>
	<!-- top bar -->
	<c:import url="/WEB-INF/views/include/top.jsp"></c:import>
	<div style="display: flex;">
		<div class="container" style="width: 50%;margin-left: 30px;height: 520px;">
			<div class="content">
				<div class="subindex_wrap" role="main">
					<div class="subindex_item">
						<div class="subindex_greenbox">
							<div class="info_title">
								<h3 class="title_text">기본보안설정</h3>
							</div>

							<ul class="subindex_row">
								<li>
									<div class="row_item lock">
										<span class="item_text">개인정보 변경</span>
										<button type="button" class="btn_edit"
											onclick="goChangePassword()">
											<span class="text"><a
												href="${root}usermypage/Ch_information">수정</a></span>
										</button>
									</div>
								</li>
							</ul>
						</div>
					</div>

					<div class="subindex_item">

						<div class="subindex_onebox">
							<div class="onebox_title">
								<h3 class="subindex_title">포인트 :
									${infoMemberBean.getPoints() }</h3>
							</div>
						</div>
					</div>

					<div class="subindex_item">
						<div class="subindex_onebox">
							<div class="onebox_title">
								<h2 class="subindex_title">장바구니</h2>
							</div>
							<div class="btn_right">
								<button type="button" class="btn_accent"
									onclick="nclk(this,'pmn.pprotectsetting','','',event);goPrivacyProtection()">
									<span class="text"><a href="${root}cart/cart_board">품목보기</a></span>
								</button>
							</div>
						</div>
					</div>

					<div class="subindex_item">
						<div class="subindex_onebox">
							<div class="onebox_title">
								<h2 class="subindex_title">찜목록</h2>
							</div>
							<button type="button" class="btn_accent"
								onclick="nclk(this,'pmn.sidsetting','','',event);changeSecretId()">
								<span class="text"><a href="${root}product/product_like">품목보기</a></span>
							</button>
						</div>
					</div>


					<div class="subindex_item">
						<div class="subindex_onebox">
							<div class="onebox_title">
								<h2 class="subindex_title">회원탈퇴</h2>
							</div>
							<div class="btn_right">
								<button type="button" class="btn_accent"
									onclick="nclk(this,'pmn.pprotectsetting','','',event);goPrivacyProtection()">
									<span class="text"><a href="${root}usermypage/withdraw">탈퇴하기</a></span>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="container" class="container"
			style="width: 50%;height: 520px;overflow-y: auto;">
			<div class="subindex_item">
				<div class="subindex_onebox1" style="height: 469px">
					<div class="onebox_title">
						<h2 class="subindex_title">결제내역</h2>
					</div>
					<div style="max-height: 410px; overflow-y: auto;">
						<table style="width: 100%;">
							<thead>
								<tr>
									<th scope="col" style="width: 100px;">닉네임</th>
									<th scope="col" style="width: 122px;">점포명</th>
									<th scope="col">상품명</th>
									<th scope="col">픽업예정시간</th>
									<th scope="col">픽업마감시간</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="item" items="${payAndReservationList}">
									<tr>
										<td>${infoMemberBean.getNickName() }</td>
										<td>${item.getStoreName()}</td>
										<td>${item.getProductName()}</td>
										<td>${item.getPickupDate() }</td>
										<td>${item.getPickupDeadline() }</td>
									</tr>
								</c:forEach>
							</tbody>

						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>

<c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

</html>