package kr.co.allday.bean;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PostBean {
	
	private int boardNo;
	private int postNo;
	private String memberNo;
	private String memberName;
	private String creationDate;
	@NotBlank
	private String title;
	@NotBlank
	private String postContent;
	private String attachment;
	private MultipartFile uploadAttachment;

}
