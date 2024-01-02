<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var='root' value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>장바구니</title>

<!-- Bootstrap CDN -->
<link href="${root }css/styles.css" rel="stylesheet" />
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>

<style type="text/css">
.card-body {
    flex: 1 1 auto;
    padding: var(--bs-card-spacer-y) var(--bs-card-spacer-x);
    color: var(--bs-card-color);
}
	body{
		font-family: Yeongdeok Sea;
	}
</style>

<script>
   // 전체선택
   $(document).ready(function() {
      $("#checkAll").click(function() {
         if ($("#checkAll").is(":checked"))
            $("input[name=chk]").prop("checked", true);
         else
            $("input[name=chk]").prop("checked", false);
      });

      $("input[name=chk]").click(function() {
         var total = $("input[name=chk]").length;
         var checked = $("input[name=chk]:checked").length;

         if (total != checked)
            $("#checkAll").prop("checked", false);
         else
            $("#checkAll").prop("checked", true);
      });

      // 페이지 로드 시 각 항목에 대해 calculateTotal 함수 호출
      $("input[type='number']").each(function(index) {
          calculateTotal(index + 1);
      });
   });


   // 수량 조절 및 변경된 수량 업데이트
	function calculateTotal(index) {
	    var amount = parseInt(document.getElementById('quantity' + index).value);
	    var retailPrice = parseInt(document.getElementById('price' + index).innerText);
	    var stockQuantity = parseInt(document.getElementById('stockQuantity' + index).value);
	    var total = amount * retailPrice;
	
	    // 수량이 재고보다 많은 경우 경고 메시지 표시 및 재고 수량으로 설정
	    if (amount > stockQuantity) {
	        alert("재고가 부족합니다. 최대 가능 수량: " + stockQuantity);
	        document.getElementById('quantity' + index).value = stockQuantity;
	        amount = stockQuantity;
	        total = stockQuantity * retailPrice; // 총액도 재계산
	    }
	
	    document.getElementById('total' + index).innerText = total;
	    
	    // 변경된 수량 업데이트 (현재 수량 전달)
	    sendQuantityToServer(index, amount);
	    
	    // 전체 합계 업데이트
	    updateTotalSum();
	}
   
	// 모든 항목의 합계 계산 및 표시
    function updateTotalSum() {
        var sum = 0;
        $("td[id^='total']").each(function() {
            sum += parseInt($(this).text()) || 0;
        });

        // 합계를 '합계' 섹션에 표시
        document.getElementById('finalTotal').innerText = sum + '원';
        
        // 포인트 계산 (총액의 0.005%)
        var points = Math.round(sum * 0.01);
        document.getElementById('points').innerText = points + ' point';
        
    }

    // 페이지 로드 시 각 항목에 대해 calculateTotal 함수 호출 및 합계 계산
    $(document).ready(function() {
        $("input[type='number']").each(function(index) {
            calculateTotal(index + 1);
        });
    });
    
    /*
    function deleteCheckedItems() {
        // 체크된 항목의 인덱스(IDX)를 저장할 배열
        var checkedIndexes = [];

        // 체크된 항목을 찾아 배열에 추가하고, 화면에서 삭제
        $("input[name='chk']:checked").each(function() {
            var row = $(this).closest('tr');
            var index = row.find("#cartItemIDX").text(); // 현재 항목의 IDX 추출
            checkedIndexes.push(index);
            row.remove();
        });

        // 서버에 삭제 요청 보내기
        if (checkedIndexes.length > 0) {
            sendDeleteRequestToServer(checkedIndexes);
        } else {
            console.log("No items selected for deletion.");
        }

        // 번호 재정렬
        reorderItemNumbers();

        // 전체 합계 업데이트
        updateTotalSum();
    }
    */
 // 선택된 아이템 삭제
    function deleteCheckedItems() {
        var checkedProductNames = [];
        $("input[name='chk']:checked").each(function() {
            var row = $(this).closest('tr');
            var productName = row.find("td:nth-child(3)").text(); // 수정된 부분: 상품명 추출
            checkedProductNames.push(productName);
        });

        if (checkedProductNames.length > 0) {
            sendDeleteRequestToServer(checkedProductNames);
        } else {
            console.log("No items selected for deletion.");
        }
    }
 	// 삭제 후 항목 번호 재정렬하는 함수
    function reorderItemNumbers() {
        $("table tbody tr").each(function(index) {
            $(this).find("td:nth-child(2)").text(index + 1);
        });
    }

 // 서버에 삭제 요청 보내는 함수
    function sendDeleteRequestToServer(productNames) {
        $.ajax({
            url: "${root}cartDeletePro",
            type: "DELETE",
            contentType: "application/json",
            data: JSON.stringify(productNames),
            success: function(response) {
                console.log("Deleted items successfully.");
                // 화면에서 삭제된 아이템 제거
                location.reload(); // 혹은 더 세련된 방법으로 화면 업데이트
            },
            error: function(xhr, status, error) {
                console.error("Error deleting items: ", xhr.status);
                // 에러 처리 로직 추가
            }
        });
    }

 	// 서버에 수량 변경 요청 보내는 함수
    function sendQuantityToServer(index, amount){
        var CIN2 = index - 1; // JSP에서 설정된 index를 사용하여 실제 인덱스 계산

        console.log("CIN2:", CIN2, "amount:", amount);

        if (!isNaN(CIN2) && !isNaN(amount)) {
            $.ajax({
                url: "${root}cartQuantityPro/" + CIN2 + "/" + amount,
                type: "put",
                success: function(response){
                    console.log("ajax success");
                },
                error: function(xhr, status, error){
                    alert(xhr.status);
                }
            });
        } else {
            console.error("Invalid CIN2 or amount value");
        }
    }

 	
	 
