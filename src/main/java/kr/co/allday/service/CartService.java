package kr.co.allday.service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.co.allday.bean.CartBean;

@Service
public class CartService {
	@Resource(name = "loginCart")//이건 문법이다.(세션까지 올라가있어)
	private ArrayList<CartBean> loginCart;
	
	
	//카트 담기
	public void addCart(CartBean cartBean) {
		loginCart.add(cartBean);
	}
	
	
	//cart에 담을때 중복 제거
	public List<CartBean> getUniqueProducts(List<CartBean> products) {
	    Set<String> productNames = new HashSet<>();
	    List<CartBean> uniqueProducts = new ArrayList<>();

	    for (CartBean product : products) {
	        if (productNames.add(product.getProductName())) {
	            uniqueProducts.add(product);
	        }
	    }
	    return uniqueProducts;
	}
	
	
	// 장바구니에 담긴 상품 리스트 가져오기
    public List<CartBean> getCartItems() {
        return new ArrayList<>(loginCart);
    }
    
	
	 // 장바구니에서 중복 제거된 상품 리스트 가져오기
    public List<CartBean> getUniqueProducts() {
        Set<String> productNames = new HashSet<>();
        List<CartBean> uniqueProducts = new ArrayList<>();

        for (CartBean product : loginCart) {
            if (productNames.add(product.getProductName())) {
                uniqueProducts.add(product);
            }
        }
        return uniqueProducts;
    }
    
    //cart의 amount값 변경하기
    public void updateAmount(String productName, int newAmount) {
        for (CartBean cartBean : loginCart) {
            if (cartBean.getProductName().equals(productName)) {
                cartBean.setAmount(newAmount);
                break;
            }
        }
    }
	
}

