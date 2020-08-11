package com.spring.kanghm.model;

import java.util.HashMap;
import java.util.List;

public interface InterEclassDAO {

	// 첨부파일이 존재하지 않는 자유게시판 글쓰기
	int addFreeboard(FreeboardVO freeboardvo);

	// 첨부파일이 존재하는 자유게시판 글쓰기
	int addFreeboard_withFile(FreeboardVO freeboardvo);

	// 자유게시판 총게시물 개수 구하기
	int getFreeTotalCount(HashMap<String, String> paraMap);

	// 자유게시판 목록 가져오기
	List<FreeboardVO> getFreeboardList(HashMap<String, String> paraMap);

	// 자유게시판 조회수 증가 없이 글 조회하기
	FreeboardVO getFreeViewNoAdd(String free_seq);

	// 자유게시판 댓글쓰기
	int addFreeComment(FreeCommentVO freecommentvo);

	// 자유게시판 댓글불러오기
	List<FreeCommentVO> freecommentList(HashMap<String, String> paraMap);

	// 자유게시판 글번호에 해당하는 댓글의 총갯수를 알아오기
	int getCommentTotalCount(HashMap<String, String> paraMap);

	// 자유게시판 댓글 삭제하기
	int delFreeComment(String delseq);


}
