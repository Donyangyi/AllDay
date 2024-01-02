package kr.co.allday.config;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.mapper.MapperFactoryBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.interceptor.CheckLoginInterceptor;
import kr.co.allday.interceptor.CheckStoreInterceptor;
import kr.co.allday.interceptor.CheckWriterInterceptor;
import kr.co.allday.interceptor.InterceptorMainTop;
import kr.co.allday.mapper.BoardMapper;
import kr.co.allday.mapper.FindMemberMapper;
import kr.co.allday.mapper.GraphMapper;
import kr.co.allday.mapper.InvenRecMapper;
import kr.co.allday.mapper.InventoryMapper;
import kr.co.allday.mapper.MemberMapper;
import kr.co.allday.mapper.OrderDetailsMapper;
import kr.co.allday.mapper.OrderHistoryMapper;
import kr.co.allday.mapper.OwnerMainMapper;
import kr.co.allday.mapper.OwnerMapper;
import kr.co.allday.mapper.PayMapper;
import kr.co.allday.mapper.ProductMapper;
import kr.co.allday.mapper.SearchMapper;
import kr.co.allday.service.BoardService;

@Configuration
@EnableWebMvc // controller
@ComponentScan("kr.co.allday.controller")
@ComponentScan("kr.co.allday.service")
@ComponentScan("kr.co.allday.dao")
@PropertySource("/WEB-INF/properties/db.properties")
@PropertySource("/WEB-INF/properties/option.properties")
@PropertySource("/WEB-INF/properties/application.properties")

public class ServletAppContext implements WebMvcConfigurer {

	@Value("${db.classname}")
	private String db_classname;

	@Value("${db.url}")
	private String db_url;

	@Value("${db.username}")
	private String db_username;

	@Value("${db.password}")
	private String db_password;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Autowired
	private BoardService boardService;

	@Override
	public void configureViewResolvers(ViewResolverRegistry registry) {
		// view로 보내질 최종 요청응답에 관한 환경설정
		WebMvcConfigurer.super.configureViewResolvers(registry);
		registry.jsp("/WEB-INF/views/", ".jsp");
	}

