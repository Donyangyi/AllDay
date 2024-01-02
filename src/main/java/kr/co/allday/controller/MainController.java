package kr.co.allday.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.co.allday.bean.PayInfoBean;
import kr.co.allday.dao.PayDAO;

@Controller
public class MainController {
	
	@Autowired
	private PayDAO payDAO;

	@GetMapping("/main")
	public String main_get(Model model) {
		
		ArrayList<PayInfoBean> soldProducts = payDAO.countSoldProducts();
		model.addAttribute("soldProducts", soldProducts);
		return "main";
	}
}
