package kr.co.allday.bean;

import javax.validation.constraints.Email;
import javax.validation.constraints.Min;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.beans.factory.annotation.Value;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Data
public class MemberBean {

	private boolean memberLogin;
	private boolean checkMemberID;
	
	private String memberNo;
	
	@Size(min = 6, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
	private String memberID;
	
	@Size(min = 6, max = 20)
	@Pattern(regexp = "[a-zA-Z0-9]*")
    private String memberPass;
	
	//DB에 있는 컬럼X | 비밀번호 재검증용
	@Size(min = 6, max = 20)
    @Pattern(regexp = "[a-zA-Z0-9!@#$%^*]*")
    private String memberPass2;

    private String dob;

    @Size(min = 2, max = 30)
    private String memberName;

    @Size(min = 2, max = 100)
    private String address;

    @Pattern(regexp = "남성|여성")
    private String gender;

    @Email
    private String email;

    @Pattern(regexp = "\\d{2,3}-\\d{3,4}-\\d{4}")
    private String phoneNo;

    @Size(min = 3, max = 20)
    private String nickName;

    @Min(0)
    private int points;
    
    @Pattern(regexp = "Admin|Customer")
	private String memberRole;
    
    private String storeName;
    private String checkStore;
    
	public MemberBean() {
		this.memberLogin = false;
		this.checkMemberID = false;
		this.memberRole = "Customer";
		this.points = 0;
		this.storeName = null;
		this.checkStore = "신논현점";
	}
	
	

}
