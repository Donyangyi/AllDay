package kr.co.allday.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.OrderHistoryBean;

public interface OrderHistoryMapper {
	@Select({
		    "SELECT b.OrderDate, c.ProductName, c.UnitPrice, a.OrderQuantity, ",
		    "       CASE WHEN i.receivingno IS NOT NULL THEN 1 ELSE 0 END AS isInInventoryReceivings ",
		    "FROM orderdetails a ",
		    "INNER JOIN ordermain b ON a.orderno = b.orderno ",
		    "INNER JOIN products c ON c.productno = a.productno ",
		    "LEFT JOIN inventoryreceivings i ON i.orderno = a.orderno AND i.productno = a.productno ",
		    "WHERE b.storename = #{storename} ",
		    "order BY b.OrderDate Desc"
	})
	List<OrderHistoryBean> selectHistory(
	    @Param("storename") String storename
	);



    //7. store 넣고 해당 쿼리문 실행, 이후 역순으로 결과 리턴
    
    // 추가된 로그
    default void log(String message) {
        System.out.println("OrderHistoryMapper - " + message);
    }
}
