package kr.co.allday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.ProductBean;
import kr.co.allday.bean.ProductInvenReOrderDetailBean;
import kr.co.allday.bean.WishListBean;

/* 쿼리문 사용할 때 변수명 "카멜 기법" 사용했는지 확인하기 */

public interface ProductMapper {
	
	
	//상품메인페이지~~"지점명"까지 추가했써욤~~~
	@Select("SELECT iv.storeName, pd.productNo, pd.productCategory, pd.productName, pd.nutrition, pd.productImage, MAX(ivr.retailPrice) AS retailPrice "
			+ "FROM inventory iv "
			+ "INNER JOIN products pd ON iv.productNo = pd.productNo "
			+ "INNER JOIN ( "
			+ "	SELECT DISTINCT productno, orderno, retailprice "
			+ "	FROM inventoryreceivings "
			+ ") ivr ON pd.productno = ivr.productno "
			+ "WHERE iv.storeName = #{checkStore} "
			+ "GROUP BY iv.storeName, pd.productNo, pd.productCategory, pd.productName, pd.nutrition, pd.productImage "
			+ "order by pd.productNo")
	List<ProductInvenReOrderDetailBean> getAllProductInvenReOrderDetailBean(String checkStore);
	
	//카테고리별 상품 보기(사이드바기능구현)
	@Select("select distinct iv.storeName, pd.productNo, pd.productCategory, pd.productName, pd.nutrition, pd.productImage, MAX(ivr.retailPrice) AS retailPrice "
			+ "FROM products pd "
			+ "INNER JOIN inventory iv ON pd.productNo = iv.productNo "
			+ "INNER JOIN inventoryreceivings ivr ON pd.productNo = ivr.productNo "
			+ "GROUP BY pd.productNo, pd.productCategory, pd.productName, pd.unitPrice, pd.nutrition, pd.productImage, iv.storename, iv.stockQuantity "
			+ "HAVING pd.productCategory = #{productCategory} and iv.storeName = #{checkStore} "
			+ "order by pd.productNo")
	List<ProductInvenReOrderDetailBean> getProductCategory(@Param("productCategory") String productCategory, @Param("checkStore") String checkStore);
	
	//상품번호 끌고가서 detail에서 뿌리기
	@Select("select pd.productNo, pd.productCategory, pd.productName, pd.nutrition, pd.productImage, iv.stockQuantity, MAX(ivr.retailPrice) AS retailPrice "
			+ "FROM products pd "
			+ "INNER JOIN inventory iv ON pd.productNo = iv.productNo "
			+ "INNER JOIN inventoryreceivings ivr ON pd.productNo = ivr.productNo "
			+ "GROUP BY pd.productNo, pd.productCategory, pd.productName, pd.unitPrice, pd.nutrition, pd.productImage, iv.storename, iv.stockQuantity "
			+ "HAVING pd.productNo = #{productNo} and iv.storeName = #{checkStore} "
			+ "order by pd.productNo")
	ProductInvenReOrderDetailBean getProductInfo(@Param("productNo") String productNo, @Param("checkStore") String checkStore);
	
	//detail에서 추천 상품 띄우기
	@Select("SELECT distinct * FROM ( "
			+ "    SELECT p.productNo, p.productCategory, p.productName, p.productImage, "
			+ "           iv.storeName, iv.stockQuantity, ivr.receivingNo, ivr.orderNo, ivr.retailPrice "
			+ "    FROM products p "
			+ "    JOIN inventory iv ON p.productNo = iv.productNo "
			+ "    JOIN inventoryreceivings ivr ON iv.productNo = ivr.productNo "
			+ "    WHERE  iv.storeName = #{checkStore} "
			+ "    ORDER BY DBMS_RANDOM.VALUE "
			+ ") WHERE ROWNUM <= 5")
	List<ProductInvenReOrderDetailBean> getRecommendProd(String checkStore);

	//찜 TB에 상품 담겼는지 확인
	@Select("select productNo from wishlist where memberNo = #{memberNo} and productNo = #{productNo}")
	List<WishListBean> checkWishList(@Param("memberNo") String memberNo, @Param("productNo") String productNo);

	//찜 목록 리스트 띄우기
	@Select("select rownum, pd.productName, pd.productNo, pd.productImage, ivr.retailPrice, iv.storeName, wl.memberNo "
			+ "from wishlist wl join products pd "
			+ "on wl.productNo = pd.productNo "
			+ "join inventoryreceivings ivr "
			+ "on pd.productNo = ivr.productNo "
			+ "join inventory iv "
			+ "on pd.productNo = iv.productNo "
			+ "where iv.storeName = #{checkStore} and wl.memberNo = #{memberNo}")
	List<WishListBean> getWishList(@Param("checkStore") String checkStore, @Param("memberNo") String memberNo);
	
	//찜 테이블에 상품 넣기
	@Insert("insert into wishlist(wishlistNo, memberNo, productNo) values(wishlistno_seq.nextval, #{memberNo}, #{productNo})")
	void addWishList(@Param("memberNo") String memberNo, @Param("productNo") String productNo);
	
	//찜 빼기
	@Delete("delete from wishlist where memberNo = #{memberNo} and productNo = #{productNo}")
	void deleteWishList(@Param("memberNo") String memberNo, @Param("productNo") String productNo);
	
	@Insert("insert into products(productNo, productName, unitprice) "
			+ "values(Product_Inc.nextval,#{productName},#{unitprice})")
	void addProductInfo(ProductBean inputproductBean);
	
	//검색 기능
	@Select("SELECT p.productno, p.productcategory, p.productname, MAX(ir.retailprice) AS retailprice, p.nutrition, p.productimage "
			+ "FROM products p "
			+ "JOIN inventory i ON p.productno = i.productno "
			+ "JOIN inventoryreceivings ir ON ir.productno = i.productno "
			+ "WHERE (p.productname LIKE '%' || #{keyword} || '%' OR p.productcategory LIKE '%' || #{keyword} || '%') "
			+ "AND i.storename = #{storeName} "
			+ "GROUP BY p.productno, p.productcategory, p.productname, p.nutrition, p.productimage")
	List<ProductInvenReOrderDetailBean> searchProducts(@Param("keyword") String keyword, @Param("storeName") String storeName);

}
