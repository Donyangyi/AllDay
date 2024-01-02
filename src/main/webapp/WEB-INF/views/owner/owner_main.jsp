<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var='root' value="${pageContext.request.contextPath }/" />

<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AllDay</title>

<!-- Core theme CSS (includes Bootstrap)-->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<link href="${root }css/styles.css" rel="stylesheet" />
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous">
<link href="${root }css/table.css" rel="stylesheet" />
<link
   href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
   rel="stylesheet"
   integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN"
   crossorigin="anonymous">


<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>


<style>

/*임시 크기 조정한거  */
.container {
    position: fixed;
    left: 0;
    top: 14%; /* 원하는 위치(픽셀 단위)로 조절하세요 */
}
/*임시 크기 조정한거  */


label {
  display: flex;
  align-items: center;
  white-space: nowrap;
}


.search-container {
   overflow-x: auto;
   max-width: 90%;
   margin-top: 20px;
}

#search-table {
   width: 100%;
}

.order-container {
   overflow-x: auto;
   max-width: 90%;
   margin-top: 20px;
}

#order-table {
   width: 100%;
}

#search-table thead {
    position: sticky;
    top: 0;
    background-color: #fff; /* 필요한 배경색상 설정 */
    z-index: 1;
}

#order-table thead {
    position: sticky;
    top: 0;
    background-color: #fff; /* 필요한 배경색상 설정 */
    z-index: 1;
}

.quantity-input {
    width: 20%; /* 원하는 너비로 조절하세요 */
    /* 다른 스타일 속성을 추가할 수 있습니다. */
}
#search-table, #order-table {
  font-size: 12px; /* 원하는 글자 크기로 설정 */
}

html, body {
      height: 100%;
      overflow: auto;
    }
</style>

</head>
<body>
<!-- 상단바 가져오기 -->
<c:import url="/WEB-INF/views/include/top_owner.jsp" />

   
  <div class="container" style="position: fixed; left: 0;">
        <div class="row">
            <div class="col-5">
                <div class="order-search">
                    <div class="input-group">
                        <label for="ProductName" class="input-group-text">제품명&nbsp;&nbsp;&nbsp;</label>
                        <input type="text" id="ProductName" name="ProductName" required>
                        <button class="btn btn-outline-success" type="button" onclick="search()">검색</button>
                        <span style="margin-left: 10px;"></span>
                        <button class="btn btn-outline-success" type="button" onclick="placeOrder()">발주 목록에 추가</button>
                        
                    </div>
                </div>
            </div>
        </div>
    	
        <div class="row" style="padding-right: 33%">
            <div class="col-md-9.6">
            <div class="card shadow">
                <!-- <div class="search-container"> -->
                <div>
                    <div class="search-table-container" style="overflow-y: auto; max-height: 200px;">
                    
                        <table id="search-table" class="responsive-table">
                            <!-- 검색 결과 테이블 헤더 -->
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="resultAllCheckbox"></th>
                                    <th>제품명</th>
                                    <th>상품번호</th>
                                    <th>단가</th>
                                </tr>
                            </thead>
                            <!-- 검색 결과 테이블 본문 -->
                            <tbody>
                                <!-- 여기에 검색 결과 내용을 동적으로 추가 -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
		<p>
		<p>
    <!-- 발주 목록 테이블 -->
	
				<div>
                <button class="btn btn-outline-danger" type="button" onclick="deleteOrder()">목록 삭제</button>
                <span style="margin-left: 10px;"></span>
                <button class="btn btn-outline-success" type="button" onclick="Order()">발주 주문</button>
                </div>
            <div class="col-md-9.6">
            <div class="card shadow">
                <!-- <div class="order-container"> -->
                <div>
                    <div class="order-table-container" style="overflow-y: auto; max-height: 300px;">
                        <table id="order-table" class="responsive-table">
                            <!-- 발주 목록 테이블 헤더 -->
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="orderAllCheckbox"></th>
                                    <th style="width: 20%;">제품명</th>
                                    <th style="width: 15%;">상품번호</th>
        							<th style="width: 30%;">수량</th>
                                    <th>단가</th>
                                    <th>합계</th>
                                </tr>
                            </thead>
                            <!-- 발주 목록 테이블 본문 -->
                            <tbody>
                                <tr>
                                    <!-- 여기에 발주 목록 내용을 동적으로 추가 -->
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        
        
	</div>
	
	<c:import url="/WEB-INF/views/include/in_owner_hitory.jsp" />
	
	<%-- <!-- bottom 하단바 부분 import -->
	<c:import url="/WEB-INF/views/include/bottom.jsp" /> --%>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"      
   integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
   crossorigin="anonymous">
