<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<link rel="stylesheet" href="${root}css/font.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<style type="text/css">

   body{
      font-family: Yeongdeok Sea;
   }
   
   .prod_content{
      
      width: 1070px;
      /* border: 5px solid blue; */
      min-height: 500px;
      margin: 0 auto;
      padding-left: 80px;
      margin-top: 130px;
    }

    .prod_option{
       text-align: right;
        margin: 10px;
        width: 990px;
    }
    
    .prod_option a{
       text-decoration: none;
       color: black;
    }
    
   .prod_btn{
      border: none;
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
      width: 1030px;
   }

   .prod_list{
      width: 220px;
      /* height: 350px; */
      /* border: 1px solid gray; */
      /* box-shadow: 0px 2px 0px #8977ad; */
      float: left;
      margin: 15px;
   }
   
   .prod_list:hover {
      
       box-shadow: 0 0 3px 3px lightgray;
   }
   
   .prod_item{
      /* width: 220px;
      height: 350px; */
      border: 1px black;
      font-family: 'Yeongdeok Sea';
      cursor:pointer;
      /* background-color: yellow; */
   }
   
   .prod_img{
      width: 200px;
      height: 220px;
      /* border: 1px solid black; */
      margin: auto;
   }
   
   
   .prod_img img{
      width: 198px;
      height: 218px;
   }   
   
     
   .prod_text{
      width: 200px;
      height: 100px;
      font-size: 18px;
      /* border: 1px black; */
      padding-top: 10px;
      margin: 0 auto;
      border-top: 1px dotted;
   }
   
   .prod_name{
      width: 200px;
      height: 40px;
      /* border: 1px black; */
      text-align: center;
   }
   
   .prod_price{
      max-width: 200px;
      height: 40px;
      text-align: center;
   }
   
   .img_comment{
      width: 20px;
      height: 25px;
      align-items: center;
   }
      
      
/* serch bar */
.search-bar-section {
   position: relative;
}

.search-bar {
   margin-top: 50px;
   display: flex;
   justify-content: center;
}

.search-bar-input {
   width: 700px;
   height: 60px;
   border-radius: 20px;
   border-top-right-radius: 0;
   border-bottom-right-radius: 0;
   border: 2px solid #5320BF;
}

.search-bar-input[type="search"] {
   padding-left: 20px;
}

.search-button {
   background-color: #8D77FA;
   color: #fff;
   font-size: 12pt;
   font-weight: 600;
   width: 100px;
   height: 60px;
   margin-left: -10px;
   border: 2px solid #5320BF;
   border-radius: 20px;
   border-top-left-radius: 0;
   border-bottom-left-radius: 0;
}

.search-button:active {
   background-color: #5320BF;
}
   
/* serch bar end */   
   
</style>

<script>
    $(document).ready(function() {
        $('#imageSelect').change(function() {
            var selectedStore = $(this).val();
            $.ajax({
                url: '${root}product/updateStore',
                type: 'POST',
                data: { storeLocation: selectedStore },
                success: function(response) {
                    alert(selectedStore + '으로 변경되었습니다.');
                    location.href="${root}product/product_main"
                },
                error: function() {
                    alert('매장 변경에 실패했습니다.');
                }
            });
        });
    });
</script>

</head>
<body>
   <!-- 상단바 가져오기 -->
    <c:import url="/WEB-INF/views/include/top.jsp"/>
   <!-- 사이드바 가져오기 -->
   <c:import url="/WEB-INF/views/include/product_sidebar.jsp" />
   <!-- 상단바 및 기타 요소들 -->
    <div class="prod_content">
       <!-- search-bar-section start -->
      <div class="search-bar-section">
         <form action="${root}product/product_main" method="get" class="search-bar" role="search">
            <input class="search-bar-input" type="text" name="keyword"
               placeholder="   검색어를 입력해주세요" style="height: 60px;">
            <button class="search-button" type="submit" >Search</button>
         </form>
      </div>
      <!-- search-bar-section end -->
       
       <div class="prod_option" style="margin-top: 40px;">
            <div class="select-location" style="margin-right: 60px;">
               <select name="imageSelect" id="imageSelect">
                  <option id="option" value="지점선택">지점선택</option>
                  <option id="option" value="고속터미널점">고속터미널점</option>
                  <option id="option" value="신논현점">신논현점</option>
                  <option id="option" value="종각역점">종각역점</option>
               </select>
            </div>
      </div>
        <div class="prod_location">
            <ul class="img_location">
                <c:choose>
                    <c:when test="${isSearchResult == true}">
                        <!-- 검색 결과가 있는 경우 -->
                        <c:forEach items="${productInvenReOrderDetailBeans}" var="obj">
                            <li class="prod_list">
                                <div class="prod_item" onclick="location.href='${root}product/product_detail?productNo=${obj.productNo}'">
                                    <div class="prod_img">
                                        <img src="${root}image/${obj.productImage}" alt="상품이미지" />
                                    </div>
                                    <div class="prod_text">
                                        <div class="prod_name"><p>${obj.productName}</p></div>
                                        <div class="prod_price"><p style="font-weight: bold;">${obj.retailPrice}원</p></div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <!-- 기본 상품 목록 표시 -->
                        <c:forEach items="${productInvenReOrderDetailBeans}" var="product">
                      <li class="prod_list">
                          <div class="prod_item" onclick="location.href='${root}product/product_detail?productNo=${product.productNo}'">
                              <div class="prod_img">
                                  <img src="${root}image/${product.productImage}" alt="상품이미지" />
                              </div>
                              <div class="prod_text">
                                  <div class="prod_name"><p>${product.productName}</p></div>
                                  <div class="prod_price"><p style="font-weight: bold;">${product.retailPrice}원</p></div>
                              </div>
                          </div>
                      </li>
                  </c:forEach>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>


</body>
</html>