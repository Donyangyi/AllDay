package kr.co.allday.service;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.dao.MemberDAO;

@Service
public class MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;

	public void registerMember(MemberBean registerBean) {
		memberDAO.registerMember(registerBean);
	}
	
	public boolean checkMemberID(String MemberID) {
		String checkID = memberDAO.checkMemberID(MemberID);
		if(checkID != null) {
			return false;
		}else {
			return true;
		}
		
	}
	
	public void getMemberInfo(MemberBean tempLoginMemberBean) {
		MemberBean tempLoginMemberBean2 = memberDAO.getMemberInfo(tempLoginMemberBean);
		if(tempLoginMemberBean2 != null) {
	        // 조회된 정보를 세션에 저장할 loginUserBean 객체에 복사
	        BeanUtils.copyProperties(tempLoginMemberBean2, loginUserBean);
	        loginUserBean.setMemberLogin(true);
	    }
	}
	
	// 12-06
	   // 지성 수정내역
	   public void getModifyInfo(MemberBean modifyMemberBean) {
	      MemberBean tempModifyMemberBean = memberDAO.getModifyUserInfo(loginUserBean.getMemberNo());

	      modifyMemberBean.setMemberNo(tempModifyMemberBean.getMemberNo());
	      modifyMemberBean.setMemberID(tempModifyMemberBean.getMemberID());
	      modifyMemberBean.setMemberName(tempModifyMemberBean.getMemberName());
	      modifyMemberBean.setAddress(tempModifyMemberBean.getAddress());
	      modifyMemberBean.setNickName(tempModifyMemberBean.getNickName());
	   }

	   public void modifyUserInfo(MemberBean modifyUserBean) {
	      modifyUserBean.setMemberNo(loginUserBean.getMemberNo());
	      memberDAO.modifyUserInfo(modifyUserBean);
	   }

	   
	   //여기 밑으로 추가함 12-09
	   public void getMemberInformation(MemberBean modifywithdrawMemberBean) {
	      MemberBean tempInformationBean = memberDAO.getMemberInformation(loginUserBean.getMemberNo());
	      
	      modifywithdrawMemberBean.setMemberNo(tempInformationBean.getMemberNo());
	      modifywithdrawMemberBean.setMemberID(tempInformationBean.getMemberID());
	      modifywithdrawMemberBean.setMemberName(tempInformationBean.getMemberName());
	      modifywithdrawMemberBean.setNickName(tempInformationBean.getNickName());
	      modifywithdrawMemberBean.setAddress(tempInformationBean.getAddress());
	   }
	   
	   public void withdrawMember(MemberBean withdrawMemberBean) {
	      withdrawMemberBean.setMemberNo(loginUserBean.getMemberNo());
	      memberDAO.withdrawMember(withdrawMemberBean);
	   }
	   
	   public MemberBean getInformation() {
	      return memberDAO.getInformation(loginUserBean.getMemberNo());
	   }

}
