package kr.co.allday.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.ProductBean;
import kr.co.allday.bean.ProductInvenReOrderDetailBean;
import kr.co.allday.bean.WishListBean;
import kr.co.allday.dao.ProductDAO;

@Service
public class ProductService {

	@Autowired
	private ProductDAO productDao;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	public List<ProductInvenReOrderDetailBean> getAllProductInvenReOrderDetailBean(String checkStore){
		
		return productDao.getAllProductInvenReOrderDetailBean(checkStore);
	}
	
	public List<ProductInvenReOrderDetailBean> getProductCategory(String productCategory, String checkStore){
		
		return productDao.getProductCategory(productCategory, checkStore);
	}
	
	public void addProductInfo(ProductBean inputproductBean) {
		productDao.addProductInfo(inputproductBean);
	}
	
	public List<ProductInvenReOrderDetailBean> getRecommendProd(String checkStore){
		return productDao.getRecommendProd(checkStore);
	}
	
/*	
	public List<ProductBean> getAllProducts(){
		//List<ProductBean> p1 = productDao.getAllProducts();
		//System.out.println(p1);
		//System.out.println("Service호출");
		return productDao.getAllProducts();
	}
*/	
	
	public ProductInvenReOrderDetailBean getProductInfo(String productNo, String checkStore) {
		return productDao.getProductInfo(productNo, checkStore);
	}

	/*	
	//정렬
	public List<ProductInvenReOrderDetailBean> getNewProduct(@Param("productCategory") String productCategory, @Param("checkStore") String checkStore){
		return productDao.getNewProduct(productCategory, checkStore);
	}
	
	public List<ProductInvenReOrderDetailBean> getOrderByLowPrice(@Param("productCategory") String productCategory, @Param("checkStore") String checkStore){
		return productDao.getOrderByLowPrice(productCategory, checkStore);
	}
	
	public List<ProductInvenReOrderDetailBean> getOrderByHighPrice(@Param("productCategory") String productCategory, @Param("checkStore") String checkStore){
		return productDao.getOrderByHighPrice(productCategory, checkStore);
	}
*/
	
	//찜
/*	public WishListBean checkWishList(String memberNo, String productNo) {
		System.out.println("2. checkWishList: " + productNo);
		return productDao.checkWishList(memberNo, productNo);
	}
*/
	public List<WishListBean> getWishList(String checkStore, String memberNo) {
		
		return productDao.getWishList(checkStore, memberNo);
	}
	public void addWishList(String memberNo, String productNo) {
		productDao.addWishList(memberNo, productNo);
	}
	
	public void deleteWishList(String memberNo, String productNo) {
		productDao.deleteWishList(memberNo, productNo);
	}
	/*
	 * public void deleteWishListByName(String memberNo, String productNo) {
	 * productDao.deleteWishListByName(memberNo, productNo); }
	 */
	
	public boolean toggleWishlist(String memberNo, String productNo) {
        // 찜 목록에 상품이 있는지 확인
		List<WishListBean> existingProduct = productDao.checkWishList(memberNo, productNo);
		
		// 찜 목록에 상품이 없는 경우 (빈 리스트)
        if (existingProduct.isEmpty()) {
            // 찜 목록에 상품이 없으면 추가
            productDao.addWishList(memberNo, productNo);
            return true; // 찜 추가됨
        } else {
            // 찜 목록에 상품이 있으면 삭제
            productDao.deleteWishList(memberNo, productNo);
            return false; // 찜 삭제됨
        }
    }
	
	

/*	
	//지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠-지용오빠//
	public boolean addWishList(String productno) {
		
		//checkWishList 위시리스트에서 회원번호와 상품번호를 동시에 일치하는 상품 번호를 가져옴 
		String tempProductno = productDao.checkWishList(loginUserBean.getMemberNo(), productno);
		
		if(tempProductno == null) {
			productDao.addWishList(loginUserBean.getMemberNo(), productno);
			return true;
		}
		else {
			productDao.deleteWishList(loginUserBean.getMemberNo(), tempProductno);
			return false;
		}
	}
*/
	
/*	
	public String getMemberNo(String memberid) {
		return productDao.getMemberNo(memberid);
	}
	
	public List<ProductBean> getOrderByLowPrice(){
		return productDao.getOrderByLowPrice();
	}
	
	public List<ProductBean> getOrderByHighPrice(){
		return productDao.getOrderByHighPrice();
	}
	

	*/
	

	
}
