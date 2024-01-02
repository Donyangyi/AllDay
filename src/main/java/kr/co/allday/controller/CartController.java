package kr.co.allday.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.service.CartService;
import kr.co.allday.service.ProductService;

@Controller
@RequestMapping("/cart")
public class CartController {
	@Resource(name = "loginCart")
	private ArrayList<CartBean> loginCart;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductService productService;
	
	@GetMapping("cart_board")
	public String sb_board(Model model) {
		
		//cart에 담을때 중복 제거
		List<CartBean> uniqueProducts = cartService.getUniqueProducts(loginCart);
		model.addAttribute("uniqueProducts", uniqueProducts);
		
		model.addAttribute("loginCart", loginCart);
		return "cart/cart_board";
	}
	
	@GetMapping("cart_pro")
	public String cart_pro(@RequestParam("productName") String productName,	
							
			// String productName = @RequestParam("prodcutName");
			
							@RequestParam("retailPrice") int retailPrice,
							@RequestParam("stockQuantity") int stockQuantity
							
							
							) {
		
		if(loginUserBean.isMemberLogin() == false) {
			return "member/not_login";
		}
		
		//CartBean을 hip 메모리에 올려놨다.
		CartBean cartBean = new CartBean();
		
		cartBean.setProductName(productName); 		
		cartBean.setRetailPrice(retailPrice);
		cartBean.setStockQuantity(stockQuantity);
		
		cartService.addCart(cartBean);

	//	List<ProductBean> productBeans = productService.getAllProducts();
	//	model.addAttribute("productBeans", productBeans);
		
		return "redirect:../product/product_main";	//redirect로 불러오기.
	}
}