</script>
</head>
<body>

   <c:import url="/WEB-INF/views/include/top.jsp" />

   <div class="container" style="margin-top: 100px">
      <div class="row">
         <div class="col-md-9">
            <div class="card shadow">
               <div class="card-body" style="min-height: 500px;">
                  <div class="form-group">
                     <label><h2>장바구니</h2></label>

                   <!--   
                   전체 선택 체크박스 위치 변경
                   <div class="form-check">
                        <input type="checkbox" id="checkAll" />
                        <label class="form-check-label" for="All">
                           전체선택</label>
                   </div> -->

                     <table class="table">
                        <thead>
                           <tr>
                              <th scope="col"><input type="checkbox" id="checkAll" /></th>
                              <th scope="col">번호</th>
                              <th scope="col">상품명</th>
                              <th scope="col">수량</th>
                              <th scope="col">개당가격</th>
                              <th scope="col">총 가격</th>
                           </tr>
                        </thead>
                        <tbody>
                           <c:forEach items="${uniqueProducts}" var="obj" varStatus="loop">
						    <tr>
						        <td><input type="checkbox" name="chk"></td>
						        <td id="cartItemIDX">${loop.index + 1}</td>
						        <td>${obj.productName}</td>
						        <td id="CIQ">
						            <!-- 수량 입력 필드에 max 속성 추가 -->
						            <input type="number" value="${obj.amount}" min="1" max="${obj.stockQuantity}" id="quantity${loop.index + 1}"
						                   style="width: 50px;" onchange="calculateTotal(${loop.index + 1})" />
						            <!-- stockQuantity 값을 숨겨서 저장 -->
						            <input type="hidden" id="stockQuantity${loop.index + 1}" value="${obj.stockQuantity}" />
						        </td>
						        <td id="price${loop.index + 1}">${obj.retailPrice}</td>
						        <td id="total${loop.index + 1}"></td>
						    </tr>
						</c:forEach>
                        </tbody>
                     </table>
                     <button class="btn btn-primary_del" onclick="deleteCheckedItems()">삭제</button>
                  </div>

                  <div class="form-group">
                     <label for="board_file"></label>
                    
                  </div>
               </div>
            </div>
         </div>

         <div class="col-sm-3">
            <div class="card shadow">
               <div class="card-body">
                  <h5 class="card-title">
                     <h2>결제</h2>
                  </h5>

                  <div class="form-group">
                     <label><b>예상 포인트</b></label>
					 <p><b id="points">0 point</b></p>
                     
                  </div>
                  <hr />
                  <div class="form-group">
                  	 <label><b>예상 금액</b></label>
                     <p><b id="finalTotal">0원</b></p>
                  </div>
                  
                  <hr />

                  <button class="btn btn-primary" style="background-color: #6A24FE" onclick="location.href='${root }customer_order/customer_order'">주문하기</button>
               </div>
            </div>
         </div>
      </div>
   </div>

   <c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

<script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
      crossorigin="anonymous">
      </script>
      

</body>
</html>
