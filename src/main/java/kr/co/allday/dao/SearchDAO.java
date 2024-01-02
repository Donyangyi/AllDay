package kr.co.allday.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.mapper.SearchMapper;

@Repository
public class SearchDAO {

    @Autowired
    private SearchMapper searchMapper;

    public List<String> searchProductNames(String productName) {
    	System.out.println("DAO:"+productName);
        return searchMapper.searchProductNames(productName);
    }
    
}
