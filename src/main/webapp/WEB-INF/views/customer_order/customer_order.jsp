<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<c:set var='root' value="${pageContext.request.contextPath }/" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>주문하기</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<!-- <script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script> -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>


<!-- timepicker -->
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<style>
body{
      font-family: Yeongdeok Sea;
      margin: 0 auto;
   }
/*    
.container{
max-width: 100%;

}
 */   
.tpicker {
    width: auto;
    height: 130px;
    position: absolute;
    background-color: white;
    border-radius: 3px;
    box-shadow: 0px 2px 3px black;
    display: none;
    padding: 15px;
}

.pk1 {
   float: left;
   width: 90%;
   margin: 0 5%;
}

.hr {
   text-align: center;
   width: 30%;
   float: left;
   padding-top: 10px;
}

.hr i {
   font-weight: bold;
   text-align: center;
   width: 100%;
   font-size: 23px;
}

.hr i:hover {
   cursor: pointer;
   color: red;
}

.hr a:hover {
   cursor: pointer;
   background-color: lightgrey;
}

.hr a {
   padding: 2px;
   border-radius: 2px;
   text-decoration: none;
   font-size: 18px;
   width: 100%;
   text-align: center;
   -webkit-touch-callout: none; /* iOS Safari */
   -webkit-user-select: none; /* Safari */
   -khtml-user-select: none; /* Konqueror HTML */
   -moz-user-select: none; /* Firefox */
   -ms-user-select: none; /* Internet Explorer/Edge */
   user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}

.pk1 .dot {
   width: 30%;
   float: left;
}

.pk1 .dot2 {
   margin-top: 28px;
   width: 10%;
   text-align: center;
   float: left;
   -webkit-touch-callout: none; /* iOS Safari */
   -webkit-user-select: none; /* Safari */
   -khtml-user-select: none; /* Konqueror HTML */
   -moz-user-select: none; /* Firefox */
   -ms-user-select: none; /* Internet Explorer/Edge */
   user-select: none; /* Non-prefixed version, currently
                                  supported by Chrome and Opera */
}

.pk1 .dot button {
   width: 100%;
   margin-top: 30px;
}

.pk2 {
   display: none;
}

.pk2 table {
   margin: 0px;
   padding: 0;
}

.pk2 table td {
   text-align: center;;
   border-radius: 2px;
   border: solid 0.5px lightgrey;
}

.pk2 table td:hover {
   background-color: lightgrey;
   cursor: pointer
}
</style>

<script>
var fhr = 12;
var fmi = 0;
var ampm = 0;
var showpicker = 0;
var elid = 'none';
var picker_type=0;

function showpickers(a, b) {
    if (showpicker) {
        $('.tpicker').hide();
        showpicker = 0;
    } else {
        elid = a;
        picker_type = b;
        var textPositionTop = 124.8; // '픽업 정보 입력' 텍스트의 상단 위치
        var textPositionLeft = 166; // '픽업 정보 입력' 텍스트의 왼쪽 위치

        // tpicker 위치 설정
        $('.tpicker').css({
            top: textPositionTop + "px", // 텍스트 상단 위치 + 추가 오프셋 (필요한 경우)
            left: textPositionLeft + "px", // 텍스트 왼쪽 위치 + 추가 오프셋 (필요한 경우)
            display: 'block'
        });

        showpicker = 1;
    }
}

function showdate(){
   $('.pk1').show();
   $('.pk2').hide();
}
function showtime(){
   $('.pk1').hide();
   $('.pk2').show();
}
function updatetime(){
   var gg="AM";
   if(ampm)gg = "PM";
   if(picker_type==24){
      var thr = fhr;var tmin = fmi;
      if(ampm){
         if(fhr<12)thr = fhr+12;
      }else{
         if(fhr==12)thr = 0;
      }
      $('#'+elid).val(("0" + thr).slice(-2)+":"+("0" + tmin).slice(-2));
   }else{
      $('#'+elid).val(("0" + fhr).slice(-2)+":"+("0" + fmi).slice(-2)+" "+gg);
   }
   $('.hrhere').html(("0" + fhr).slice(-2));
   $('.minhere').html(("0" + fmi).slice(-2));
   $('.medchange').html(gg);
}

