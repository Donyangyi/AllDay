package kr.co.allday.bean;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrderMainBean {
	
    private String orderno;
    private String storename;
    private Date orderdate;
    private String orderername;
    
    //필요에 따라 생성자
  
}