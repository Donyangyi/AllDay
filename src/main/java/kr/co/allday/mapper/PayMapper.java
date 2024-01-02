package kr.co.allday.mapper;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.PayBean;
import kr.co.allday.bean.PayInfoBean;
import kr.co.allday.bean.ReservationBean;

public interface PayMapper {

	@Select("SELECT storename, SUM(paymentAmount) as totalAmount "
            + "FROM payments "
            + "GROUP BY storename")
    List<PayBean> getPayList();

	
	//결제번호 생성
    @SelectKey(statement = "select 'ODDTE'||lpad(payed_inc.nextval, 5, 0) from dual", keyProperty = "paymentNo", before = true, resultType = String.class)
    @Insert("INSERT INTO payments (paymentno, memberno, paymentdate, storename, paymentamount) VALUES (#{paymentNo}, #{memberNo}, SYSDATE, #{storeName}, #{paymentAmount})")
    void addPayment(PayBean payedBean);
    
    //위에서 생성된 결제번호 반환
    @Select("select max(paymentno) from payments")
    String getNewPaymentNo();
    
    //결제 실패 시 결제 번호 삭제
    @Delete("delete from payments where paymentno = #{paymentNo}")
    void deletePaymentNo(String paymentNo);
    
    //===========================================2023-12-09 추가된 부분==========================================================
    //결재 후 결재 내역 생성
    @Select("INSERT INTO paymentsinfo (memberno, storename, productno, paymentquantity, paymentno) "
    		+ "SELECT #{memberNo}, #{storeName}, a1.productno, #{paymentQuantity}, #{paymentNo} "
    		+ "FROM products a1 "
    		+ "WHERE a1.productname = #{productName}")
    void addPaymentInfo(PayInfoBean payInfoBean);
    
    //결제 후 현재고 업데이트
    @Update("UPDATE inventory SET stockquantity = stockquantity - #{paymentQuantity} "
    		+ "WHERE storename = #{storeName} "
    		+ "and productno = (select productno from products where productname = #{productName}) "
    		+ "and stockquantity >= #{paymentQuantity}")
    void updateQuantity(PayInfoBean payInfoBean);
    
    //결제 후 예약 정보 생성
    @SelectKey(statement = "select 'retest'||lpad(reservation_seq.nextval, 5, 0) from dual", keyProperty = "reservationNo", before = true, resultType = String.class)
    @Insert("insert into reservations (reservationno, memberno, paymentno, reservationdate, reservedquantity, pickupdate, pickupdeadline) "
    		+ "values (#{reservationNo}, #{memberNo}, #{paymentNo}, sysdate, #{reservedQuantity}, "
    		+ "TO_CHAR(TO_DATE(#{pickupDate}, 'YYYY-MM-DD HH24:MI'), 'YYYY-MM-DD HH24:MI'), "
    		+ "TO_CHAR(TO_DATE(#{pickupDate}, 'YYYY-MM-DD HH24:MI') + 1, 'YYYY-MM-DD HH24:MI'))")
    void addReservationInfo(ReservationBean reservation);
    
    //결제 정보 출력(마이페이지)
    @Select("SELECT distinct r.reservationdate, py.paymentno, r.pickupdate, r.pickupdeadline, pi.storename, p.productname, pi.paymentquantity, py.paymentamount "
    		+ "FROM reservations r "
    		+ "JOIN paymentsinfo pi ON r.paymentno = pi.paymentno "
    		+ "JOIN payments py ON pi.paymentno = py.paymentno "
    		+ "JOIN products p ON pi.productno = p.productno "
    		+ "JOIN memberinfo mi ON r.memberno = #{memberNo} "
    		+ "order by r.reservationdate desc, py.paymentno desc")
    List<ReservationBean> payHistory(String memberNo);
    
  //===========================================2023-12-07 추가된 부분==========================================================
    //많이 팔린 상품 탑 4만 가져오기
    @Select("select b1.productno, b1.productname, sum(a1.paymentquantity) as totalQuantity, b1.productimage, c1.retailprice "
    		+ "from paymentsinfo a1 "
    		+ "inner join products b1 on a1.productno = b1.productno "
    		+ "join inventoryreceivings c1 on b1.productno = c1.productno "
    		+ "group by b1.productno, b1.productname, b1.productimage, c1.retailprice "
    		+ "order by totalQuantity desc "
    		+ "FETCH FIRST 4 ROWS ONLY")
    ArrayList<PayInfoBean> countSoldProducts();
    
    //결재 후 포인트 업데이트
    @Update("update memberinfo set points = points + #{pointsPlus} where memberNo = #{memberNo}")
    void updatePointsPlus(@Param("pointsPlus") int pointsPlus, @Param("memberNo") String memberNo);
    
    @Update("update memberinfo set points = points - #{pointsMinus} where memberNo = #{memberNo}")
    void updatePointsMinus(@Param("pointsMinus") int pointsMinus, @Param("memberNo") String memberNo);
}
