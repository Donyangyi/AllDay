package kr.co.allday.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.mapper.FindMemberMapper;

@Repository
public class FindMemberDAO {
	
	@Autowired
	FindMemberMapper findMemberMapper;
	
	public String findMemberId(MemberBean findMemberIDBean) {
		
		return findMemberMapper.findMemberId(findMemberIDBean);
	}
	
	public String findMemberPw(MemberBean findMemberPWBean) {
		
		return findMemberMapper.findMemberPw(findMemberPWBean);
	}

}
