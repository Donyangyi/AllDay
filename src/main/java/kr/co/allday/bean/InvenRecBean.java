package kr.co.allday.bean;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class InvenRecBean {
	
	private String receivingNo;		//시퀸스로 가져올거임
    private String orderNo;			//B_InvenRecBean테이블에서 가져옴
    private String productNo;		//B_InvenRecBean테이블에서 가져옴
    private Date receivingDate;		//누른 날짜
    private Date expirationDate;	//orderNo앞글자가 A면 receivingdate에 +3일, B면 +1년, C면 2년, D도 2년, E는 1년, F는 3년 추가한 일자
    private int receivedQuantity;	//orderQuantity
    private double retailPrice;		//unitPrice * 0.3의 결과의 소수 첫쨰짜리 까지 표시
    
    public InvenRecBean() {
		// TODO Auto-generated constructor stub
	}
    
}
