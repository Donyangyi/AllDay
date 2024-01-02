package kr.co.allday.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.PayBean;
import kr.co.allday.bean.PayInfoBean;
import kr.co.allday.bean.ReservationBean;
import kr.co.allday.mapper.PayMapper;

@Repository
public class PayDAO {

    @Autowired
    private PayMapper payMapper;

    //결제 리스트 조회
    public List<PayBean> getPayList() {  
        return payMapper.getPayList();
    }
    
    //결재 번호 생성
    public void addPayment(PayBean payedBean) {
    	payMapper.addPayment(payedBean);
    }
    
    //결제 번호 반환
    public String getNewPaymentNo() {
    	return payMapper.getNewPaymentNo();
    }
    
    //결제 실패 시 결제 번호 삭제
    public void deletePaymentNo(String paymentNo) {
    	payMapper.deletePaymentNo(paymentNo);
    }
    
    //===========================================2023-12-09 추가된 부분==========================================================
    //결제 후 결제 정보 생성
    public void addPaymentInfo(PayInfoBean payInfoBean) {
    	payMapper.addPaymentInfo(payInfoBean);
    }
    
    //결제 후 현재고 업데이트
    public void updateQuantity(PayInfoBean payInfoBean) {
    	payMapper.updateQuantity(payInfoBean);
    }
    
    //결제 후 예약 정보 생성
    public void addReservationInfo(ReservationBean reservation) {
    	payMapper.addReservationInfo(reservation);
    }
    
    //결제 정보 출력(마이페이지)
    public List<ReservationBean> payHistory(String memberNo){
    	return payMapper.payHistory(memberNo);
    }
    
    //===========================================2023-12-07 추가된 부분==========================================================
    //많이 팔린 상품 탑 4만 가져오기
    public ArrayList<PayInfoBean> countSoldProducts(){
    	return payMapper.countSoldProducts();
    }
    
    //결재 후 포인트 업데이트
    public void updatePointsPlus(int pointsPlus, String memberNo) {
    	payMapper.updatePointsPlus(pointsPlus, memberNo);
    }
    
    //결재 후 포인트 업데이트
    public void updatePointsMinus(int pointsMinus, String memberNo) {
    	payMapper.updatePointsMinus(pointsMinus, memberNo);
    }
    
}
