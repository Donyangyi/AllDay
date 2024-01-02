package kr.co.allday.mapper;

import org.apache.ibatis.annotations.Select;

import kr.co.allday.bean.MemberBean;

public interface FindMemberMapper {
	
	@Select("select memberid from memberinfo where membername=#{memberName} and email=#{email}")
	public String findMemberId(MemberBean findMemberIDBean);
	
	
	@Select("select memberpass from memberinfo where memberid=#{memberID} and membername=#{memberName}")
	public String findMemberPw(MemberBean findMemberPWBean);

}

