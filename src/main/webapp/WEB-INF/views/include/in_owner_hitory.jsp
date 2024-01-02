<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath }/" />
<style>
/* 스타일 설정 */
.side {
    height: 78%;
    width: 40%;
    position: fixed;
    bottom: 3%;
    right: 0;
    overflow-x: auto;
    overflow-y: auto;
}

#result-table thead {
    position: sticky;
    top: 0;
    background-color: #fff; /* 배경색상 설정 */
}

#result-table {
    font-size: 12px; /* 글자 크기 설정 */
}
</style>

<script>
// 페이지 로드 시 실행되는 함수
document.addEventListener('DOMContentLoaded', function() {
    // 검색창 element를 id값으로 가져오기
    const payrollSearch = document.querySelector('#search-box');
    // 테이블의 tbody element를 id값으로 가져오기
    const payrollTable = document.querySelector('#result-tbody');

    // 검색창 element에 keyup 이벤트 세팅. 글자 입력 시 마다 발생.
    payrollSearch.addEventListener('keyup', function() {
        // 사용자가 입력한 검색어의 value값을 가져와 소문자로 변경하여 filterValue에 저장
        const filterValue = payrollSearch.value.toLowerCase();
        // 현재 tbody안에 있는 모든 tr element를 가져와 rows에 저장
        const rows = payrollTable.querySelectorAll('tr');

        // tr들 for문으로 순회
        for (var i = 0; i < rows.length; i++) {
            // 현재 순회중인 tr의 textContent를 소문자로 변경하여 rowText에 저장
            var rowText = rows[i].textContent.toLowerCase();
            // rowText가 filterValue를 포함하면, 해당 tr은 보여지게 하고, 그렇지 않으면 숨긴다.
            if (rowText.includes(filterValue)) {
                rows[i].style.display = '';
            } else {
                rows[i].style.display = 'none';
            }
        }
    });
});

// AJAX 요청 및 테이블 데이터 로드
$(document).ready(function () {
    // 데이터를 로드하고 테이블을 초기화하는 함수
    function loadHistoryData() {
        var storename = "${loginUserBean.storeName}"; // loginUserBean에서 storeName 가져오기

        $.ajax({
            type: "GET",
            url: "${root}ownerRest/get_order_history_data/",
            data: { storename: storename },
            dataType: 'json',
            success: function (data) {
                // 결과 테이블의 tbody를 비움
                $("#result-tbody").empty();
                console.log(Array.isArray(data));
                
                data.forEach(function(historyItem) {
                    var row = "<tr>";
                    row += "<td>" + formatDate(historyItem.orderDate) + "</td>";
                    row += "<td>" + historyItem.productName + "</td>";
                    row += "<td>" + historyItem.unitPrice + "</td>";
                    row += "<td>" + historyItem.orderQuantity + "</td>";
                    row += "<td>" + (historyItem.isInInventoryReceivings ? "입고됨" : createNotReceivedButton()) + "</td>";
                    row += "</tr>";
                    $("#result-tbody").append(row);
                });

                if (data.length === 0) {
                    $("#noResultMessage").show();
                } else {
                    $("#noResultMessage").hide();
                }
            },
            error: function (error) {
                console.error("Error during AJAX request:", error);
            }
        });
    }

    // 페이지가 로드될 때 데이터 로드
    loadHistoryData();

    // 매 5초마다 데이터를 새로 로드하여 테이블 최신화
    setInterval(loadHistoryData, 5000);

    // "입고되지 않음" 버튼을 생성하는 함수
    function createNotReceivedButton() {
        return "<button class='not-received-btn' style='background-color: red;'>입고되지 않음</button>";
    }
});

// 발주일자를 날짜 형식으로 변환하는 함수
function formatDate(timestamp) {
    var date = new Date(timestamp);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    return year + '-' + month + '-' + day;
}


$(document).on('click', '.not-received-btn', function() {
    var $thisRow = $(this).closest('tr');
    var orderDate = $thisRow.find("td:first").text(); // 해당 행의 첫 번째 열(td)에서 orderDate를 가져옴
    var productName = $thisRow.find("td:nth-child(2)").text(); // 상품명 추출

    var currentDate = new Date(); // 현재 날짜를 가져옴
    var formattedDate = formatDate(currentDate); // 현재 날짜를 포맷팅

    var storename = "${loginUserBean.storeName}";

    // AJAX 요청
    $.ajax({
        type: "POST",
        url: "${root}ownerRest/addInventoryReceiving",
        data: {
            orderDate: orderDate, // 해당 행의 orderDate 전달
            storeName: storeName,
            productName: productName
        },
        success: function(response) {
            // 성공 시 UI 업데이트 및 메시지 표시
            $thisRow.find("td:last").html("<span>입고됨</span>");
            alert("입고 확인"); // 성공 메시지 표시
        },
        error: function(xhr, status, error) {
            // 오류 발생 시 메시지 표시
            console.error("Error during AJAX request:", error);
            alert("오류가 발생하였습니다: " + xhr.responseText); // 오류 메시지와 원인 표시
        }
    });
});


/*
$(document).on('click', '.not-received-btn', function() {
    var $thisRow = $(this).closest('tr');
    var orderDate = $thisRow.find("td:first").text(); // 해당 행의 첫 번째 열(td)에서 orderDate를 가져옴
    var productName = $thisRow.find("td:nth-child(2)").text(); // 상품명 추출

    // AJAX 요청
    $.ajax({
        type: "POST",
        url: "${root}ownerRest/addInventoryReceiving",
        data: {
            orderDate: orderDate,
            storeName: storeName,
            productName: productName
        },
        success: function(response) {
            // 성공 시 UI 업데이트 및 메시지 표시
            if(response === "입고 처리 완료") {
                $thisRow.find("td:last").html("<span>입고됨</span>");
                alert("입고 확인");
            } else {
                alert(response); // 서버에서 반환한 메시지 표시
            }
        },
        error: function(xhr, status, error) {
            // 오류 발생 시 메시지 표시
            console.error("Error during AJAX request:", error);
            alert("오류가 발생하였습니다: " + xhr.responseText);
        }
    });
});
*/
</script>




<div class="side">
    <table id="result-table" class="responsive-table" align="center">
        <thead>
            <tr>
                <th colspan="5"><label for="search-box">제품명:</label> <input type="search" id="search-box"></th>
            </tr>
            <tr>
                <th>발주일자</th>
                <th>상품명</th>
                <th>단가</th>
                <th>수량</th>
                <th>입고여부</th>
            </tr>
        </thead>
        <tbody id="result-tbody"></tbody>
    </table>
    <div id="noResultMessage" style="display: none; color: red; font-weight: bold;">검색 결과가 없습니다.</div>
</div>
