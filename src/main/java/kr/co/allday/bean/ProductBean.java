package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
/*상품분류 테이블 Bean*/
public class ProductBean {

	//상품번호
	private String productNo;
	
	//분류
	private String productCategory;
	
	//상품명
	private String productName;
	
	//단가
	private int unitPrice;
	
	//영양정보
	private String nutrition;
	
	//상품이미지
	private String productImage;
	
}
