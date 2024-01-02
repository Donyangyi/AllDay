package kr.co.allday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.ProductBean;

public interface OwnerMapper {
	
	@Select("SELECT ProductName, PRoductNo, UnitPrice "+
			"FROM products "+
			"WHERE ProductName LIKE LOWER('%' || #{productName} || '%') " +
			"ORDER BY PRoductNo"
			)
	List<ProductBean> SearchProduct(String ProductName);

}
