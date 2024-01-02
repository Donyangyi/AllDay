package kr.co.allday.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import kr.co.allday.bean.B_InvenRecBean;
import kr.co.allday.bean.InvenRecBean;

@Mapper
public interface InvenRecMapper {
	
	@SelectKey(statement = "SELECT 'RECE'||lpad(receivingno_seq.nextval, 5, '0') FROM dual", 
	           keyProperty = "receivingNo", // 변경: "receivingno" -> "receivingNo"
	           before = true, 
	           resultType = String.class)
	@Insert("INSERT INTO inventoryreceivings (receivingno, orderno, productno, receivingdate, expirationdate, receivedquantity, retailprice) " +
	           "VALUES (#{receivingNo}, #{orderNo}, #{productNo}, #{receivingDate}, #{expirationDate}, #{receivedQuantity}, #{retailPrice})")
	void insertInvenRec(InvenRecBean invenRec);

	
	
	@Select("SELECT b.orderno, a.productno, c.unitprice, a.orderquantity " +
	        "FROM orderdetails a " +
	        "INNER JOIN ordermain b ON a.orderno = b.orderno " +
	        "INNER JOIN products c ON c.productno = a.productno " +
	        "WHERE TO_CHAR(b.orderdate, 'YYYY-MM-DD') = #{orderDate} " +
	        "AND b.storename = #{storeName} " +
	        "AND c.productname = #{productName}")
	B_InvenRecBean getB_InvenRecBean(@Param("orderDate") String orderDate,
	                                 @Param("storeName") String storeName,
	                                 @Param("productName") String productName);


}
