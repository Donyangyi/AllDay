<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath}/" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<link rel="stylesheet" href="${root}css/register.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script  type="text/javascript">

	function combineDate() {
		// 각 드롭다운에서 선택된 값을 가져오기
		var year = document.getElementById('yy').value
		var month = document.getElementById('mm').value
		var day = document.getElementById('dd').value
		
		// YYYY-MM-DD 형식으로 날짜를 결합
		var combinedDate = year + '-' + month + '-' + day
	
		// 결합된 날짜를 숨겨진 필드에 설정
		document.getElementById('combinedDate').value = combinedDate
	}
	
	function resetMemberId() {
	 		$("#checkMemberID").val('false')
	 }
	
	function check() {
		var member_id = $("#memberID").val();		//member_id라는 변수방에 
		if (member_id.length == 0) {
			alert("아이디를 입력해주세요.")
			return;
		}
	
		$.ajax({
			url: "${root}member/checkMemberID/" + member_id,
			//"${root}member/checkMemberID?member_id="+member_id;
			type: "get",
			dataType: "text",
			success: function(result) {
				if (result.trim() == "true") {
					alert("사용 가능한 아이디 입니다.")
					$("#checkMemberID").val("true")
				} else {
					alert("사용 불가능한 아이디 입니다.")
					$("#checkMemberID").val("false")
				}
			}
		})
	}
	
	function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
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
                $("#address").val(document.getElementById("sample6_address").value);
                
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
	
	IMP.init("imp04761130");
	const onClickCertification = async () => {
		
		var memberName = document.getElementById("name").value; // 이름 필드의 값
	    var phoneNo = document.getElementById("mobile").value; // 휴대전화 필드의 값
	    var year = document.getElementById('yy').value; // 생년월일 - 년
	    var month = document.getElementById('mm').value; // 생년월일 - 월
	    var day = document.getElementById('dd').value; // 생년월일 - 일

	    // 휴대전화 번호 형식 검사 정규식
	    var phoneRegex = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;

	    // 이름, 휴대전화, 생년월일 값 확인
	    if (!memberName) {
	        alert("이름을 입력해주세요.");
	        return;
	    }
	    if (!phoneNo.match(phoneRegex)) {
	        alert("휴대전화 번호를 '010-1234-5678' 형식으로 입력해주세요.");
	        return;
	    }
	    if (year === "년" || month === "월" || day === "일") {
	        alert("생년월일을 정확히 선택해주세요.");
	        return;
	    }
		
	    IMP.certification({
	        merchant_uid: "he213fdk" + new Date().getTime(),
	        name: memberName,
	        phone: phoneNo
	    }, function (response) {
	        console.log(response);
	        if (response.success) {
	            // 본인 인증 성공
	            isCertified = true;
	        } else {
	            // 본인 인증 실패
	            isCertified = false;
	        }
	    });
	};

	// 폼 제출 전 본인 인증 여부를 검사
	function validateForm() {
	    if (!isCertified) {
	        alert("본인 인증을 완료해주세요.");
	        return false; // 폼 제출 중단
	    }
	    return true; // 폼 제출 계속
	}
	
</script>

<style type="text/css">

body{
		font-family: Yeongdeok Sea;
	}
</style>

