package kr.co.allday.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import kr.co.allday.bean.MemberBean;

public class CheckStoreInterceptor implements HandlerInterceptor {

    private MemberBean loginUserBean;
    
    public CheckStoreInterceptor(MemberBean loginUserBean) {
        this.loginUserBean = loginUserBean;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        // URL에서 boardNo 파라미터 값을 가져옴
        String boardNo = request.getParameter("boardNo");

        // 로그인을 하지 않았거나 boardNo가 "1" 또는 "2"인 경우
        if (loginUserBean.getStoreName() == null && ("1".equals(boardNo) || "2".equals(boardNo))) {
            // 리다이렉트할 경로 지정
            String contextPath = request.getContextPath();
            response.sendRedirect(contextPath + "/board/not_writer");
            return false;
        }
        return true;
    }
}
