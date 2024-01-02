package kr.co.allday.dao;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.OrderHistoryBean;
import kr.co.allday.mapper.OrderHistoryMapper;

@Repository
public class OrderHistoryDAO {
    
    @Autowired
    private OrderHistoryMapper orderHistoryMapper;
    
    public List<OrderHistoryBean> getOrderHistoryList(String storename) { //6. storename 넣고 \
        System.out.println("DAO - storename: " + storename);

        List<OrderHistoryBean> list = orderHistoryMapper.selectHistory(storename);

        if (list == null) {
            System.out.println("DAO - list 널이다.");
        } else if (list.isEmpty()) {
            System.out.println("DAO - list는 비어있다.");
        } else {
            System.out.println("DAO - list에 데이터가 있다.");
        }

        
        System.out.println(list);
        return list;
    }
}
