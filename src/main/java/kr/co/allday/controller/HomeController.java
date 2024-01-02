package kr.co.allday.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.co.allday.bean.MemberBean;

@Controller
public class HomeController {
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home() {
		
		return "redirect:/main";
	}

}
