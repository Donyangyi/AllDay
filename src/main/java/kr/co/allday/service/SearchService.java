package kr.co.allday.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.dao.SearchDAO;

@Service
public class SearchService {

    @Autowired
    private SearchDAO searchDAO;

    public List<String> getSuggestions(String productName) {
    	System.out.println("Service:"+productName);
        return searchDAO.searchProductNames(productName);
    }
    
}
