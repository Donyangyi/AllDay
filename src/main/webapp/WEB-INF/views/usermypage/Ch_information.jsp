<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var='root' value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="${root}css/register.css" rel="stylesheet">
<title>회원 정보 수정</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						$("#address")
								.val(
										document
												.getElementById("sample6_address").value);

						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>
<style>
body {
	margin-top: 140px;
	margin-bottom: 140px;
}

body{
		font-family: Yeongdeok Sea;
	}

#postcodeButton {
	width: 100px;
	height: 30px;
	font-size: 14px; /* 원하는 글씨 크기로 조절하세요 */
}

#addressText {
	font-size: 14px; /* 원하는 주소 텍스트의 글씨 크기로 조절하세요 */
}

.card-body {
	 border: 2px solid #642FD5; /* 변경된 부분 */
	border-radius: 10px; /* 모서리를 둥글게 만듭니다. 원하는 값을 사용하세요 */
	padding: 20px; /* card-body의 크기 유지를 위해 padding 추가 */
}
</style>
</head>
<body>

	<c:import url="/WEB-INF/views/include/top.jsp"></c:import>

	<div class="container">
		<div class="row">
			<div class="col-sm-3"></div>
			<div class="col-sm-6">
				<div class="card shadow">
					<div class="card-body">
						<form:form action="${root}usermypage/Ch_information_pro"
							method="post" modelAttribute="modifyMemberBean">
							<div class="form-group">
								<form:label path="memberName">이름</form:label>
								<form:input path="memberName" class="form-control"
									readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="memberID">아이디</form:label>
								<form:input path="memberID" class="form-control" readonly="true" />
							</div>
							<div class="form-group">
								<form:label path="memberPass2">비밀번호 확인</form:label>
								<form:input type="password" path="memberPass2"
									class="form-control" />
								<form:errors path="memberPass2" style="color:red" />
							</div>
							<div class="form-group">
								<form:label path="memberPass">비밀번호 변경</form:label>
								<form:input type="password" path="memberPass"
									class="form-control" />
								<form:errors path="memberPass" style="color:red" />
							</div>
							<div class="form-group">
								<form:label path="nickName">닉네임 변경</form:label>
								<form:input type="text" path="nickName" class="form-control" />
								<form:errors path="nickName" style="color:red" />
							</div>
							<div>
								<h3 class="join_title">
									<form:label path="address">주소</form:label>
									<input type="button" id="postcodeButton"
										onclick="sample6_execDaumPostcode()" value="우편번호찾기">
								</h3>
								<span class="form-group"> <input type="text"
									id="sample6_postcode" class="int" placeholder="우편번호">
								</span>
							</div>

							<div>
								<span class="form-group"> <input type="text"
									id="sample6_address" class="int" placeholder="주소">
								</span>
							</div>

							<div>
								<span class="form-group"> <input type="text"
									id="sample6_detailAddress" class="int" placeholder="상세주소">
								</span>
							</div>

							<div>
								<span class="form-group"> <input type="text"
									id="sample6_extraAddress" class="int" placeholder="참고항목">
								</span> <span class="error_next_box"><form:errors path="address"></form:errors></span>
							</div>

							<!-- 숨겨진 필드 -->
							<form:hidden path="address" />

							<div class="form-group">
								<div class="text-right">
									<form:button type="submit" class="btn btn-primary">정보 수정</form:button>
								</div>
							</div>
						</form:form>
					</div>
				</div>
			</div>
			<div class="col-sm-3"></div>
		</div>
	</div>

	<c:import url="/WEB-INF/views/include/bottom.jsp" />

</body>
</html>