$(function(){

   var pickerhtml = '<div class="tpicker">' +
         '<div class="pk1">' +
         '<div class="row">' +
             '<div class="hr">' +
                 '<i class="fa fa-angle-up hrup"></i>' +
                 '<a class="hrhere">12</a>' +
                 '<i class="fa fa-angle-down hrdown"></i>' +
             '</div>' +
             '<div class="dot2">:</div>' +
             '<div class="hr">' +
                 '<i class="fa fa-angle-up minup"></i>' +
                 '<a class="minhere">00</a>' +
                 '<i class="fa fa-angle-down mindown"></i>' +
             '</div>' +
             '<div class="dot">' +
                 '<button type="button" class="btn btn-primary medchange">AM</button>' +
             '</div>' +
         '</div>' +
      '</div>' +
      '<div class="pk2 mintt">' +
         '<table class="table table-bordered mintable">' +
             '<tr><td>00</td><td>05</td><td>10</td><td>15</td><td>20</td><td>25</td></tr>' +
             '<tr><td>30</td><td>35</td><td>40</td><td>45</td><td>50</td><td>55</td></tr>' +
         '</table>' +
      '</div>' +
      '<div class="pk2 hrtt">' +
         '<table class="table table-bordered hrtable">' +
             '<tr><td>01</td><td>02</td><td>03</td><td>04</td><td>05</td><td>06</td></tr>' +
             '<tr><td>07</td><td>08</td><td>09</td><td>10</td><td>11</td><td>12</td></tr>' +
         '</table>' +
      '</div>' +
      '</div>';

   $('.timepicker').html(pickerhtml);

   $('.hrup').click(function(){
      if(fhr<12){fhr++;updatetime();}else{fhr=1;updatetime();}
   });
   $('.hrdown').click(function(){
      if(fhr>1){fhr--;updatetime();}else{fhr=12;updatetime();}
   });
   $('.minup').click(function(){
      if(fmi<59){fmi++;updatetime();}else{fmi=0;updatetime();}
   });
   $('.mindown').click(function(){
      if(fmi>0){fmi--;updatetime();}else{fmi=59;updatetime();}
   });
   $('.medchange').click(function(){
      if(ampm){ampm=0;updatetime();}else{ampm=1;updatetime();}
   });
   $('.hrhere').click(function(){
      $('.hrtt').show();
      $('.pk1').hide();
      $('.mintt').hide();
   });
   $('.minhere').click(function(){
      $('.hrtt').hide();
      $('.pk1').hide();
      $('.mintt').show();
   });
   $('.hrtable td').click(function(){
      var vaa = $(this).html();
      $('.hrtt').hide();
      $('.pk1').show();
      $('.mintt').hide();
      fhr = parseInt(vaa);updatetime();
   });
   $('.mintable td').click(function(){
      var vaa = $(this).html();
      $('.hrtt').hide();
      $('.pk1').show();
      $('.mintt').hide();
      fmi = parseInt(vaa);updatetime();
   });
});

//===================================결제 API=====================================
IMP.init("imp04761130");
const onClickPay = async () => {
   var time = document.getElementById("timepkr").value;
   if(!time){
      alert("시간을 설정 해주세요.");
      return;
   }
   
    let merchant_uid = await addMerchant_uid();
    if (!merchant_uid) return; // merchant_uid가 없으면 처리 중단

    IMP.request_pay({
        pg: "tosspayments",
        pay_method: "card",
        amount: getTotal(),
        name: "하루종일 편의점",
        merchant_uid: "tmhgf" + new Date().getTime(),
        buyer_name: "${loginUserBean.memberName}",
        buyer_tel: "${loginUserBean.phoneNo}",
        buyer_email: "${loginUserBean.email}",
        buyer_addr: "${loginUserBean.address}"
    }, function(response){
        console.log("결제 후 응답: ", response);
        // imp_uid가 존재하면 결제가 성공
        if(response.imp_uid){
            console.log("결제 성공, imp_uid: ", response.imp_uid);
            verifyPayment(response.imp_uid, merchant_uid); // 결제 검증 함수 호출
        } else {
            // imp_uid가 없으면 결제 실패
            console.error("결제 실패");
            alert("결제에 실패했습니다.");
        }
    });
};