</script>







<!--검색어 자동완성 기능  -->
<script>
        $(document).ready(function () {
            $("#ProductName").autocomplete({
                source: function (request, response) {
                    $.ajax({
                        url: "${root}/owner_auto_search",
                        dataType: "json",
                        data: {
                            query: request.term
                        },
                        success: function (data) {
                            response(data);
                        }
                    });
                },
                minLength: 1 // 최소 입력 길이 (한 글자 이상)
            });
        });
</script>

<script>
function search() {
    var productName = $("#ProductName").val();

    $.ajax({
        type: "GET",
        url: "${root}ownerRest/get_SearchProduct",
        data: {
            ProductName: productName
        },
        dataType: 'json', // 서버에서 JSON 형식의 데이터를 반환하는 경우 추가
        success: function (data) {
            // 검색 테이블의 기존 행을 지움
            $("#search-table tbody").empty();

            // 데이터를 순회하면서 검색 테이블의 행을 추가
            $.each(data, function (index, product) {
                var row = "<tr>";
                row += "<td><input type='checkbox'></td>";
                row += "<td>" + product.productName + "</td>";
                row += "<td>" + product.productNo + "</td>";
                row += "<td>" + product.unitPrice + "원"+"</td>";
                row += "</tr>";
                $("#search-table tbody").append(row);

                // 여기서 product 객체를 활용하여 추가적인 작업 수행 가능
                // 예: console.log(product);
            });
        },
        error: function (error) {
            console.error("AJAX 요청 중 오류 발생:", error);
            console.log("오류 응답 텍스트:", error.responseText);
            console.log("오류 상태:", error.status);
            console.log("오류 상태 텍스트:", error.statusText);
        }
    });
}

</script>
    

<script>                                                                  //체크박스 모두체크 설정
//선택시 발주목록 테이블의 모든 체크박스 상태 변경
$("#orderAllCheckbox").change(function() {
    var isChecked = $(this).prop("checked");

    $("#order-table tbody input[type='checkbox']").prop("checked", isChecked);
});

$("#resultAllCheckbox").change(function() {
    var isChecked = $(this).prop("checked");

    // 검색결과 테이블의 모든 체크박스 상태 변경
    $("#search-table tbody input[type='checkbox']").prop("checked", isChecked);
});

</script>
<!--loginUserBean의 storeName사용용  -->
<script type="text/javascript">
    var storeName = "${loginUserBean.storeName}";
</script>

<script>
function Order() {
    var checkedItems = $("#order-table tbody input[type='checkbox']:checked");

    if (checkedItems.length === 0) {
        alert("선택된 항목이 없습니다.");
        return;
    }

    var storeName = "${loginUserBean.storeName}";
    var ordererName = "${loginUserBean.memberName}";
    var orderDate = new Date().toISOString().slice(0, 10);

    $.ajax({
        type: "POST",
        url: "${root}ownerCart/OrderMain",
        contentType: "application/json",
        data: JSON.stringify({
            storename: storeName,
            orderdate: orderDate,
            orderername: ordererName
        }),
        success: function(response) {
            // 체크된 항목의 productNo 수집
            var selectedProductNos = checkedItems.map(function() {
                return $(this).closest("tr").find("td:eq(2)").text();
            }).get();

            // OrderDetails 정보를 서버에 전송
            $.ajax({
                type: "POST",
                url: "${root}ownerCart/insertOrderDetails",
                data: {
                    storeName: storeName,
                    productNos: selectedProductNos.join(","),
                },
                success: function(response) {
                    // OrderDetails 처리 성공 후
                    // 선택된 항목과 일치하는 OwnerCartBean 객체 삭제
                    deleteOrder(selectedProductNos);
                    alert("발주가 요청되었습니다.");
                },
                error: function(xhr, status, error) {
                    // OrderDetails 처리 오류 로직
                }
            });
        },
        error: function(xhr, status, error) {
            // OrderMain 처리 오류 로직
        }
    });
}
</script>


