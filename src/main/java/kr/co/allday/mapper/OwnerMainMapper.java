package kr.co.allday.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.SelectKey;
import kr.co.allday.bean.OrderMainBean;

@Mapper
public interface OwnerMainMapper {
	@SelectKey(statement = "SELECT 'o'||lpad(orderno_seq.nextval, 3, '0') FROM dual", 
            keyProperty = "orderno", 
            before = true, 
            resultType = String.class)
    @Insert("INSERT INTO ordermain (orderno, storename, orderdate, orderername) " +
            "VALUES (#{orderno}, #{storename}, #{orderdate}, #{orderername})")
    void insertOrderMain(OrderMainBean orderMain);
}


