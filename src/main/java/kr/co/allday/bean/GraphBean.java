package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GraphBean {
	
	private String sale_month;			//labels (하단 부분)
	private String storeName;			//검색 조건
	private String productName;			//label(data부분)
	private int max_quantity_sold;		//data
	
}
