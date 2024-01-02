package kr.co.allday.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.PostBean;
import kr.co.allday.service.BoardService;

public class CheckWriterInterceptor implements HandlerInterceptor{

	private MemberBean loginUserBean;
	private BoardService boardService;
	
	public CheckWriterInterceptor(MemberBean loginUserBean, BoardService boardService) {
		this.loginUserBean = loginUserBean;
		this.boardService = boardService;
	}

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		String str1 = request.getParameter("postNo");
		int postNo = Integer.parseInt(str1);
		
		//현재 게시글의 정보 가져오기
		PostBean currentPostBean = boardService.getPostInfo(postNo);
		System.out.println(currentPostBean.getMemberNo());
		System.out.println(loginUserBean.getMemberNo());
		if(!currentPostBean.getMemberNo().equals(loginUserBean.getMemberNo())) {
			String contentPath = request.getContextPath();
			response.sendRedirect(contentPath+"/board/not_writer");
			return false;
		}
		
		return true;
	}
	
	
	
	
}
