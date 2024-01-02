package kr.co.allday.controller;

import java.util.ArrayList;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.service.MemberService;
import kr.co.allday.validator.MemberValidator;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Resource(name = "loginCart")
	private ArrayList<CartBean> loginCart;
	
	//===========================================================================================================
	//로그인
	@GetMapping("/login_main")
	public String login_main(@ModelAttribute("tempLoginMemberBean") MemberBean tempLoginMemberBean,
							 @RequestParam(value="fail", defaultValue = "false") boolean fail, Model model) {
		model.addAttribute("fail",fail);
		return "member/login_main";
	}
	
	@PostMapping("/login_pro")
	public String login_pro(@Valid @ModelAttribute("tempLoginMemberBean") MemberBean tempLoginMemberBean, BindingResult result) {
		if(result.hasErrors()) {
			return "member/login_main";
		}
		
		memberService.getMemberInfo(tempLoginMemberBean);
		
		if(loginUserBean.isMemberLogin()==true){
			if(loginUserBean.getStoreName() != null) {
				return "member/login_owner_success";
			}
			return "member/login_success";
		}
		
		else {
			return "member/login_fail";
		}
	}

	
	//=============================================================================================================
	//회원가입
	@GetMapping("register_main")
	public String register_main(@ModelAttribute("registerBean") MemberBean registerBean) {
		return "member/register_main";
	}
	
	@PostMapping("register_pro")
	public String name(@Valid @ModelAttribute("registerBean") MemberBean registerBean, BindingResult result) {
		if(result.hasErrors()) {
			return "member/register_main";
		}
		memberService.registerMember(registerBean);
		return "member/register_success";
	}	
	
	//==============================================================================================================
	//로그아웃
	
	@GetMapping("logout")
	public String logout(HttpSession session) {
		loginUserBean.setMemberLogin(false);
		
		//로그아웃했을때 장바구니에 담긴 내용 날리기(ArrayList 타입의 loginCart를 세션에서 제거)
		session.removeAttribute("loginCart");
		
		session.invalidate();
		
		return "member/logout";
	}
	
	//==============================================================================================================
	//로그인 여부 확인
	@GetMapping("/not_login")
	public String not_login() {
		return "member/not_login";
	}
	
	//==============================================================================================================
	//오류 발생에 대한 추가 로직
	@InitBinder
	   public void initBinder(WebDataBinder binder) {
	     MemberValidator validator1 = new MemberValidator();
	      binder.addValidators(validator1);
	   }
	
}