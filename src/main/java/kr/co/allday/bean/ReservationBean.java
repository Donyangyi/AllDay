package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ReservationBean {

	// 이거 두개 추가함
	private String storeName;
	private String productName;

	private String reservationNo; // DB에서 생성되는 값
	private String memberNo; // 로그인 객체가 가지고 있는 값
	private String paymentNo; // 결제시에 받아와야 하는 값 (프론트)
	private String reservationDate; // DB에서 생성되는 값
	private int reservedQuantity; // 결제 했던 모든 수량 (프론트)
	private String pickupDeadline; // DB에서 생성되는 값 (pickupDate를 이용)
	private String pickupDate; // 사용자가 지정한 일자 (프론트)

}
