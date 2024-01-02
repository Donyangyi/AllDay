<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath }/" />

<!-- 전체상품 페이지 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>하루종일 편의점</title>

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${root }css/styles.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<style type="text/css">
	
   .prod_sideBox{
      width: 217px;
      min-height: 400px;
      position: fixed;
      top: 60px;
      /* background-color: purple; */
      /* border: 5px solid rgb(192, 205, 239); */
      border-radius: 10px;
      
   }
   
	.prod_sideMiddle{
		
		align-content: center;
		border: 5px solid rgb(192, 205, 239);
		/* margin: 80px 35px 80px 35px; */
		margin: 80px -20px 80px 35px;
		border-radius: 10px;
		float: right;
	}
   
   .prod_sideUL{
      list-style: none;
      /* border: 1px black; */
      padding: 0px;
      margin: 0px;
      /* margin: 80px 35px 80px 35px; */
   }
   
   .side_list{
      width: 130px;
      /* height: 50px; */
      border: 1px black;
      margin: 10px;
   }
  
   .side_list_btn{
   	  font-family:Yeongdeok Sea;
   	  font-size: 18px;
      width: 127px;
      height: 40px;
      margin: 2px 0px 2px 0px;
      border: none;
      background: none;
   }
/*    
   .side_list_btn :hover{   
      border: 2px green solid;
   }
 */   
   
</style>

</head>
<body>
	
		<div class="prod_sideBox">
		
		<div class="prod_sideMiddle">
		
		
			<ul class="prod_sideUL">
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=all'" class="side_list_btn">전체보기</button>
					<!-- <input type="button" class="side_list_btn" value="전체보기"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=즉석식품'" class="side_list_btn">즉석식품</button>
					<!-- <input type="button" class="side_list_btn" value="즉석식품"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=가공식품'" class="side_list_btn">가공식품</button>
					<!-- <input type="button" class="side_list_btn" value="가공식품"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=과자'" class="side_list_btn">과자</button>
					<!-- <input type="button" class="side_list_btn" value="과자"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=음료'" class="side_list_btn">음료</button>
					<!-- <input type="button" class="side_list_btn" value="음료"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=아이스크림'" class="side_list_btn">아이스크림</button>
					<!-- <input type="button" class="side_list_btn" value="아이스크림"> -->
				</li>
				<li class="side_list">
					<button onclick="location.href='${root }product/product_main?productCategory=생활용품'" class="side_list_btn">생활용품</button>
					<!-- <input type="button" class="side_list_btn" value="생활용품"> -->
				</li>
			</ul>
			</div>
		</div>
	
    <!-- 부트스트랩 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</body>
</html>