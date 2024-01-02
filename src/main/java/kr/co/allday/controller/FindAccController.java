package kr.co.allday.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.dao.FindMemberDAO;


@Controller
@RequestMapping("/find_acc")
public class FindAccController {
	
	@Autowired
	FindMemberDAO findMemberDAO;
	
	
	@GetMapping("/find_id")
	public String find_id(@ModelAttribute("findMemberIDBean") MemberBean findMemberIDBean) {
	
		return "find_acc/find_id";
	}
	
	@PostMapping("/find_id_pro")
	public String find_id_pro(@ModelAttribute("findMemberIDBean") MemberBean findMemberIDBean) {
		
		String checkedId = findMemberDAO.findMemberId(findMemberIDBean);
		
		findMemberIDBean.setMemberID(checkedId);//저장하는곳
			
		return "find_acc/find_id_success";
	}
	
	@GetMapping("/find_pw")
	public String find_pw(@ModelAttribute("findMemberPWBean") MemberBean findMemberPWBean) {
		
		return "find_acc/find_pw";
	}
	
	@PostMapping("/find_pw_pro")
	public String find_pw_pro(@ModelAttribute("findMemberPWBean") MemberBean findMemberPWBean) {
		
		String checkedPw = findMemberDAO.findMemberPw(findMemberPWBean);
		
		findMemberPWBean.setMemberPass(checkedPw);
		
		return "find_acc/find_pw_success";
	}
	

}