//===================================결제 API를 위한 처리=====================================
// 총합계 계산
function getTotal() {
    var total1Text = document.getElementById('finalTotal').innerText;
    var total = parseInt(total1Text.replace(/,/g, ''));

   /*
   if (isNaN(total)) {
       console.error("Total is not a number", total1Text);
       return 0;
   }
   */
   return total;
}

//페이지 로드 시 getTotal 함수 호출
$(document).ready(function() {
   var total = getTotal();
   console.log("Total calculated: ", total);
   // 필요한 추가 로직이 있다면 여기에 작성
});


//결제번호 생성
async function addMerchant_uid(){
    var total = getTotal();
    if(total === 0){
        alert("장바구니에 담긴 내용이 없습니다!");
        location.href = "${root}main";
        return null;
    }

    let merchant_uid = null;
    try {
        const response = await $.ajax({
            url: "${root}payments/addMerchant_uid/" + total,
            type: "post"
        });
        console.log("post 성공");
        merchant_uid = await getMerchant_uid(); //getMerchant_uid호출
    } catch (error) {
        alert("오류가 발생했습니다: " + error);
    }
    return merchant_uid;
}
//===================================생성된 결제번호 반환=====================================
   async function getMerchant_uid(){
    try {
        const result = await $.ajax({
            url: "${root}payments/getMerchant_uid",
            type: "get",
            dataType: "text"
        });
        console.log("반환받음", result);
        return result;
    } catch (error) {
       console.log("반환받지 못함");
        alert("오류가 발생했습니다: " + error);
        return null;
    }
}
//===================================결제 검증===================================
   function verifyPayment(imp_uid, merchant_uid) {
    $.ajax({
        url: "${root}payments/verify",
        type: "post",
        dataType: "json",
        data: {
            imp_uid: imp_uid
        },
        success: function(response) {
        	console.log(response.log);
            if (response.success) {
               console.log("검증 성공");
                addPaymentInfo(merchant_uid);
            } else {
               console.log("검증 실패 1");
                alert("결제 검증 실패: " + response.message);
                deletePaymentNo(merchant_uid);
                return null;
            }
        },
        error: function(xhr, status, error) {
           console.log("검증 실패 2");
            alert("결제 검증 중 오류 발생: " + xhr.status);
            addPaymentInfo(merchant_uid);
            return null;
        }
    });
}




// ===================================결제 내역 생성===================================
function addPaymentInfo(merchant_uid){
   var products = [];
    var rowCount = $("#orderTable tbody tr").length;

    for (var i = 1; i <= rowCount; i++) {
        var productName = $("#pdName" + i).text();
        var quantity = $("#quantity" + i).val();
        var price = $("#price" + i).text();

        products.push({
            productName: productName,
            amount: quantity,
            retailPrice: price
        });
    }
    
    // JSON으로 변환
    var data = JSON.stringify(products);
    console.log(merchant_uid);
    
    // AJAX 요청
    $.ajax({
        url: '${root}payments/addPaymentInfo/' + merchant_uid, 
        type: 'POST',
        contentType: 'application/json',
        data: data,
        success: function(response) {
            // 성공 시 처리
           console.log("결제내역 생성 성공");
           updateQuentity(data, merchant_uid);
        },
        error: function(xhr, status, error) {
            // 오류 처리
           console.error("결제내역 생성 실패", xhr.status);
        }
    });
}

//===================================결제 후 재고 수정===================================
   function updateQuentity(data, merchant_uid){
   $.ajax({
      url: "${root}payments/updateQuentity",
      type: "PUT",
      contentType: "application/json",
      data: data,
      success: function(response){
         console.log("수량 업데이트 성공");
         addReservationInfo(data, merchant_uid);
      },
      error: function(xhr, status, error) {
         console.error("수량 업데이트 실패", xhr.status);
      }
   })
}

