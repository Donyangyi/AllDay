package kr.co.allday.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.allday.bean.ReservationBean;
import kr.co.allday.service.PayService;

@Controller
@RequestMapping("/pay")
public class PayController {

	@Autowired
    private PayService payService;
	
	@GetMapping("/pay_main")
	public String pay_main() {
		return "/pay/pay_main";
	}

    // /pay/payHistory?memberNo={memberNo} 에 대응
	@GetMapping("/payHistory")
	public String payHistory(@RequestParam("memberNo") String memberNo, Model model) {
	    // PayService를 통해 결제 내역을 조회
	    List<ReservationBean> reservationList = payService.payHistory(memberNo);

	    // 조회 결과를 모델에 담아 뷰로 전달
	    model.addAttribute("reservationList", reservationList);

	    // 해당 뷰의 이름을 반환 (뷰의 이름은 ViewResolver에 의해 실제 뷰로 변환됨)
	    return "payHistoryView";
	}

}