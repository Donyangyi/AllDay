package kr.co.allday.mapper;

import kr.co.allday.bean.OrderDetailsBean;
import org.apache.ibatis.annotations.*;

@Mapper
public interface OrderDetailsMapper {
    
    @Insert("INSERT INTO orderdetails (orderno, productno, orderquantity, supplyprice) " +
            "VALUES (#{orderno}, #{productno}, #{orderquantity}, #{supplyprice})")
    void insertOrderDetails(OrderDetailsBean orderDetails);

    @Select("SELECT MAX(orderno) FROM ordermain")
    String getLatestOrderNo();
}
