package kr.co.allday.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.allday.bean.MemberBean;

public class InterceptorMainTop implements HandlerInterceptor{
	
	private MemberBean loginUserBean;
	
	public InterceptorMainTop(MemberBean loginUserBean) {
		this.loginUserBean = loginUserBean;
	}



	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		request.setAttribute("loginUserBean", loginUserBean);
		//System.out.println("test : " + loginUserBean);
		return true;
	}
	
	

}
