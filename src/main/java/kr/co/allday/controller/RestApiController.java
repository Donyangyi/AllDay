package kr.co.allday.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.bean.CartBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.PayInfoBean;
import kr.co.allday.bean.ReservationBean;
import kr.co.allday.dao.BoardDAO;
import kr.co.allday.dao.MemberDAO;
import kr.co.allday.dao.PayDAO;
import kr.co.allday.service.MemberService;
import kr.co.allday.service.PayService;
import kr.co.allday.service.ProductService;

@RestController
public class RestApiController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MemberDAO memberDAO;
	
	@Autowired
	private PayService payService;
	
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired
	private PayDAO payDAO;
	
	@Autowired
	private ProductService productService;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Resource(name = "loginCart")
	private ArrayList<CartBean> loginCart;
	
	
	@GetMapping("/member/checkMemberID/{MemberID}")
	public String checkMemberID(@PathVariable String MemberID) {
								/* @RequestParam("member_id") String member_id */
		
		boolean chk = memberService.checkMemberID(MemberID);
		
		return chk+"";
		
	}
	
	//결제 API 부분 ========================================================================
	
	//결제번호 생성
	@PostMapping("/payments/addMerchant_uid/{total}")
	public void addPayment(@PathVariable int total) {
		payService.addPayment(total);
	}
	
	//결제번호 반환
	@GetMapping("/payments/getMerchant_uid")
	public String getNewPaymentNo() {
		return payDAO.getNewPaymentNo();
	}
	//결제 검증
	@PostMapping("/payments/verify")
	public ResponseEntity<?> verifyPayment(@RequestParam String imp_uid) {
	    try {
	        boolean isVerified = payService.verifyPayment(imp_uid);
	        System.out.println("is머시기 : " + isVerified);
	        if(isVerified) {
	        	System.out.println("검증 성공");
	            return ResponseEntity.ok(Map.of("success", true, "message", "결제가 성공적으로 검증되었습니다."));
	        } else {
	        	System.out.println("검증 실패");
	            return ResponseEntity.ok(Map.of("success", false, "message", "결제 검증 실패"));
	        }
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                             .body(Map.of("success", false, "message", "서버 오류 발생"));
	    }
	}
	
	//결제 실패 시 결제 번호 삭제
	@DeleteMapping("payment/deletePaymentNo/{merchant_uid}")
	public void deletePaymentNo(@PathVariable("merchant_uid") String paymentNo) {
		payDAO.deletePaymentNo(paymentNo);
	}
	
	//===========================================2023-12-09 추가된 부분==========================================================
		//결제 후 결제 내역 생성
		@PostMapping("/payments/addPaymentInfo/{merchant_uid}")
	    public ResponseEntity<?> addPaymentInfo(@RequestBody List<CartBean> cartBeans,
	    										@PathVariable("merchant_uid") String paymentNo) {
			
			PayInfoBean payInfoBean = new PayInfoBean();
	        for (CartBean cartBean : cartBeans) {
	            
	            payInfoBean.setMemberNo(loginUserBean.getMemberNo());
	            payInfoBean.setStoreName(loginUserBean.getCheckStore());
	            payInfoBean.setPaymentQuantity(cartBean.getAmount());
	            payInfoBean.setPaymentNo(paymentNo);
	            payInfoBean.setProductName(cartBean.getProductName());
	            
	            payDAO.addPaymentInfo(payInfoBean);
	        }
	        
	        //결제 되었으니 장바구니 비우기
	        loginCart.clear();
	        System.out.println(loginCart);

	        // 처리 결과에 따라 적절한 응답 반환
	        return ResponseEntity.ok().body("결제내역 생성 완료");
	    }
		
		//결제 후 재고 수량 업데이트
		@PutMapping("payments/updateQuentity")
		public ResponseEntity<?> updateQuentity(@RequestBody List<CartBean> cartBeans) {
			
			PayInfoBean payInfoBean = new PayInfoBean();
			
	        for (CartBean cartBean : cartBeans) {
	            payInfoBean.setStoreName(loginUserBean.getCheckStore());
	            payInfoBean.setPaymentQuantity(cartBean.getAmount());
	            payInfoBean.setProductName(cartBean.getProductName());
	            
	            System.out.println("수량 업데이트용 점포명 : " + loginUserBean.getCheckStore());
	            System.out.println("수량 업데이트용 수량 : " + cartBean.getAmount());
	            System.out.println("수량 업데이트용 상품이름: " + cartBean.getProductName());
	            payDAO.updateQuantity(payInfoBean);
	        }
	        
	        return ResponseEntity.ok().body("업데이트 성공");
		}
		
	
		@PostMapping("payments/addReservationInfo/{merchant_uid}/{dateTime}")
		public ResponseEntity<?> addReservationInfo(@RequestBody List<CartBean> cartBeans, //reservedQuantity의 수량을 측정하기 위해 가져옴
									   @PathVariable("merchant_uid") String paymentNo,
									   @PathVariable("dateTime") String pickupDate) {
			ReservationBean reservation = new ReservationBean();
			int reservedQuantity = 0;
			
			for(CartBean cartBean : cartBeans) {
				reservedQuantity += cartBean.getAmount();
			}
			
			System.out.println("예약정보 갯수: " + reservedQuantity);
			System.out.println("예약정보 거래번호: " + paymentNo);
			System.out.println("예약정보 수령일자: " + pickupDate);
			System.out.println("예약정보 회원번호: " + loginUserBean.getMemberNo());
			
			
			reservation.setReservedQuantity(reservedQuantity);
			reservation.setPaymentNo(paymentNo);
			reservation.setPickupDate(pickupDate);
			reservation.setMemberNo(loginUserBean.getMemberNo());
			
			payDAO.addReservationInfo(reservation);
			
			return ResponseEntity.ok().body("예약 정보 생성 완료");
		}
		
	//댓글 삭제 부분 ========================================================================
	
		@DeleteMapping("/board/deleteComment")
		public ResponseEntity<?> delete(@RequestParam("commentNo") int commentNo,
						     			@RequestParam("memberNo") String memberNo, Model model) {
			
			/*
			System.out.println("로그인한 회원의 번호 : "+loginUserBean.getMemberNo());
			System.out.println("실제로 삭제하려는 댓글 작성자의 번호 : " + memberNo);
			*/
			
			if(loginUserBean.getMemberNo().equals(memberNo)) {
				try {
					boardDAO.deleteComment(commentNo, memberNo);
		            return ResponseEntity.ok().build();
		        } catch (Exception e) {
		            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
		        }
			}
			
			return ResponseEntity.status(HttpStatus.FORBIDDEN).build(); // 권한 없음 응답

		}
		
		/*
		//장바구니 아이템 삭제
		@DeleteMapping("/cartDeletePro/{CIN}")
		public void cartDeletePro(@PathVariable int CIN) {
			
			loginCart.remove(CIN);
		}
		*/
		//장바구니 아이템 삭제(12.15수정)
	      @DeleteMapping("/cartDeletePro")
	      public ResponseEntity<?> cartDeletePro(@RequestBody List<String> productNames) {
	          try {
	              if (loginCart != null && !loginCart.isEmpty()) {
	                  loginCart.removeIf(cartItem -> productNames.contains(cartItem.getProductName()));
	                  return ResponseEntity.ok().body("Selected items deleted successfully.");
	              } else {
	                  return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Cart is empty or not found.");
	              }
	          } catch (Exception e) {
	              return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error while deleting items.");
	          }
	      }
		
		//장바구니 아이템 수량 변경
		@PutMapping("/cartQuantityPro/{CIN2}/{CIQ2}")
		public void cartQuantityPro(@PathVariable int CIN2, @PathVariable int CIQ2) {
			
			loginCart.get(CIN2).setAmount(CIQ2);
		}
		
		@GetMapping("/product/toggleWishlist/{productNo}")
	   public ResponseEntity<?> toggleWishlist(@PathVariable("productNo") String productNo) {
		    String memberNo = loginUserBean.getMemberNo();
		    boolean isWishlisted = productService.toggleWishlist(memberNo, productNo);

		    // JSON 객체를 생성하여 찜 여부와 이미지 경로를 담습니다.
		    Map<String, Object> response = new HashMap<>();
		    response.put("isWishlisted", isWishlisted);
		    String imagePath = isWishlisted ? "heart.png" : "noheart.png";
		    response.put("imagePath", imagePath);

		    return ResponseEntity.ok(response);
		}
		
		//로그인 객체의 지점 변경하기
		@PostMapping("/product/updateStore")
		@ResponseBody
		public String updateStore(@RequestParam("storeLocation") String storeLocation) {
		    try {
		        loginUserBean.setCheckStore(storeLocation);
		        return "success";
		    } catch (Exception e) {
		        return "error";
		    }
		}
		
		//결재 후 포인트 업데이트
		@PutMapping("payments/updatePoints/{pointsPlus}/{pointsMinus}")
		public ResponseEntity<?> updatePoints(@PathVariable("pointsPlus") int pointsPlus,
											  @PathVariable("pointsMinus") int pointsMinus) {
			
			//포인트 업데이트
			String memberNo = loginUserBean.getMemberNo();
			payDAO.updatePointsMinus(pointsMinus, memberNo);
			payDAO.updatePointsPlus(pointsPlus, memberNo);
			
			//업데이트된 멤버 정보를 가져옴
			MemberBean updateLoginUserBean = memberDAO.getMemberInfo(loginUserBean);
			loginUserBean.setPoints(updateLoginUserBean.getPoints());
			
			return ResponseEntity.ok().body("포인트 업데이트 성공");
		}
		
	}
		
