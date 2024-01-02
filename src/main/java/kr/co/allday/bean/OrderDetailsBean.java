package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderDetailsBean {
	
	private String orderno;
    private String productno;
    private int orderquantity;
    private int supplyprice;
    
    //필요에 따라 생성자

}
