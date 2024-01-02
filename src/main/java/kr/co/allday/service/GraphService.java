package kr.co.allday.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.GraphBean;
import kr.co.allday.bean.StackGraphBean;
import kr.co.allday.dao.GraphDAO;

@Service
public class GraphService {
	
	@Autowired
    private GraphDAO graphDAO;

	public List<StackGraphBean> getProcessedData(String storeName) {
	    List<GraphBean> rawData = graphDAO.getMonthData(storeName);

	    // 상품별로 데이터 그룹화
	    Map<String, Map<String, Integer>> groupedData = rawData.stream()
	        .collect(Collectors.groupingBy(GraphBean::getProductName,
	                Collectors.groupingBy(GraphBean::getSale_month,
	                        Collectors.summingInt(GraphBean::getMax_quantity_sold))));

	    // StackGraphBean 형태로 변환
	    List<StackGraphBean> result = new ArrayList<>();
	    for (String productName : groupedData.keySet()) {
	        StackGraphBean bean = new StackGraphBean();
	        bean.setLabel(productName);
	        List<Integer> monthlySales = new ArrayList<>();

	        // 1월부터 12월까지의 데이터를 처리합니다.
	        for (int month = 1; month <= 12; month++) {
	            String monthKey = String.format("%02d", month); // "01", "02", ... "12"
	            monthlySales.add(groupedData.get(productName).getOrDefault(monthKey, 0));
	        }

	        bean.setValues(monthlySales);
	        result.add(bean);
	    }

	    return result;
	}
	
}
