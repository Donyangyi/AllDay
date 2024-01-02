package kr.co.allday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.ProductBean;

public interface SearchMapper {
	//실시간 상품 검색어 자동완성 기능
	@Select("SELECT productname " +
	        "FROM products " +
	        "WHERE LOWER(productname) LIKE LOWER('%' || #{productName} || '%')")
	List<String> searchProductNames(@Param("productName") String productName);

    
}