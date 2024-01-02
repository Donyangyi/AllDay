<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원탈퇴 완료</title>
</head>
<body>
    <h1>그동안 서비스를 이용해주셔서 감사합니다.</h1>
    <div>
        <button onclick="completeAndRedirect()">완료</button>
       <a class="dropdown-item" href="${root}member/logout">로그아웃</a>
    </div>

    <script>
        // 완료 버튼 클릭 시 완료 처리 및 메인 페이지로 이동
        function completeAndRedirect() {
            // 여기에 완료 처리 로직 추가
            
            // 메인 페이지로 이동
            location.href = '${root}main';
        }
    </script>
</body>
</html>