</head>
<body>
	<!-- header -->
	<div id="header">
		<a href="${root}main" target="_self">
			<img src="${root}image/Allday_Logo.png" id="logo">
		</a>
	</div>
	
	<form:form modelAttribute="registerBean" action="${root}member/register_pro" method="post" onsubmit="return validateForm()">
		<!-- wrapper -->
		<div id="wrapper">
			<!-- content-->
			<div id="content">
				<!-- ID -->
				<div>
					<h3 class="join_title">
						<form:label path="memberID">아이디</form:label>
					</h3>
					<span class="box int_id"> 
						<form:input path="memberID" class="int" maxlength="20" onkeypress="resetMemberId()"/> 
						<span class="step_url">
 							<button type="button" onclick="check()">중복확인</button>
						</span>
					</span> 
					<span class="error_next_box"><form:errors path="memberID"></form:errors></span>
				</div>
				
				<!-- PW1 -->
				<div>
					<h3 class="join_title">
						<form:label path="memberPass">비밀번호</form:label>
					</h3>
					<span class="box int_pass"> 
						<form:password path="memberPass" class="int" maxlength="20" /> 
					</span>
					<span class="error_next_box"><form:errors path="memberPass"></form:errors></span>
				</div>
	
				<!-- PW2 -->
				<div>
					<h3 class="join_title">
						<form:label path="memberPass2">비밀번호 재확인</form:label>
					</h3>
					<span class="box int_pass_check"> 
						<form:password path="memberPass2" class="int" maxlength="20" /> 
					</span>
					<span class="error_next_box"><form:errors path="memberPass2"></form:errors></span>
				</div>
	
				<!-- NAME -->
				<div>
					<h3 class="join_title">
						<form:label path="memberName">이름</form:label>
					</h3>
					<span class="box int_name"> 
						<form:input path="memberName" type="text" id="name" class="int" maxlength="20" /> 
						<span class="step_url">
 							<button type="button" onclick="onClickCertification()">본인인증</button>
						</span>
					</span> 
					<span class="error_next_box"><form:errors path="memberName"></form:errors></span>
				</div>
				
				<!-- MOBILE -->
				<div>
					<h3 class="join_title">
						<form:label path="phoneNo" >휴대전화</form:label>
					</h3>
					<span class="box int_mobile"> 
						<form:input path="phoneNo" type="tel" id="mobile" class="int" maxlength="16" placeholder="전화번호 입력" />
					</span> 
					<span class="error_next_box"><form:errors path="phoneNo"></form:errors></span>
				</div>
	
				<!-- BIRTH -->
				<div>
					<h3 class="join_title">
						<label for="yy">생년월일</label>
					</h3>
	
					<div id="bir_wrap">

						<!-- BIRTH_YY -->
						<div id="bir_yy">
							<span class="box"> 
							<select id="yy" class="sel">
								<option>년</option>
								<c:forEach var="year" begin="1950" end="2023">
									<option value="${year}">${year}</option>
								</c:forEach>
							</select>
							</span>
						</div>

						<!-- BIRTH_MM -->
						<div id="bir_mm">
							<span class="box"> 
								<select id="mm" class="sel">
										<option>월</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
								</select>
							</span>
						</div>

						<!-- BIRTH_DD -->
						<div id="bir_dd">
							<span class="box"> 
							 <select id="dd" class="sel">
									<option>일</option>
									<option value="01">01</option>
									<option value="02">02</option>
									<option value="03">03</option>
									<option value="04">04</option>
									<option value="05">05</option>
									<option value="06">06</option>
									<option value="07">07</option>
									<option value="08">08</option>
									<option value="09">09</option>
									<option value="10">10</option>
									<option value="11">11</option>
									<option value="12">12</option>
									<option value="13">13</option>
									<option value="14">14</option>
									<option value="15">15</option>
									<option value="16">16</option>
									<option value="17">17</option>
									<option value="18">18</option>
									<option value="19">19</option>
									<option value="20">20</option>
									<option value="21">21</option>
									<option value="22">22</option>
									<option value="23">23</option>
									<option value="24">24</option>
									<option value="25">25</option>
									<option value="26">26</option>
									<option value="27">27</option>
									<option value="28">28</option>
									<option value="29">29</option>
									<option value="30">30</option>
									<option value="31">31</option>
								</select>
							</span>
						</div>
						
						<!-- 숨겨진 필드 -->
						<form:hidden id="combinedDate" path="dob" />

					</div>
					<form:errors path="dob" class="error_next_box"></form:errors>
				</div>
				
				<!-- GENDER -->
				<div>
					<h3 class="join_title">
						<form:label path="gender">성별</form:label>
					</h3>
					<span class="box gender_code"> 
						<form:select path="gender" class="sel">
								<form:option value="">성별</form:option>
								<form:option value="남성">남성</form:option>
								<form:option value="여성">여성</form:option>
						</form:select>
					</span> 
					<span class="error_next_box"><form:errors path="gender"></form:errors></span>
				</div>
				
				<!-- EMAIL -->
				<div>
					<h3 class="join_title">
						<form:label path="email">이메일<!-- <span class="optional">(선택)</span> --></form:label>
					</h3>
					<span class="box int_email"> 
						<form:input path="email" class="int" maxlength="100" placeholder="선택입력" />
					</span> 
					<span class="error_next_box"><form:errors path="email"></form:errors></span>
				</div>
				
				<!-- NICKNAME -->
				<div>
					<h3 class="join_title">
						<form:label path="nickName">닉네임</form:label>
					</h3>
					<span class="box int_mobile">
						<form:input path="nickName" class="int" maxlength="20" placeholder="닉네임 입력" />
					</span>
					<span class="error_next_box"><form:errors path="nickName"></form:errors></span>
				</div>
				
				<div>
					<h3 class="join_title">
						<form:label path="address" >주소</form:label>
						<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
					</h3>
					<span class="box">
						<input type="text" id="sample6_postcode" class="int" placeholder="우편번호">					    
					</span>
				</div>
				
				<div>
					<span class="box">
						<input type="text" id="sample6_address" class="int" placeholder="주소">
					</span>
				</div>
				
				<div>
					<span class="box">
						<input type="text" id="sample6_detailAddress" class="int" placeholder="상세주소">
					</span>
				</div>
				
				<div>
					<span class="box">
						<input type="text" id="sample6_extraAddress" class="int" placeholder="참고항목">
					</span>
					<span class="error_next_box"><form:errors path="address"></form:errors></span>
				</div>
				
				<!-- 숨겨진 필드 -->
				<form:hidden path="address"/>
				<form:hidden path="checkMemberID"/>

				<!-- 제출 버튼 -->
				<div class="btn_area">
					<form:button type="submit" id="btnJoin" value="가입하기" onclick="combineDate()">
						<span>가입하기</span>
					</form:button>
				</div>
			</div><!-- content-->
		</div><!-- wrapper -->
	</form:form>
</body>
</html>