package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class B_InvenRecBean {

	private String orderNo;
	private String productNo;
	private double unitPrice;
	private int orderQuantity;
	
	public B_InvenRecBean() {
		// TODO Auto-generated constructor stub
	}
}
