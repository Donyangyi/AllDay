package kr.co.allday.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.OrderDetailsBean;
import kr.co.allday.bean.OrderMainBean;
import kr.co.allday.bean.OwnerCartBean;
import kr.co.allday.mapper.OrderDetailsMapper;
import kr.co.allday.service.OwnerCartService;


@RestController
public class OwnerCartController {
	

	//OwnerCartBean객체 생성 후 OwnerCart에 넣기
    @Resource(name = "OwnerCart")
    private ArrayList<OwnerCartBean> OwnerCart;

    @Resource(name = "loginUserBean")
    private MemberBean loginUserBean; // 직접적으로 세션의 loginUserBean을 주입받음
    
    @Autowired
    private OwnerCartService ownerCartService;

    @Autowired
	private OrderDetailsMapper orderDetailsMapper;
    

    
    
    

    @PostMapping("/addOwnerCart")
    public String addOwnerCart(@RequestParam("productName") String productName,
                               @RequestParam("productNo") String productNo,
                               @RequestParam("unitPrice") String unitPrice) {

        boolean itemExists = false;

        // OwnerCart 리스트를 순회하여 동일한 storeName과 productNo를 가진 객체가 있는지 확인
        for (OwnerCartBean cartItem : OwnerCart) {
            if (cartItem.getStoreName().equals(loginUserBean.getStoreName()) && 
                cartItem.getProductNo().equals(productNo)) {
                // 일치하는 객체가 있으면 수량 증가
                cartItem.setOrderQuantity(cartItem.getOrderQuantity() + 1);
                itemExists = true;
                break;
            }
        }

        // 일치하는 객체가 없는 경우 새로운 객체를 추가
        if (!itemExists) {
            OwnerCartBean ownerCartBean = new OwnerCartBean();
            ownerCartBean.setProductName(productName);
            ownerCartBean.setProductNo(productNo);
            ownerCartBean.setUnitPrice(Integer.parseInt(unitPrice));
            ownerCartBean.setMemberID(loginUserBean.getMemberID());
            ownerCartBean.setStoreName(loginUserBean.getStoreName());
            ownerCartBean.setMemberName(loginUserBean.getMemberName());
            OwnerCart.add(ownerCartBean);
        }
        System.out.println("add:");
        displayOwnerCartContents();
        System.out.println("--------------------------------------------------------------------------------------------------------------------------------------------------------------");
        return "success";
    }

 /////////////////////////////////////OwnerCartBean객체 중 storeName이 일치하는 것만 배열형태로 전달///////////////////////////////////////////////////////////
    
    @PostMapping("/getStoreOwnerCart")
    public ArrayList<OwnerCartBean> getStoreOwnerCart(@RequestParam("storeName") String storeName) {
        ArrayList<OwnerCartBean> filteredCart = new ArrayList<>();
        for (OwnerCartBean ownercartBean : OwnerCart) {
            if (ownercartBean.getStoreName().equals(storeName)) {
                filteredCart.add(ownercartBean);
            }
        }
        
        System.out.println("get:");
        displayOwnerCartContents();
        System.out.println("--------------------------------------------------------------------------------------------------------------------------------------------------------------");

        return filteredCart;
    }
    
    ////////////////////////삭제///////////////////////////////////////
    @PostMapping("/removeCheckedItems")
    public String removeCheckedItems(@RequestParam("storeName") String storeName, 
                                     @RequestParam("productNos") String productNosStr) {
        // 문자열을 쉼표(,)를 기준으로 분할하여 List<String>으로 변환
        // productNosStr에는 "123,456,789"와 같은 형태로 데이터가 들어오며,
        // 이를 ["123", "456", "789"]와 같은 리스트로 변환합니다.
        List<String> productNos = Arrays.asList(productNosStr.split(","));

        // OwnerCart에서 조건에 맞는 항목을 제거
        // 람다 표현식(cartItem -> ...)을 사용하여 조건을 정의합니다.
        // 이 표현식은 OwnerCart의 각 cartItem에 대해 다음 조건을 검사합니다:
        // 1. cartItem의 storeName이 메소드에 전달된 storeName과 동일한지,
        // 2. cartItem의 productNo가 productNos 리스트에 포함되어 있는지.
        // 두 조건을 모두 만족하는 cartItem을 OwnerCart에서 제거합니다.
        OwnerCart.removeIf(ownercartItem -> ownercartItem.getStoreName().equals(storeName) 
            && productNos.contains(ownercartItem.getProductNo()));
        
        
        System.out.println("remove:");
        displayOwnerCartContents();
        System.out.println("--------------------------------------------------------------------------------------------------------------------------------------------------------------");

        return "items removed";
    }
    
    
    
