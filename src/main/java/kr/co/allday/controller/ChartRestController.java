package kr.co.allday.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.bean.StackGraphBean;
import kr.co.allday.service.GraphService;

@RestController
public class ChartRestController {

	@Autowired
    private GraphService graphService;

    @GetMapping("/chartData/{storeName}")
    public List<StackGraphBean> getChartData(@PathVariable String storeName) {
        return graphService.getProcessedData(storeName);
    }
	
}
