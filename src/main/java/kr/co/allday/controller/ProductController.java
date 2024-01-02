package kr.co.allday.controller;

import java.util.List;
import java.util.Optional;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.ProductBean;
import kr.co.allday.bean.ProductInvenReOrderDetailBean;
import kr.co.allday.bean.WishListBean;
import kr.co.allday.dao.ProductDAO;
import kr.co.allday.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	//백->뷰: Model
	//뷰->백:@RequestParam

	@Autowired
	private ProductService productService;
	
	@Autowired
	private ProductDAO productDAO;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	// 전체 상품페이지
	@GetMapping("/product_main")
	public String product_main(@RequestParam(value = "productCategory", required = false) String productCategory,
	                           @RequestParam(value = "keyword", required = false) String keyword,
	                           Model model) {
		System.out.println("컨트롤러 호출중");
	    String storeName = loginUserBean.getCheckStore();

	    if (keyword != null && !keyword.isEmpty()) {
	        List<ProductInvenReOrderDetailBean> searchResults = productDAO.searchProducts(keyword, storeName);
	        System.out.println("객체 반환 : " + searchResults);
	        model.addAttribute("productInvenReOrderDetailBeans", searchResults);
	        model.addAttribute("isSearchResult", true);
	    } else {
	        List<ProductInvenReOrderDetailBean> productInvenReOrderDetailBeans;
	        if (productCategory == null || productCategory.equals("all")) {
	            productInvenReOrderDetailBeans = productService.getAllProductInvenReOrderDetailBean(storeName);
	        } else {
	            productInvenReOrderDetailBeans = productService.getProductCategory(productCategory, storeName);
	        }
	        model.addAttribute("productInvenReOrderDetailBeans", productInvenReOrderDetailBeans);
	        model.addAttribute("isSearchResult", false);
	    }

	    return "product/product_main";
	}
	
	
	// 상품 상세페이지
	@GetMapping("/product_detail")
	public String product_detail(@RequestParam("productNo") String productNo, Model model) {
	    
	    // 사용자 정보
	    String memberNo = loginUserBean.getMemberNo();
	    model.addAttribute("memberNo", memberNo);
	    
	    // 상품 정보 조회
	    ProductInvenReOrderDetailBean readProductBean = productService.getProductInfo(productNo, loginUserBean.getCheckStore());
	    model.addAttribute("readProductBean", readProductBean);
	    
	    // 추천 상품 목록 조회
	    List<ProductInvenReOrderDetailBean> recommProd = productService.getRecommendProd(loginUserBean.getCheckStore());
	    recommProd.removeIf(prod -> prod.getProductNo().equals(productNo));
	    if (recommProd.size() > 4) {
	        recommProd.remove(recommProd.size() - 1);
	    }
	    model.addAttribute("recommProd", recommProd);
	    
	    // 찜 여부 확인
	    boolean isWishlisted = productService.toggleWishlist(memberNo, productNo);
	    model.addAttribute("isWishlisted", isWishlisted);
	    
	    // 찜 여부에 따라 이미지 경로 설정
	    String imagePath = isWishlisted ? "heart.png" : "noheart.png";
	    model.addAttribute("wishlistImage", imagePath);

	    return "product/product_detail";
	}
	    
	
		// 찜 목록페이지
		@GetMapping("/product_like")
		public String getMemberNo(Model model) {
			
			List<WishListBean> showWish = productService.getWishList(loginUserBean.getCheckStore(), loginUserBean.getMemberNo());
			model.addAttribute("showWish", showWish);
			
			return "product/product_like";
		}
		
	
	@GetMapping("/product_delete")
	public String deleteWishList(@RequestParam("productNo") String productNo, Model model) {
		 
		productService.deleteWishList(loginUserBean.getMemberNo(), productNo);
		model.addAttribute("productNo", productNo);
		
	    return "redirect:/product/product_like";
	}
	
	
	@PostMapping("/product_pro")
	public String product_pro(@ModelAttribute("inputproductBean") ProductBean inputproductBean) {
		
		productService.addProductInfo(inputproductBean);
		
		return "product/product_main";
	}

	// 예약
	@GetMapping("/product_reservation")
	public String reservation() {
		return "product/product_reservation";
	}

	// 요청
	@GetMapping("/product_request")
	public String request() {
		return "product/product_request";
	}
	
	//검색기능
	@GetMapping("/search")
	public String search(@RequestParam("keyword") String keyword) {
	    // 검색어를 쿼리 파라미터로 추가하여 리디렉트
	    return "redirect:/product/product_main?searchKeyword=" + keyword;
	}
	
	
}