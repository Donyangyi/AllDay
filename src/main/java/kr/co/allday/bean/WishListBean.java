package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WishListBean {

	//찜
	private int rownum;
	
	private int wishlistNo;
	private String memberNo;
	private String productNo;
	
	//상품
	private String productName;
	private String productImage;
	
	//현재고
	private String storeName;
	
	//입고정보
	private String retailPrice;
}
