package kr.co.allday.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import kr.co.allday.bean.MemberBean;

public class MemberValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		return MemberBean.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		MemberBean memberBean = (MemberBean)target;
		String beanName = errors.getObjectName();
		System.out.println(beanName);
		
		if(beanName.equals("registerBean")) {
			
			if (memberBean.isCheckMemberID() == false) {
				errors.rejectValue("memberID", "UnknownMemberId.registerBean.memberID"); //전체를 적어주지 않으면 로케일의 ko설정 오류 발생하므로 여기만 풀네임으로 적습니다.
			}
			 
			if(memberBean.getMemberPass().equals(memberBean.getMemberPass2()) == false) {
				errors.rejectValue("memberPass2", "NotEquals");
			}
		}
		
	}
	
}
