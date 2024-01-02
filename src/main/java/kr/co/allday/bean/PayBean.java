package kr.co.allday.bean;



import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PayBean {

	private String paymentNo; //디비처리
	private String memberNo;  //세션처리
	private Date paymentDate; //디비처리 
	private String storeName; //세션처리
	private int paymentAmount; //받아와야함
	
	
	private int totalAmount;//매출합계용
	
	public PayBean() {
		
	}
	
	public PayBean(String paymentNo, int paymentAmount, String storeName, int totalAmount) {

		this.paymentNo = paymentNo;
		this.paymentAmount = paymentAmount;
		this.storeName = storeName;
		this.totalAmount = totalAmount;
	}
	
	
	
	
}
