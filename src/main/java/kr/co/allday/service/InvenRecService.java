package kr.co.allday.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import kr.co.allday.bean.B_InvenRecBean;
import kr.co.allday.bean.InvenRecBean;
import kr.co.allday.mapper.InventoryMapper;

import java.sql.Date;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

@Service
public class InvenRecService {
	
	@Autowired
	private InventoryMapper inventoryMapper;
	

	public InvenRecBean processB_InvenRecBean(B_InvenRecBean bInvenRecBean) {
	    InvenRecBean invenRecBean = new InvenRecBean();

	    // orderNo와 productNo를 그대로 복사
	    invenRecBean.setOrderNo(bInvenRecBean.getOrderNo());
	    invenRecBean.setProductNo(bInvenRecBean.getProductNo());

	    // receivingdate는 현재 날짜로 설정
	    LocalDate receivingDate = LocalDate.now();
	    Date sqlReceivingDate = Date.valueOf(receivingDate); // LocalDate를 Date로 변환
	    invenRecBean.setReceivingDate(sqlReceivingDate);

	    // expirationdate 계산
	    LocalDate expirationDate = calculateExpirationDate(bInvenRecBean.getOrderNo());
	    Date sqlExpirationDate = Date.valueOf(expirationDate); // LocalDate를 Date로 변환
	    invenRecBean.setExpirationDate(sqlExpirationDate);

	    // receivedquantity는 orderQuantity를 그대로 복사
	    invenRecBean.setReceivedQuantity((int) bInvenRecBean.getOrderQuantity());

	    // retailprice 계산
	    double unitPrice = bInvenRecBean.getUnitPrice();
	    double retailPrice = unitPrice * 1.3;
	 // 100의 자리 버림
	    double truncatedRetailPrice = Math.floor(retailPrice / 100) * 100;

	    invenRecBean.setRetailPrice(truncatedRetailPrice);

	    return invenRecBean;
	}

    private LocalDate calculateExpirationDate(String orderNo) {
        char firstChar = orderNo.charAt(0);
        LocalDate receivingDate = LocalDate.now();

        // expirationdate 계산 로직
        if (firstChar == 'A') {
            receivingDate = receivingDate.plus(3, ChronoUnit.DAYS);
        } else if (firstChar == 'B') {
            receivingDate = receivingDate.plus(365, ChronoUnit.DAYS); // 1년을 365일로 계산
        } else if (firstChar == 'C' || firstChar == 'D') {
            receivingDate = receivingDate.plus(2, ChronoUnit.YEARS);
        } else if (firstChar == 'E') {
            receivingDate = receivingDate.plus(365, ChronoUnit.DAYS); // 1년을 365일로 계산
        } else if (firstChar == 'F') {
            receivingDate = receivingDate.plus(3, ChronoUnit.YEARS);
        }

        return receivingDate;
    }
    
    //현 재고 업데이트
    public void updateInventory(String storeName, InvenRecBean invenRecBean) {
        // 'inventory' 테이블에 대한 업데이트 또는 삽입
        inventoryMapper.updateOrInsertInventory(storeName, invenRecBean.getProductNo(), invenRecBean.getReceivedQuantity());
    }
    
    
    
}
