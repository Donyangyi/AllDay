package kr.co.allday.service;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.io.FilenameUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.PageBean;
import kr.co.allday.bean.PostBean;
import kr.co.allday.dao.BoardDAO;

@Service
@PropertySource("/WEB-INF/properties/option.properties")
public class BoardService {
	
	@Value("${path.upload}")
	private String path_upload;
	
	@Value("${page.listcnt}")
	private int page_listcnt;
	
	@Value("${page.paginationcnt}")
	private int page_paginationcnt;
	
	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;
	
	@Autowired
	private BoardDAO boardDAO;
	
	public List<PostBean> getPostList(int boardNo){
	    RowBounds rowBounds = new RowBounds(0, 5); 
	    return boardDAO.getPostList(boardNo, rowBounds);
	}
	
	public PostBean getPostInfo(int postNo) {
		return boardDAO.getPostInfo(postNo);
	}
	
	public String getBoardName(int boardNo) {
		return boardDAO.getBoardName(boardNo);
	}
	
	public List<PostBean> getAllPostList(int board_info_idx, int page) {
		int start = (page - 1) * page_listcnt;
		RowBounds rowBounds = new RowBounds(start, page_listcnt);
		
		return boardDAO.getPostList(board_info_idx, rowBounds);
	}
	
	public PageBean getPostCnt(int boardNo, int currentPage) {
		int content_cnt = boardDAO.getPostCnt(boardNo);
		
		PageBean pageBean = new PageBean(content_cnt, currentPage, page_listcnt, page_paginationcnt);
		return pageBean;
	}
	
	public void addPostInfo(PostBean writePostBean) {
		System.out.println(writePostBean.getTitle());
		System.out.println(writePostBean.getPostContent());
		System.out.println(writePostBean.getUploadAttachment().getSize());
		
		MultipartFile upload_file = writePostBean.getUploadAttachment();

		if (upload_file.getSize() > 0) {
			String file_name = saveUploadFile(upload_file);
			System.out.println(file_name);
			writePostBean.setAttachment(file_name);
		}

		writePostBean.setMemberNo(loginUserBean.getMemberNo());
		boardDAO.addPostInfo(writePostBean);
	}
	
	private String saveUploadFile(MultipartFile upload_file) {
		String file_name = System.currentTimeMillis() + "_" +  //아래 코드가 같은 파일명을 업로드시에 오류가 발생해서 시간을 붙여서 겹치지 않도록 함.
				FilenameUtils.getBaseName(upload_file.getOriginalFilename()) + "."
				+ FilenameUtils.getExtension(upload_file.getOriginalFilename());

		try {
			upload_file.transferTo(new File(path_upload + "/" + file_name));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return file_name;
	}
	
	public void modifyPostInfo(PostBean modifyPostBean) {
	    
		MultipartFile upload_file = modifyPostBean.getUploadAttachment();
		
		if(upload_file.getSize() > 0) { //upload_file이 있다면
			String file_name = saveUploadFile(upload_file);
			modifyPostBean.setAttachment(file_name);
		}
		boardDAO.modifyPostInfo(modifyPostBean);
	}
	
	public void deletePostInfo(int postNo) {
		boardDAO.deletePostInfo(postNo);
	}
}
