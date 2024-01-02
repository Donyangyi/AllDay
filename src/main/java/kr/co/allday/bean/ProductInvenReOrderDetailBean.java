package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ProductInvenReOrderDetailBean {

	//Inventory (점포명, 재고수량)
	private String storeName;
	private int stockQuantity;
	
	//Products (상품번호, 분류, 상품명, 이미지)
	private String productNo;
	private String productCategory;
	private String productName;
	private String nutrition;
	private String productImage;
	
	//OrderDetails(
	private String orderNo;
	
	//InventoryReceivings (소비자가격)
	private String retailPrice;
}
