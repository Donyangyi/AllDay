package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InventoryBean {
	
	private String InventoryNum; 
	private int InventoryQuantity;
	private String StoreID;
	private String ReceiptNum;
	private String DiscardNum;
	private String TransactionNum;
	private String Receip_ReceiptNum;
	private String Discard_DiscardNum;
	
}
