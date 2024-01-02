package kr.co.allday.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import kr.co.allday.bean.CartBean;
import kr.co.allday.service.CartService;

@Controller
@RequestMapping("/customer_order")
public class CustomerOrderController {

    @Autowired
    private CartService cartService;

    @GetMapping("customer_order")
    public String customer_order(Model model) {
        // 장바구니에 담긴 상품 리스트를 가져옵니다.
        List<CartBean> cartItems = cartService.getCartItems(); // 가정한 메서드 이름입니다.

        // 중복 제거 로직을 여기에 추가하거나 CartService 내부에서 처리합니다.
        List<CartBean> uniqueProducts = cartService.getUniqueProducts(cartItems);

        // 모델에 uniqueProducts 리스트를 추가합니다.
        model.addAttribute("uniqueProducts", uniqueProducts);

        return "customer_order/customer_order";
    }
}