<script>                                                               //발주목록추가, 발주,목록삭제 버튼 기능
//발주 목록에 항목을 추가하는 함수
   function placeOrder() {
    // AJAX 요청
    var selectedItems = $("#search-table tbody input[type='checkbox']:checked");
    selectedItems.each(function () {
        var productRow = $(this).closest("tr");
        var productName = productRow.find("td:eq(1)").text();
        var productNo = productRow.find("td:eq(2)").text();
        var unitPrice = productRow.find("td:eq(3)").text().replace("원", ""); // '원' 문자 제거

        $.ajax({
            type: "POST",
            url: "${root}addOwnerCart",
            data: {
                productName: productName,
                productNo: productNo,
                unitPrice: unitPrice // 수정된 unitPrice 사용
            },
            success: function(response) {
                updateOrderTable();
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:");
                console.error("상태 코드:", xhr.status);
                console.error("상태 텍스트:", xhr.statusText);
                console.error("응답 텍스트:", xhr.responseText);
            }
        });
    });

    // 검색 결과 테이블의 체크박스를 지움
    selectedItems.prop("checked", false);
}
//자동으로 OwnerCart의 정보가 띄워지도록
   $(document).ready(function () {
	    // 페이지가 준비되면 OwnerCart의 내용을 표시합니다.
	    updateOrderTable();

	    // 기존의 autocomplete 및 기타 스크립트...
	});


/*=============================================================================================================================================================*/


   function updateOrderTable() {
	   
	   $.ajax({
	        type: "POST",
	        url: "${root}getStoreOwnerCart",
	        data: {
	            storeName: storeName
	        },
	        dataType: 'json',
	        success: function(data) {
	            // order-table의 기존 행을 지웁니다.
	            $("#order-table tbody").empty();

	            // 데이터를 순회하면서 order-table의 행을 추가합니다.
	            $.each(data, function(index, item) {
	                var row = "<tr>";
	                row += "<td><input type='checkbox'></td>";
	                row += "<td>" + item.productName + "</td>";
	                row += "<td>" + item.productNo + "</td>";
	                row += "<td><input type='number' class='quantity-input' value='" + item.orderQuantity + "' min='1'></td>";
	                row += "<td>" + item.unitPrice + "원" + "</td>";
	                row += "<td>" + item.supplyPrice + "원" + "</td>";
	                row += "</tr>";
	                $("#order-table tbody").append(row);
	            });
	        },
	        error: function(error) {
	            console.error("AJAX 요청 중 오류 발생:", error);
	        }
	    });
	}

//////////////////////////////수량변경/////////////////////////////////////////////
	$(document).on("change", ".quantity-input", function() {
    var $row = $(this).closest("tr");
    var productNo = $row.find("td:eq(2)").text().trim();
    var newQuantity = parseInt($(this).val());

    $.ajax({
        type: "POST",
        url: "${root}updateOwnerCartQuantity",
        data: {
            storeName: storeName,
            productNo: productNo,
            newQuantity: newQuantity
        },
        success: function(response) {
            updateOrderTable(); // 테이블 최신화
        },
        error: function(xhr, status, error) {
            console.error("AJAX 요청 실패:", error);
        }
    });
});




















// 추가한 부분: 수량이 변경될 때 합계 업데이트
$(document).on("input", "#order-table .quantity-input", function () {
    var $row = $(this).closest("tr");
    $row.find("td:eq(5)").text(calculateTotal($row));
});

// 추가한 부분: 합계 계산 함수
function calculateTotal($row) {
    var quantity = parseInt($row.find("td:eq(3) input").val()) || 1; // 수량을 가져오고, 없으면 1로 설정
    var unitPrice = parseFloat($row.find("td:eq(4)").text()) || 0; // 단가를 가져오고, 없으면 0으로 설정

    var total = (quantity * unitPrice).toFixed(2); // 수량과 단가를 곱한 값을 소수점 2자리까지 표시
    return total + "원"; // "원"을 붙여서 반환
}


//order-table에서 체크한 정보 OwnerCart에서 삭제하기
function deleteOrder() {
    var checkedItems = $("#order-table tbody input[type='checkbox']:checked");
    var productNos = [];

    checkedItems.each(function() {
        var productNo = $(this).closest("tr").find("td:eq(2)").text();
        productNos.push(productNo);
    });

    if (productNos.length > 0) {
        $.ajax({
            type: "POST",
            url: "${root}removeCheckedItems",
            data: {
                storeName: storeName,
                productNos: productNos.join(",") // 배열을 쉼표로 구분된 문자열로 변환
            },
            success: function(response) {
                updateOrderTable(); // 삭제 후 주문 테이블 갱신
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", error);
            }
        });
    }
}


</script>


</body>
</html>