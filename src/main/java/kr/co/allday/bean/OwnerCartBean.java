package kr.co.allday.bean;

import lombok.Getter;
import lombok.Setter;

@Getter
public class OwnerCartBean {
    @Setter private String memberID; // 사용자 식별자 (예: 사용자 ID)
    @Setter private String storeName;
    @Setter private String memberName;
    @Setter private String productName;
    @Setter private String productNo;
    private int unitPrice;
    private int orderQuantity;
    private int supplyPrice;

    public OwnerCartBean() {
        this.orderQuantity = 1;
    }

    // unitPrice에 대한 커스텀 setter
    public void setUnitPrice(int unitPrice) {
        this.unitPrice = unitPrice;
        calculateSupplyPrice();
    }

    // orderQuantity에 대한 커스텀 setter
    public void setOrderQuantity(int orderQuantity) {
        this.orderQuantity = orderQuantity;
        calculateSupplyPrice();
    }

    // supplyPrice를 계산하는 내부 메서드
    private void calculateSupplyPrice() {
        this.supplyPrice = this.unitPrice * this.orderQuantity;
    }
    
    @Override
    public String toString() {
        return "OwnerCartBean{" +
               "memberID='" + getMemberID() + '\'' +
               ", storeName='" + getStoreName() + '\'' +
               ", memberName='" + getMemberName() + '\'' +
               ", productName='" + getProductName() + '\'' +
               ", productNo='" + getProductNo() + '\'' +
               ", unitPrice=" + getUnitPrice() +
               ", orderQuantity=" + getOrderQuantity() +
               ", supplyPrice=" + getSupplyPrice() +
               '}';
    }
}
