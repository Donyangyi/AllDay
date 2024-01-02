package kr.co.allday.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.bean.ProductInvenReOrderDetailBean;
import kr.co.allday.bean.WishListBean;
import kr.co.allday.mapper.ProductMapper;

@Repository
public class ProductDAO {

	@Autowired
	private ProductMapper productMapper;
	
	public List<ProductInvenReOrderDetailBean> getAllProductInvenReOrderDetailBean(String checkStore){
		return productMapper.getAllProductInvenReOrderDetailBean(checkStore);
	}
	
	public List<ProductInvenReOrderDetailBean> getProductCategory(String productCategory, String checkStore){
		return productMapper.getProductCategory(productCategory, checkStore);
	}
	
	public ProductInvenReOrderDetailBean getProductInfo(String productNo, String checkStore) {
		
		return productMapper.getProductInfo(productNo, checkStore);
	}
	
	public List<ProductInvenReOrderDetailBean> getRecommendProd(String checkStore){
		
		return productMapper.getRecommendProd(checkStore);
	}
	
	public List<WishListBean> checkWishList(String memberNo, String productNo) {
		System.out.println("1. checkWishList: " + productNo);
		return productMapper.checkWishList(memberNo, productNo);
	}

	public List<WishListBean> getWishList(String checkStore, String memberNo) {
		return productMapper.getWishList(checkStore, memberNo);
	}
	
	public void addWishList(String memberNo, String productNo) {
		productMapper.addWishList(memberNo, productNo);
	}
	
	public void deleteWishList(String memberNo, String productNo) {
		productMapper.deleteWishList(memberNo, productNo);
	}
	
	public void addProductInfo(ProductBean inputproductBean) {
		productMapper.addProductInfo(inputproductBean);
	}
	
	public List<ProductInvenReOrderDetailBean> searchProducts(String keyword, String storeName){
		return productMapper.searchProducts(keyword, storeName);
	}

}


