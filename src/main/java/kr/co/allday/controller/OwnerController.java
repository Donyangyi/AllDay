package kr.co.allday.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.allday.bean.PayBean;
import kr.co.allday.service.PayService;
import kr.co.allday.service.SearchService;

@Controller
@RequestMapping("/owner")
public class OwnerController {

    @Autowired
    private PayService payService;
    
    @Autowired
    private SearchService searchService;


    @GetMapping("/owner_main")
    public String owner_main() {
        return "owner/owner_main";
    }

    @GetMapping("/owner_history")
    public String owner_history() {
        return "owner/owner_history";
    }
    
    
    @GetMapping("/owner_graph")
    public String ownerSales(Model model) {
        List<PayBean> data = payService.getPayList();
        model.addAttribute("NameAndSalse", data);
        return "owner/owner_graph";
    }

    @GetMapping("/owner_search")
    public String owner_search() {
        return "owner/owner_search";
    }
}
