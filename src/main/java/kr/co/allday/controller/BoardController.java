package kr.co.allday.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.co.allday.bean.BoardBean;
import kr.co.allday.bean.CommentBean;
import kr.co.allday.bean.MemberBean;
import kr.co.allday.bean.PageBean;
import kr.co.allday.bean.PostBean;
import kr.co.allday.dao.BoardDAO;
import kr.co.allday.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardDAO boardDAO;

	@Autowired
	private BoardService boardService;

	@Resource(name = "loginUserBean")
	private MemberBean loginUserBean;

	@GetMapping("board_main")
	public String board_main(Model model) {
		ArrayList<List<PostBean>> list = new ArrayList<List<PostBean>>();

		for (int i = 1; i <= 4; i++) {
			List<PostBean> list1 = boardService.getPostList(i);
			list.add(list1);
		}

		model.addAttribute("list", list);

		List<BoardBean> board_list = boardDAO.getBoardAllInfo();

		model.addAttribute("board_list", board_list);
		return "/board/board_main";
	}

	@GetMapping("/read")
	public String read(@RequestParam("boardNo") int boardNo, @RequestParam("postNo") int postNo,
			@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

		model.addAttribute("boardNo", boardNo);

		//게시글 정보 가져오기
		PostBean readPostBean = boardService.getPostInfo(postNo);
		model.addAttribute("readPostBean", readPostBean); // 상세정보
		model.addAttribute("postNo", postNo); // 수정할 글의 인덱스 번호 호출
		model.addAttribute("page", page);
		
		//댓글 모두 가져오기
		List<CommentBean> commentBeans = boardDAO.getAllComments(postNo);
		model.addAttribute("commentBeans",commentBeans);

		return "/board/read";

	}
	
	@GetMapping("/read_pro")
	public String read_pro(@RequestParam("boardNo") int boardNo, @RequestParam("postNo") int postNo,
						   @RequestParam(value = "page", defaultValue = "1") int page, 
						   @RequestParam("comment_content") String comment_content ,Model model) {
		
		//댓글 등록시 로그인 되지 않으면 로그인 창으로 이동시킴.
		if(loginUserBean.isMemberLogin() == false) {
			return"redirect:../member/login_main";
		}
		
		model.addAttribute("boardNo",boardNo);
		model.addAttribute("postNo",postNo);
		model.addAttribute("page", page);
		
		CommentBean commentBean = new CommentBean();
		commentBean.setPostNo(postNo);
		commentBean.setCommentText(comment_content);
		commentBean.setMemberNo(loginUserBean.getMemberNo());
		
		boardDAO.addComment(commentBean);
		return "redirect:../board/read";
	}

	@GetMapping("/board_detail")
	public String main(@RequestParam("boardNo") int boardNo, @RequestParam(value = "page", defaultValue = "1") int page,
			Model model) { // a태그로 넘겨서 @RequestParam으로 받음

		model.addAttribute("boardNo", boardNo);

		String boardName = boardService.getBoardName(boardNo);
		model.addAttribute("boardName", boardName);

		List<PostBean> postList = boardService.getAllPostList(boardNo, page);
		model.addAttribute("postList", postList);
		model.addAttribute("loginUserBean", loginUserBean);

		PageBean pageBean = boardService.getPostCnt(boardNo, page);
		model.addAttribute("pageBean", pageBean);
		model.addAttribute("page", page);

		return "board/board_detail";
	}

	@GetMapping("/write")
	public String write(@ModelAttribute("writePostBean") PostBean writePostBean, @RequestParam("boardNo") int boardNo) { // set
		writePostBean.setBoardNo(boardNo);

		return "board/write";
	}

	@PostMapping("/write_pro")
	public String write_pro(@Valid @ModelAttribute("writePostBean") PostBean writePostBean, BindingResult result) { // get

		if (result.hasErrors()) {
			return "board/write";
		}

		boardService.addPostInfo(writePostBean);

		return "board/write_success";
	}

	@GetMapping("/not_writer")
	public String not_writer() {
		return "board/not_writer";
	}

	@GetMapping("/modify")
	public String modify(@RequestParam("boardNo") int boardNo, @RequestParam("postNo") int postNo,
			@ModelAttribute("modifyPostBean") PostBean modifyPostBean, @RequestParam("page") int page, Model model) {

		model.addAttribute("boardNo", boardNo);
		model.addAttribute("postNo", postNo);
		model.addAttribute("page", page);

		// 게시글 하나의 정보 가져오기
		PostBean tempPostBean = boardService.getPostInfo(postNo);

		modifyPostBean.setMemberName(tempPostBean.getMemberName());
		modifyPostBean.setCreationDate(tempPostBean.getCreationDate());
		modifyPostBean.setTitle(tempPostBean.getTitle());
		modifyPostBean.setPostContent(tempPostBean.getPostContent());
		modifyPostBean.setAttachment(tempPostBean.getAttachment());
		modifyPostBean.setMemberNo(tempPostBean.getMemberNo());
		modifyPostBean.setBoardNo(boardNo);
		modifyPostBean.setPostNo(postNo);

		return "board/modify";
	}

	@PostMapping("/modify_pro")
	public String modify_pro(@Valid @ModelAttribute("modifyPostBean") PostBean modifyPostBean, BindingResult result,
			@RequestParam("page") int page, Model model) {
		model.addAttribute("page", page);
		if (result.hasErrors()) {
			return "board/modify";
		}
		boardService.modifyPostInfo(modifyPostBean);
		return "board/modify_success";
	}
	
	@GetMapping("/delete")
	public String delete(@RequestParam("boardNo") int boardNo,
	          @RequestParam("postNo") int postNo,
	          Model model) {
		boardService.deletePostInfo(postNo);
	    model.addAttribute("boardNo", boardNo);
		return "board/delete";
	}

}
