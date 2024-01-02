package kr.co.allday.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.OrderDetailsBean;
import kr.co.allday.bean.OrderMainBean;
import kr.co.allday.bean.OwnerCartBean;
import kr.co.allday.mapper.OrderDetailsMapper;
import kr.co.allday.mapper.OwnerMainMapper;

@Service
public class OwnerCartService {

    @Autowired
    private OwnerMainMapper ownerMainMapper;
    
    @Autowired
    private OrderDetailsMapper orderDetailsMapper;
    

    public void createOrder(OrderMainBean orderMain) {
        ownerMainMapper.insertOrderMain(orderMain);
    }
    
    
 


    
}
