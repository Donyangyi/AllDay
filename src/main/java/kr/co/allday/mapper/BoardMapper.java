package kr.co.allday.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;
import org.apache.ibatis.annotations.Update;
import org.apache.ibatis.session.RowBounds;

import kr.co.allday.bean.BoardBean;
import kr.co.allday.bean.CommentBean;
import kr.co.allday.bean.PostBean;

public interface BoardMapper {

	@Select("select boardno, boardname from board order by boardno")
	List<BoardBean> getBoardAllInfo();
	
	//글목록 조회
	@Select("select a1.postno, a1.title, a2.membername, to_char(a1.creationdate, 'YYYY-MM-DD') as creationdate "
			+ "from posts a1, memberinfo a2 "
			+ "where a1.memberno = a2.memberno and a1.boardNo = #{boardNo} "
			+ "order by a1.postno desc")
	List<PostBean> getPostList(int boardNo, RowBounds rowBounds);
	
	//상세정보 조회
	@Select("select a2.membername as membername, to_char(a1.creationDate, 'YYYY-MM-DD') as creationDate, "
			+ "a1.title, a1.postContent, a1.attachment, a1.memberNo "
			+ "from posts a1, memberinfo a2 "
			+ "where a1.memberNo = a2.memberNo and postno = #{postNo}")
	PostBean getPostInfo(int postNo);
	
	//카테고리 식별
	@Select("select boardname from board where boardno = #{boardNo}")
	String getBoardName(int boardNo);
	
	//게시글 갯수(게시글 갯수로 페이징 처리)
	@Select("select count(*) from posts where boardNo=#{boardNo}")
	int getPostCnt(int boardNo);
	
	//게시글 생성
	@SelectKey(statement = "select post_seq.nextval from dual", keyProperty = "postNo", before = true, resultType = int.class)
	@Insert("insert into posts (boardno, postno, memberno, creationdate, title, postcontent, attachment) "
			+ "values(#{boardNo}, #{postNo}, #{memberNo}, sysdate, #{title}, #{postContent}, #{attachment, jdbcType=VARCHAR})")
	void addPostInfo(PostBean writePostBean);
	
	//게시글 수정
	@Update("update posts set title = #{title}, postcontent = #{postContent}, "
			+ "attachment = #{attachment, jdbcType=VARCHAR} where postno = #{postNo}")
	void modifyPostInfo(PostBean modifyPostBean);
	
	//게시글 삭제
	@Delete("delete from posts where postNo = #{postNo}")
	void deletePostInfo(int postNo);
	
	//댓글 생성
	@SelectKey(statement = "select comments_seq.nextval from dual", keyProperty = "commentNo", before = true, resultType = int.class)
	@Insert("insert into comments (postno, commentno, commenttext, commentdate, memberno)"
			+ "values (#{postNo}, #{commentNo}, #{commentText}, TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), #{memberNo})")
	void addComment(CommentBean commentBean);
	
	//댓글 조회
	@Select("select c1.commentno, c1.memberno , c1.commenttext, a1.membername, c1.commentdate "
			+ "from comments c1 "
			+ "inner join memberinfo a1 on c1.memberno = a1.memberno "
			+ "where c1.postno= #{postNo} order by c1.commentdate desc")
	List<CommentBean> getAllComments(int postNo);
	
	//댓글 삭제
	@Delete("delete from comments "
			+ "where commentno = #{commentNo} and memberno = #{memberNo}")
	void deleteComment(@Param("commentNo") int commentNo, @Param("memberNo") String memberNo);
	
}
		