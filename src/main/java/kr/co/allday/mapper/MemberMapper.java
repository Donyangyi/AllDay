package kr.co.allday.mapper;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;

import kr.co.allday.bean.MemberBean;

public interface MemberMapper {
	
	@SelectKey(statement = "select 'ME'||lpad(number_inc.nextval, 5, 0) from dual", keyProperty = "memberNo", before = true, resultType = String.class)
	
	@Insert("insert into memberInfo(memberNo, memberID, memberPass, dob, memberName, address, "
			+ "gender, email, phoneNo, nickName, points, memberRole, storeName) "
			+ "values(#{memberNo}, #{memberID}, #{memberPass}, #{dob}, #{memberName}, #{address}, "
			+ "#{gender}, #{email}, #{phoneNo}, #{nickName}, #{points}, #{memberRole}, #{storeName, jdbcType=VARCHAR})")
    public void registerMember(MemberBean registerBean);
    
	@Select("select memberName from memberInfo where memberID = #{memberID}")
	public String checkMemberID(String MemberID);
	
	@Select("select * from memberInfo where memberID = #{memberID} and memberPass = #{memberPass}")
	public MemberBean getMemberInfo(MemberBean tempLoginMemberBean);
	
	

	   //12-06 기능 추가
	   //마이페이지 수정 기능 추가
	   @Select("select memberno, memberid, memberpass, dob, membername, address, gender, email, phoneno, nickname, points, memberrole "
	         + "from memberinfo " + "where memberNo = #{memberNo}")
	   MemberBean getModifyUserInfo(String memberNo);

	   @Update("update memberinfo set memberPass=#{memberPass}, address=#{address}, nickName=#{nickName} "
	   		+ "where memberNo=#{memberNo}")
	   void modifyUserInfo(MemberBean modifyMemberbean);
	   
	    // 회원 탈퇴 기능 추가
	   
	   @Select("select memberno, memberid, memberpass, dob, membername, address, gender, email, phoneno, nickname, points, memberrole "
	               + "from memberinfo " + "where memberNo = #{memberNo}")
	       MemberBean getMemberInformation(String memberNo);
	   
	   @Delete("DELETE FROM memberinfo WHERE memberNo = #{memberNo}")
	   void withdrawMember(String memberNo);

	   
	   //회원정보 출력 기능 추가 여기도() 
	   @Select("select memberno, memberid, memberpass, dob, membername, address, gender, email, phoneno, nickname, points, memberrole "
	         + "from memberinfo " + "where memberNo = #{memberNo}")
	   MemberBean getInformation(String memberNo);	
	
}
