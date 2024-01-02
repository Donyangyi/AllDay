package kr.co.allday.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.PayBean;
import kr.co.allday.bean.ReservationBean;
import kr.co.allday.dao.PayDAO;
import kr.co.allday.mapper.PayMapper;

@Service
public class PayService {

	@Autowired
    private PayMapper payMapper;
	
	@Autowired
	private PayDAO payDAO;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Autowired
	private RestTemplate restTemplate;
	
	public ArrayList<PayBean> getPayList() {
		
		ArrayList<PayBean> payList = (ArrayList<PayBean>) payDAO.getPayList();
		System.out.println("Service:"+payList);
		return payList;
	}
	
	public void addPayment(int total) {
		PayBean payedBean = new PayBean();
		payedBean.setMemberNo(loginUserBean.getMemberNo());
		payedBean.setStoreName(loginUserBean.getCheckStore());
		payedBean.setPaymentAmount(total);
		
		payDAO.addPayment(payedBean);
    }
	
	 // 아임포트 토큰을 가져오는 메서드
    private String getAccessToken() {
        // API 키와 비밀키를 사용하여 토큰을 요청하는 로직
        // 이 값들은 환경 변수나 설정 파일에서 가져오는 것이 좋습니다.
        String apiKey = "1233615552645758";
        String apiSecret = "ewrRDW5y0qqO7Vc9CQD8XPLNAVibxy3DsBeBpPjVyYp1JxqkJsmS63tZFXo6acllKNPjkV2x4XQNh4Ir";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        JSONObject requestData = new JSONObject();
        requestData.put("imp_key", apiKey);
        requestData.put("imp_secret", apiSecret);

        HttpEntity<String> request = new HttpEntity<>(requestData.toString(), headers);

        String response = restTemplate.postForObject("https://api.iamport.kr/users/getToken", request, String.class);
        JSONObject jsonResponse = new JSONObject(response);
        return jsonResponse.getJSONObject("response").getString("access_token");
    }
    
 // 결제 검증 메서드
    public boolean verifyPayment(String imp_uid) {
        try {
            String accessToken = getAccessToken();
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(accessToken);

            HttpEntity<?> request = new HttpEntity<>(headers);

            String paymentVerificationUrl = "https://api.iamport.kr/payments/" + imp_uid;

            String response = restTemplate.postForObject(paymentVerificationUrl, request, String.class);
            JSONObject jsonResponse = new JSONObject(response);

            // 여기서 jsonResponse를 분석하여 결제가 성공적인지 확인합니다.
            JSONObject responseObj = jsonResponse.getJSONObject("response");
            String status = responseObj.getString("status");
            
            System.out.println("반환 값이 먼대 : "+ responseObj);
            System.out.println("상태 : "+ status);
            return "paid".equals(status);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	/* 12-18 추가 */
    public List<ReservationBean> payHistory(String memberNo) {
    	return payMapper.payHistory(memberNo);
    }
    
}