    /////////////////////////////////수량변경///////////////////////////////////////////////////////
    @PostMapping("/updateOwnerCartQuantity")
    public String updateOwnerCartQuantity(@RequestParam("storeName") String storeName,
                                          @RequestParam("productNo") String productNo,
                                          @RequestParam("newQuantity") int newQuantity) {
        for (OwnerCartBean cartItem : OwnerCart) {
            if (cartItem.getStoreName().equals(storeName) && cartItem.getProductNo().equals(productNo)) {
                cartItem.setOrderQuantity(newQuantity);
                break;
            }
        }
        System.out.println("updated:");
        displayOwnerCartContents();
        System.out.println("--------------------------------------------------------------------------------------------------------------------------------------------------------------");

        return "Quantity updated";
    }
    
    //OrderMain 추가
    @PostMapping("/ownerCart/OrderMain")
    public ResponseEntity<?> insertOrder(@RequestBody OrderMainBean orderMain) {
        ownerCartService.createOrder(orderMain);
        return ResponseEntity.ok().build();
    }
    
  
    //Orderdetails 추가
    @PostMapping("/ownerCart/insertOrderDetails")
    public ResponseEntity<?> insertOrderDetails(
            @RequestParam("storeName") String storeName,
            @RequestParam("productNos") List<String> productNos) {
        
        // 선택된 ProductNo들과 일치하는 OwnerCartBean 객체들을 찾습니다.
        List<OwnerCartBean> selectedCartBeans = new ArrayList<>();
        for (OwnerCartBean cartItem : OwnerCart) {
            if (cartItem.getStoreName().equals(storeName) && productNos.contains(cartItem.getProductNo())) {
                selectedCartBeans.add(cartItem);
            }
        }

        // 최신 주문 번호 가져오기
        String latestOrderNo = orderDetailsMapper.getLatestOrderNo();

        // 선택된 OwnerCartBean 객체들로부터 OrderDetailsBean 객체들 생성 및 삽입
        for (OwnerCartBean cartItem : selectedCartBeans) {
            OrderDetailsBean orderDetails = new OrderDetailsBean();
            orderDetails.setOrderno(latestOrderNo);
            orderDetails.setProductno(cartItem.getProductNo());
            orderDetails.setOrderquantity(cartItem.getOrderQuantity());
            orderDetails.setSupplyprice(cartItem.getSupplyPrice());

            orderDetailsMapper.insertOrderDetails(orderDetails);
        }

        // OwnerCart 리스트에서 해당 객체들 제거
        OwnerCart.removeAll(selectedCartBeans);

        // 성공적으로 처리되었음을 나타내는 ResponseEntity 반환
        return ResponseEntity.ok().build();
    }

    
    
    
    
    
    
 // OwnerCart의 내용을 콘솔에 출력하는 메소드
    public void displayOwnerCartContents() {
        // OwnerCart 리스트의 복사본을 생성
        List<OwnerCartBean> copyOfOwnerCart = new ArrayList<>(OwnerCart);

        if (copyOfOwnerCart.isEmpty()) {
            System.out.println("OwnerCart is empty.");
        } else {
            System.out.println("OwnerCart Contents:");
            for (OwnerCartBean cartItem : copyOfOwnerCart) {
                System.out.println(cartItem);
            }
        }
    }


}
