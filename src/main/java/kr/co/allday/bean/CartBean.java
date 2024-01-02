package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CartBean {

	// 상품명(products)
	private String productName;		// 내가 설정한 값
	
	// 수량
	private int amount;		// 자동으로 설정되는 값
	
	// 가격(입고)
	private int retailPrice;		// 내가 설정한 값
	private int stockQuantity;
	
	public CartBean() {
		this.amount = 1;
	}
	
}