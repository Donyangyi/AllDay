<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
IMP.init("imp04761130")
const button = document.querySelector("button");
const onClickPay = async () => {
	IMP.request_pay({
		pg: "tosspayments",
		pay_method: "card",
		amount: 100,
		name: "콜라",
		merchant_uid: "OD0000002"
	}, function(response){
		const {status, err_msg} = response;
		if(err_msg){
			alert(err_msg);
		}
		if(status === "paid"){
			const{imp_uid} = response;
			verifyPayment(imp_uid);
		}
	});
};


</script>
</head>
<body>

<button onclick="onClickPay()">Pay Button</button>

</body>
</html>