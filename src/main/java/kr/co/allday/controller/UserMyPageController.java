package kr.co.allday.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.ReservationBean;
import kr.co.allday.service.MemberService;
import kr.co.allday.service.PayService;

@Controller
@RequestMapping("/usermypage")
public class UserMyPageController {

    @Autowired
    private MemberService memberService;
    
    @Autowired
    private PayService payService;

    @Resource(name = "loginUserBean")
    private MemberBean loginUserBean;

    // 마이페이지 정보삽입
    @GetMapping("/MyPageMain")
    public String MyPageMain(@ModelAttribute("infoMemberBean") MemberBean infoMemberBean, Model model) {
        infoMemberBean = memberService.getInformation();
        model.addAttribute("infoMemberBean", infoMemberBean);

        String memberNo = loginUserBean.getMemberNo();
        
        // ReservationBean을 사용한 결제 및 예약 기록 호출
        List<ReservationBean> payAndReservationList = payService.payHistory(memberNo);

        // Model에 결과를 담아서 뷰로 전달
        model.addAttribute("payAndReservationList", payAndReservationList);

        return "usermypage/MyPageMain";
    }

    // 마이페이지 수정
    @GetMapping("/Ch_information")
    public String Ch_information(@ModelAttribute("modifyMemberBean") MemberBean modifyMemberBean) {
        memberService.getModifyInfo(modifyMemberBean);
        return "usermypage/Ch_information";
    }

    @PostMapping("/Ch_information_pro")
    public String Ch_information_pro(@Valid @ModelAttribute("modifyMemberBean") MemberBean modifyMemberBean, BindingResult result) {
        if (result.hasErrors()) {
            return "usermypage/Ch_information";
        }
        memberService.modifyUserInfo(modifyMemberBean);
        return "usermypage/modify_success";
    }

    // 회원탈퇴 메서드
    @GetMapping("/withdraw")
    public String withdraw(@ModelAttribute("modifywithdrawMemberBean") MemberBean modifywithdrawMemberBean) {
        memberService.getMemberInformation(modifywithdrawMemberBean);
        return "usermypage/withdraw";
    }

    //밑으로 수정
    @PostMapping("/withdraw_pro")
    public String withdraw_pro(@Valid @ModelAttribute("modifywithdrawMemberBean") MemberBean modifywithdrawMemberBean, BindingResult result, HttpSession session) {
        if (result.hasErrors()) {
            return "usermypage/withdraw";
        }

        memberService.withdrawMember(modifywithdrawMemberBean);

        // 세션에서 로그인 정보 삭제
        session.invalidate();

        // 리다이렉션
        return "redirect:../member/logout";
    }
}