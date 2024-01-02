package kr.co.allday.config;

import java.util.ArrayList;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.context.annotation.ApplicationScope;
import org.springframework.web.context.annotation.SessionScope;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.OwnerCartBean;

//프로젝트 작업시 사용할 bean을 정의하는 클래스
@EnableScheduling // 스케줄링 활성화
@Configuration
public class RootAppContext {
	
	@Bean("loginUserBean")
	@SessionScope 
	public MemberBean loginUserBean() {
		return new MemberBean();
	}
	
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}
	
	@Bean("loginCart")//loginCart로 이름바꾸기 한거다.
	@SessionScope
	public ArrayList<CartBean> loginCart() {
		return new ArrayList<CartBean>();
	}
	
	@Bean("OwnerCart")
	@ApplicationScope
	public ArrayList<OwnerCartBean> OwnerCart() {
		return new ArrayList<OwnerCartBean>();
	}
}
