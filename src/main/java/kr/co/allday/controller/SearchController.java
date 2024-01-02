package kr.co.allday.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.service.SearchService;
@Controller
public class SearchController {
	
	 @Autowired
	 private SearchService searchService;
	
	//검색어 자동완성 기능
    @GetMapping("/owner_auto_search")
    @ResponseBody
    public List<String> autocomplete(@RequestParam String query) {
    	System.out.println("Controller:"+query);
        return searchService.getSuggestions(query);
    }
    

}
