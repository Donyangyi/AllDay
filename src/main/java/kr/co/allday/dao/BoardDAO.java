package kr.co.allday.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.co.allday.bean.BoardBean;
import kr.co.allday.bean.CommentBean;
import kr.co.allday.bean.PostBean;
import kr.co.allday.mapper.BoardMapper;

@Repository
public class BoardDAO {

	@Autowired
	private BoardMapper boardMapper;
	
	public List<BoardBean> getBoardAllInfo(){
		return boardMapper.getBoardAllInfo();
	}
	
	public List<PostBean> getPostList(int boardNo, RowBounds rowBounds){
		return boardMapper.getPostList(boardNo, rowBounds);
	}
	
	public PostBean getPostInfo(int postNo) {
		return boardMapper.getPostInfo(postNo);
	}
	
	public String getBoardName(int boardNo) {
		return boardMapper.getBoardName(boardNo);
	}
	
	public int getPostCnt(int boardNo) {
		return boardMapper.getPostCnt(boardNo);
	}
	
	public void addPostInfo(PostBean writePostBean) {
		boardMapper.addPostInfo(writePostBean);
	}
	
	public void modifyPostInfo(PostBean modifyPostBean) {
		boardMapper.modifyPostInfo(modifyPostBean);
	}
	
	public void deletePostInfo(int postNo) {
		boardMapper.deletePostInfo(postNo);
	}
	
	public List<CommentBean> getAllComments(int postNo) {
		return boardMapper.getAllComments(postNo);
	}
	
	public void addComment(CommentBean commentBean) {
		boardMapper.addComment(commentBean);
	}
	
	public void deleteComment(int commentNo, String memberNo) {
		System.out.println("DAO : " + commentNo + "\n" + memberNo);
		boardMapper.deleteComment(commentNo, memberNo);
	}
}