	// 정적 파일의 경로를 매핑
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		// TODO Auto-generated method stub
		WebMvcConfigurer.super.addResourceHandlers(registry);
		registry.addResourceHandler("/**").addResourceLocations("/resources/");
	}
	
	@Bean
	   public static PropertySourcesPlaceholderConfigurer PropertySourcesPlaceholderConfigurer() {
	      return new PropertySourcesPlaceholderConfigurer();
	   }
	
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		WebMvcConfigurer.super.addInterceptors(registry);
		
		InterceptorMainTop interceptorMainTop = new InterceptorMainTop(loginUserBean);
		
		InterceptorRegistration reg1 = registry.addInterceptor(interceptorMainTop);
		reg1.addPathPatterns("/**");
		
		CheckLoginInterceptor checkLoginInterceptor = new CheckLoginInterceptor(loginUserBean);
		
		InterceptorRegistration reg2 = registry.addInterceptor(checkLoginInterceptor);
		reg2.addPathPatterns("/mypage/*" , "/customer_order/customer_order", "/owner/*", "/product/product_detail", "/cart/cart_board", "/board/write");
		
		CheckWriterInterceptor checkWriterInterceptor = new CheckWriterInterceptor(loginUserBean, boardService);
		
		InterceptorRegistration reg3 = registry.addInterceptor(checkWriterInterceptor);
		reg3.addPathPatterns("/board/modify","/board/delete");
		
		CheckStoreInterceptor checkStoreInterceptor = new CheckStoreInterceptor(loginUserBean);
		
		InterceptorRegistration reg4 = registry.addInterceptor(checkStoreInterceptor);
		reg4.addPathPatterns("/board/write");
	}

	@Bean
	public ReloadableResourceBundleMessageSource messageSource() {
		ReloadableResourceBundleMessageSource res = new ReloadableResourceBundleMessageSource();
		res.setBasenames("/WEB-INF/properties/error_message");
		res.setDefaultEncoding("UTF-8");
		return res;
	}

	@Bean
	public BasicDataSource dataSource() {
		BasicDataSource source = new BasicDataSource();
		source.setDriverClassName(db_classname);
		source.setUrl(db_url);
		source.setUsername(db_username);
		source.setPassword(db_password);

		return source;
	}

	// 쿼리문과 접속 정보를 관리하는 객체
	@Bean
	public SqlSessionFactory factory(BasicDataSource source) throws Exception {
		SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
		factoryBean.setDataSource(source);
		SqlSessionFactory factory = factoryBean.getObject();
		return factory;
	}
	
	//mapper 관리
	@Bean
	public MapperFactoryBean<MemberMapper> getMemberMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<MemberMapper> factoryBean = new MapperFactoryBean<MemberMapper>(MemberMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}
	
	@Bean
	   public MapperFactoryBean<PayMapper> getPayMapper(SqlSessionFactory factory) throws Exception {
	      MapperFactoryBean<PayMapper> factoryBean = new MapperFactoryBean<PayMapper>(PayMapper.class);
	      factoryBean.setSqlSessionFactory(factory);
	      return factoryBean;
	   }
	
	@Bean
	   public MapperFactoryBean<FindMemberMapper> getFindMemberMapper(SqlSessionFactory factory) throws Exception {
	      MapperFactoryBean<FindMemberMapper> factoryBean = new MapperFactoryBean<FindMemberMapper>(FindMemberMapper.class);
	      factoryBean.setSqlSessionFactory(factory);
	      return factoryBean;
	   }
	
	@Bean
	   public MapperFactoryBean<ProductMapper> getProductMapper(SqlSessionFactory factory) throws Exception {
	      MapperFactoryBean<ProductMapper> factoryBean = new MapperFactoryBean<ProductMapper>(ProductMapper.class);
	      factoryBean.setSqlSessionFactory(factory);
	      return factoryBean;
	   }
	
	@Bean
	   public MapperFactoryBean<BoardMapper> getBoardMapper(SqlSessionFactory factory) throws Exception {
	      MapperFactoryBean<BoardMapper> factoryBean = new MapperFactoryBean<BoardMapper>(BoardMapper.class);
	      factoryBean.setSqlSessionFactory(factory);
	      return factoryBean;
	   }
	
	@Bean
	   public MapperFactoryBean<OrderHistoryMapper> getOrderHistoryMapper(SqlSessionFactory factory) throws Exception {
	      MapperFactoryBean<OrderHistoryMapper> factoryBean = new MapperFactoryBean<OrderHistoryMapper>(OrderHistoryMapper.class);
	      factoryBean.setSqlSessionFactory(factory);
	      return factoryBean;
	   }
	
	@Bean
	public StandardServletMultipartResolver multipartResolver() {
		return new StandardServletMultipartResolver(); //객체 생성하여 반환
	}
	
	@Bean
	public MapperFactoryBean<SearchMapper> getSearchMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<SearchMapper> factoryBean = new MapperFactoryBean<SearchMapper>(SearchMapper.class);
		factoryBean.setSqlSessionFactory(factory);
		return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<OwnerMapper> getOwnerMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<OwnerMapper> factoryBean = new MapperFactoryBean<OwnerMapper>(OwnerMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<GraphMapper> getGraphMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<GraphMapper> factoryBean = new MapperFactoryBean<GraphMapper>(GraphMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}
	
	
	@Bean
	public MapperFactoryBean<OwnerMainMapper> getOwnerMainMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<OwnerMainMapper> factoryBean = new MapperFactoryBean<OwnerMainMapper>(OwnerMainMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<OrderDetailsMapper> getOrderDetailsMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<OrderDetailsMapper> factoryBean = new MapperFactoryBean<OrderDetailsMapper>(OrderDetailsMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<InvenRecMapper> getInvenRecMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<InvenRecMapper> factoryBean = new MapperFactoryBean<InvenRecMapper>(InvenRecMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}
	
	@Bean
	public MapperFactoryBean<InventoryMapper> getInventoryMapper(SqlSessionFactory factory) throws Exception {
		MapperFactoryBean<InventoryMapper> factoryBean = new MapperFactoryBean<InventoryMapper>(InventoryMapper.class);
	    factoryBean.setSqlSessionFactory(factory);
	    return factoryBean;
	}

}
