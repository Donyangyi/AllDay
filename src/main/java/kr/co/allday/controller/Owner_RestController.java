package kr.co.allday.controller;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.bean.B_InvenRecBean;
import kr.co.allday.bean.InvenRecBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.OrderHistoryBean;
import kr.co.allday.bean.ProductBean;
import kr.co.allday.mapper.InvenRecMapper;
import kr.co.allday.service.InvenRecService;
import kr.co.allday.service.OrderHistoryService;
import kr.co.allday.service.OwnerService;

@RestController
@RequestMapping("/ownerRest")
public class Owner_RestController {

	@Autowired
    private InvenRecService invenRecService;

    @Autowired
    private OrderHistoryService orderHistoryService; 
    
    @Autowired
    private OwnerService ownerService;

    @Autowired
    private InvenRecMapper invenRecMapper;
    
    @Resource(name = "loginUserBean")
    private MemberBean loginUserBean;

    
    @GetMapping("/get_order_history_data")//
    @ResponseBody
    public List<OrderHistoryBean> getOrderHistoryData(String storename) {//2. 여기를 실행
        System.out.println("Controller - storename: " + storename);

        //4. 3의 결과 가져와 실행
        List<OrderHistoryBean> orderHistoryList = orderHistoryService.getOrderHistoryList(storename);

        System.out.println("Controller - orderHistoryList: " + orderHistoryList);
        return orderHistoryList;
    }
    
    @GetMapping("/get_SearchProduct")
    @ResponseBody
    public List<ProductBean> SearchProduct(String ProductName) {
    	
    	List<ProductBean> SearchProduct = ownerService.SearchProduct(ProductName);
    	return SearchProduct;
    }
    
    @PostMapping("/addInventoryReceiving")
    @ResponseBody
    public String addInventoryReceiving(
            @RequestParam("orderDate") String orderDate,
            @RequestParam("storeName") String storeName,
            @RequestParam("productName") String productName) {
    	try {
        // invenRecMapper를 사용하여 데이터를 가져옴
        B_InvenRecBean result = invenRecMapper.getB_InvenRecBean(orderDate, storeName, productName);

        if (result != null) {
            // 가져온 데이터를 InvenRecService를 사용하여 가공
            InvenRecBean invenRecBean = invenRecService.processB_InvenRecBean(result);

         // InvenRecBean을 사용하여 DB에 insert 수행
            invenRecMapper.insertInvenRec(invenRecBean);
            
            invenRecService.updateInventory(storeName, invenRecBean);
          

            return "입고 처리 완료";
        } else {
            // 데이터를 찾을 수 없는 경우에 대한 처리
            return "데이터를 찾을 수 없습니다.";
        }
    	 } catch (Exception e) {
    	        // 예외 발생 시 로그에 오류 메시지 기록
    	        e.printStackTrace(); // 또는 로그 라이브러리를 사용하여 로그 출력
    	        return "오류 발생: " + e.getMessage(); // 또는 다른 오류 메시지 반환
    	    }
    }


}
