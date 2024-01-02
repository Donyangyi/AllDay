package kr.co.allday.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface InventoryMapper {

    @Update("MERGE INTO inventory USING dual ON (storename = #{storeName} AND productno = #{productNo}) " +
            "WHEN MATCHED THEN " +
            "UPDATE SET stockquantity = stockquantity + #{receivedQuantity} " +
            "WHEN NOT MATCHED THEN " +
            "INSERT (storename, productno, stockquantity) VALUES (#{storeName}, #{productNo}, #{receivedQuantity})")
    void updateOrInsertInventory(@Param("storeName") String storeName, 
                                 @Param("productNo") String productNo, 
                                 @Param("receivedQuantity") int receivedQuantity);
}