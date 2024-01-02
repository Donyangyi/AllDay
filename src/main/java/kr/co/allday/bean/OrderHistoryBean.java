package kr.co.allday.bean;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class OrderHistoryBean {

	private Date orderDate;
	private String productName;
	private int unitPrice;
	private int orderQuantity;
	private boolean IsInInventoryReceivings;	//입고여부 파악을 위해 추가
	
	public OrderHistoryBean(Date orderDate, String productName, int unitPrice, int orderQuantity, boolean IsInInventoryReceivings) {

		this.orderDate = orderDate;
		this.productName = productName;
		this.unitPrice = unitPrice;
		this.orderQuantity = orderQuantity;
		this.IsInInventoryReceivings= IsInInventoryReceivings;
	}
	
	
	
}