//===================================결제 후 예약 정보 생성===================================

   function addReservationInfo(data, merchant_uid){
   console.log("Reservation : " , data);
   console.log("Reservation : ", merchant_uid);
   
   var date = document.getElementById("dateDisplay").innerText;
    var time = document.getElementById("timepkr").value;
    var dateTime = date + " " + time;
    
    $.ajax({
       url: "${root}payments/addReservationInfo/"+ merchant_uid + "/" + dateTime,
       type: "POST",
       contentType: "application/json",
       data: data,
       success: function(response){
          console.log("예약 정보 추가 성공");
          updatePoints();
       },
       error: function(xhr, status, error){
          console.error("예약 정보 추가 실패", xhr.status);
       }
    })
    
    //===================================결재 후 포인트 업데이트===================================
    function updatePoints(){
    	var pointsPlus = document.getElementById("points").innerText;
    	var pointsMinus = document.getElementById("discountInput").value;
    	$.ajax({
    		url:"${root}payments/updatePoints/" + pointsPlus + "/" + pointsMinus,
    		type: "PUT",
    		success: function(response){
    			console.log("포인트 업데이트 성공")
    			alert("결제를 성공 하였습니다.")
    			location.href="${root}main";
    		},
    		error: function(xhr, status, error){
    			console.error("업데이트 중 오류 발생" + xhr.status);
    		}
    	})
    }
   
   
   
}

// 날짜 예외 처리 디버깅용
/*
   function combineDateTime() {
       var date = document.getElementById("dateDisplay").innerText;
       var time = document.getElementById("timepkr").value;
       var dateTime = date + " " + time;
       console.log("Combined Date and Time: ", dateTime);
   }
*/

//===================================결제 실패 시 결제 코드 삭제===================================

   function deletePaymentNo(merchant_uid){
   $.ajax({
      url: "${root}payment/deletePaymentNo/" + merchant_uid,
      type: "DELETE",
      success: function(response){
         console.log("삭제 성공");
      },
      error: function(xhr, status, error){
         console.error("삭제 에러 발생 : ", xhr.status);
      }
   })
}


</script>
<script>
// 수량조절 및 총 가격 계산
   function calculateTotal(index) {
       var quantityElement = document.getElementById('quantity' + index);
       var priceElement = document.getElementById('price' + index);
       var totalElement = document.getElementById('total' + index);

       if (quantityElement && priceElement && totalElement) {
           var amount = parseInt(quantityElement.value);
           var retailPrice = parseInt(priceElement.innerText.replace(/[^0-9]/g, ""));

           if (!isNaN(amount) && !isNaN(retailPrice)) {
               var total = amount * retailPrice;
               totalElement.innerText = total.toLocaleString() + '원';
           } else {
               console.error('Invalid number for quantity or price');
           }
       } else {
           console.error('Element not found for index', index);
       }

       updateTotalSum(); // 총 합계 업데이트
   }
   
// 모든 항목의 합계 계산 및 표시
   function updateTotalSum() {
       var sum = 0;
       $("td[id^='total']").each(function() {
           var value = parseInt($(this).text().replace(/[^0-9]/g, ""));
           if (!isNaN(value)) {
               sum += value;
           }
       });

       var discount = parseInt($('#discountInput').val());
       if (isNaN(discount)) {
           discount = 0;
       }

       // 상품 총액 업데이트
       var productTotalElement = document.getElementById('productTotal');
       if (productTotalElement) {
           productTotalElement.innerText = sum.toLocaleString();
       } else {
           console.error('Product total element not found');
       }

       // 최종 합계 업데이트
       var finalTotalElement = document.getElementById('finalTotal');
       if (finalTotalElement) {
           var finalTotal = sum - discount;
           finalTotalElement.innerText = finalTotal.toLocaleString();
       } else {
           console.error('Final total element not found');
       }

       // 적립 포인트 계산 (상품 금액을 기준으로)
       var pointsElement = document.getElementById('points');
       if (pointsElement) {
           var points = Math.round(sum * 0.01); // 예: 1% 적립
           pointsElement.innerText = points;
       } else {
           console.error('Points element not found');
       }
   }

   // 페이지 로드 시 각 항목에 대해 calculateTotal 함수 호출 및 합계 계산
   $(document).ready(function() {
	// 추가할 코드: 상품 행의 수에 따라 calculateTotal 함수를 호출
	    var productRowCount = $("#orderTable tbody tr").length; // 상품 목록 행의 수 계산

	    for (var i = 1; i <= productRowCount; i++) {
	        calculateTotal(i); // 각 상품에 대해 calculateTotal 함수 호출
	    }

	    updateTotalSum(); // 초기 합계 업데이트
       $('#discountInput').change(updateTotalSum); // 할인 입력 변경 시 업데이트
   });
    
