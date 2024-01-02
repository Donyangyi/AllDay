package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PayInfoBean {

	private String memberNo;
	private String storeName;
	private String productNo;
	private int paymentQuantity;
	private String paymentNo;
	
	private int totalQuantity;
	private String productImage;
	private String productName;
	private int retailPrice;
	private int countSoldProducts;
	
}
