package kr.co.allday.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.mapper.MemberMapper;

@Repository
public class MemberDAO {

	@Autowired
	private MemberMapper memberMapper;
	
	public void registerMember(MemberBean registerBean) {
		memberMapper.registerMember(registerBean);
	}
	
	public String checkMemberID(String MemberID) {
		return memberMapper.checkMemberID(MemberID);
	}
	
	public MemberBean getMemberInfo(MemberBean tempLoginMemberBean) {
		return memberMapper.getMemberInfo(tempLoginMemberBean);
	}
	
	//밑에 퍼블릭 두개 추가 
	public MemberBean getModifyUserInfo(String memberNo) {
		return memberMapper.getModifyUserInfo(memberNo);
	}

	public void modifyUserInfo(MemberBean modifyMemberBean) {
		memberMapper.modifyUserInfo(modifyMemberBean);

	}
	
	// 회원 탈퇴 기능

	   public MemberBean getMemberInformation(String memberNo) {
	      return memberMapper.getMemberInformation(memberNo);
	   }

	   public void withdrawMember(MemberBean modifywithdrawMemberBean) {
	       memberMapper.withdrawMember(modifywithdrawMemberBean.getMemberNo());
	   }


	   //정보 삽입
	   public MemberBean getInformation(String memberNo) {
	      return memberMapper.getInformation(memberNo);
	   }
}