</script>
</head>
<body>

   <c:import url="/WEB-INF/views/include/top.jsp"></c:import>
<div>
   <div class="container" style="margin-top: 100px">
      <div class="row g-4">
         <div class="col-md-12">
            <div class="card shadow">
               <div class="card-body" style="height: 260px;">
                  <div class="form-group">
                     <div class="store_name">
                        <b>픽업 지점</b>
                     </div>
                     <div class="store_address">${requestScope.loginUserBean.checkStore}</div>
                     <hr />
                     <%
                     Date date = new Date();
                     SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd");
                     String strDate = simpleDate.format(date);
                     %>
                     <div>
                        <b>픽업 시간 입력</b><br /> 📆&nbsp;<span id="dateDisplay"><%=strDate%></span>
                        <br /> <input id="timepkr" style="width: 100px; float: left;"
                           class="form-control" placeholder="HH:MM" maxlength="5" readonly="readonly"/>
                        <button type="button" class="btn btn-primary"
                           onclick="showpickers('timepkr',24)"
                           style="width: 40px; float: left;">
                           <i class="fa fa-clock-o"></i>
                        </button>
                     </div>
                     <div class="timepicker"></div>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <div class="row g-4">
         <div class="col-md-12">
            <div class="card shadow">
               <div c lass="card-body">
                  <div class="form-product">
                     <table class="table" id="orderTable">
                        <thead>
                           <b style="margin-left: 16px;">상품 목록</b>
                           <tr>
                              <th scope="col">번호</th>
                              <th scope="col">상품명</th>
                              <th scope="col">수량</th>
                              <th scope="col">가격</th>
                              <th scope="col">총 가격</th>
                           </tr>
                        </thead>
                        <tbody>
                           <c:forEach items="${uniqueProducts}" var="product"
                              varStatus="loop">
                              <tr>
                                 <td>${loop.index + 1}</td>
                                 <td id="pdName${loop.index + 1}">${product.productName}</td>
                                 <td><input type="number" value="${product.amount}"
                                    min="1" id="quantity${loop.index + 1}" style="width: 50px; border: 0px"
                                    onchange="calculateTotal(${loop.index + 1})" readonly="readonly"/></td>
                                 <td id="price${loop.index + 1}">${product.retailPrice}</td>
                                 <td id="total${loop.index + 1}"></td>
                              </tr>
                           </c:forEach>
                        </tbody>
                     </table>
                  </div>
               </div>
            </div>
         </div>
      </div>

      <div class="row">
         <div class="col-md-12">
            <div class="card shadow">
               <div class="card-body">
               <!--    <h2>결제</h2> -->
                  <div class="form-group">
                     <label for="finalTotal"><b>결제 예정금액</b></label>
                     <p>
                         상품금액: <span id="productTotal">0</span>원
                     </p>
                     <p>
                         할인: - <input type="number" id="discountInput" placeholder="${requestScope.loginUserBean.points}" style="width: 100px;" onchange="TotalSum()" />원
                     </p>
                     <p>
                         합계: <b id="finalTotal">0</b>원
                     </p>
                  </div>
                  <div class="form-group">
                     <label for="points"><b>적립</b></label>
                     <p>
                        <span id="points">0</span> point
                     </p>
                  </div>
                  <button class="btn btn-primary" style="background-color: #6A24FE" onclick="onClickPay()">결제하기</button>
                  <button class="btn btn-primary" style="background-color: #6A24FE" onclick="location.href='${root }product/product_main'">더 담으러가기</button>
               </div>
            </div>
         </div>
      </div>
   </div>
      <c:import url="/WEB-INF/views/include/bottom.jsp"></c:import>

</body>

</html>