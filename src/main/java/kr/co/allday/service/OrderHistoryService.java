package kr.co.allday.service;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.OrderHistoryBean;
import kr.co.allday.dao.OrderHistoryDAO;

@Service
public class OrderHistoryService {
    
    @Autowired
    private OrderHistoryDAO orderHistoryDAO;
    
    public List<OrderHistoryBean> getOrderHistoryList(String storename) { //5. storename 넣고
        System.out.println("Service - storename: " + storename);

        List<OrderHistoryBean> list = orderHistoryDAO.getOrderHistoryList(storename);

        System.out.println("Service - list: " + list);

        return list;
    }
}
