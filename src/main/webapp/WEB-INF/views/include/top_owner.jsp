<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!-- <script type="text/javascript">
	var userLoginStatus = "로그인 상태 : " + "${loginUserBean.memberLogin}" + "\n"
						+ "계정 번호 : " + "${loginUserBean.memberNo}" + "\n"
						+ "계정 닉네임 : " + "${loginUserBean.nickName}" + "\n"
						+ "계정 아이디 : " + "${loginUserBean.memberID}" + "\n"
						+ "계정 비밀번호 : " + "${loginUserBean.memberPass}" + "\n"
						+ "계정 생년월일 : " + "${loginUserBean.dob}" + "\n"
						+ "계정 주소 : " + "${loginUserBean.address}" + "\n"
						+ "계정 성별 : " + "${loginUserBean.gender}" + "\n"
						+ "계정 이메일 : " + "${loginUserBean.email}" + "\n"
						+ "계정 폰번호 : " + "${loginUserBean.phoneNo}" + "\n"
						+ "계정 포인트 : " + "${loginUserBean.points}" + "\n"
						+ "계정 점주정보 : " + "${loginUserBean.storeName}" + "\n"
						+ "계정 선택점포 : " + "${loginUserBean.checkStore}" + "\n"
						+ "계정 권한 : " + " ${loginUserBean.memberRole}"
					
	function check() {
		alert(userLoginStatus)
	}
</script> -->

<link rel="stylesheet" href="${root }css/top_bar.css" />
<link rel="stylesheet" href="${root }css/font.css" />

<!-- top-bar section start -->
<div class="top-bar-body body-font">
	<div class="top-container top-fixed-section">
		
		<!-- Logo -->
		<div class="main-logo-section">
			<a class="brand-logo" href="${root}owner/owner_main">
				<img src="${root}image/Allday_Logo_02.png" />
			</a>
		</div>
		
		<!-- menu-bar-section start -->
		<div class="menu-bar-section">
				<ul class="menu-item-list">
					<div class="menu-item-wrapped">
						<div class="menu-item">
							<li class=""><a class="" href="${root}owner/owner_main">발주관리</a></li>
						</div>
						
						<div class="menu-item">
							<li class=""><a class="" href="${root}owner/owner_graph">매출관리</a></li>
						</div>
					</div>
				</ul>
			</div>

		<div class="myname-section">
			<div>${loginUserBean.storeName}</div>
		</div>

		<!-- 로그인 드롭다운바 -->
		<div class="login-wrapped" >
			<a class="login-text">Account</a>
			<ul class="login-dropdown">
				<c:choose>
					<c:when test="${loginUserBean.memberLogin == false}">
						<li class="login-dropdown-item"><a href="${root}member/login_main">로그인</a></li>
						<li class="login-dropdown-item"><a href="${root}member/register_main">회원가입</a></li>
						<li class="login-dropdown-item"><solid> </solid></li>
						<li class="login-dropdown-item"><a href="${root}find_acc/find_id">아이디 찾기</a></li>
					    <li class="login-dropdown-item"><a href="${root}find_acc/find_pw">비밀번호 찾기</a></li>
					</c:when>
					<c:otherwise>
						<li class="login-dropdown-item"><a href="${root}member/logout">로그아웃</a></li>
						<li class="login-dropdown-item"><solid> </solid></li>
						<li class="login-dropdown-item"><a href="${root}usermypage/MyPageMain">마이페이지</a></li>
						<c:choose>
							<c:when test="${loginUserBean.storeName != null}">
								<li class="login-dropdown-item"><a href="${root}main">메인 페이지</a></li>
							</c:when>
						</c:choose>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	</div>
</div>