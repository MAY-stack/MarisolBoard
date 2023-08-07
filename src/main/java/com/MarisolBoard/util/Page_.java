package com.MarisolBoard.util;

public class Page_ {

	public String getPageList(int pageNum, int postNum, int pageListCount, int totalCount, String keyword) {
		//pageNum : 현재 페이지 번호 
		//postNum : 한 화면에 보여지는 게시물 행 갯수
		//pageListCount : 하단 페이지리스트에 보여질 페이지 갯수
		//totalCount : 전체 행 갯수 <=SQL로 값을 구한다
		//totalPage : 전체 페이지 갯수
		//section : 한 개의 페이지 목록 ex) 1 2 3 4 5 -> section = 1, 6 7 8 9 10 -> section = 2	
		//totalSection : 전체 section 갯수
		
		//예) totalCount =7, postNum=5, totalSection=1, 
		int totalPage =	(int) Math.ceil(totalCount/(double)postNum);
		int totalSection = (int) Math.ceil(totalPage/(double)pageListCount);
		int section = (int) Math.ceil(pageNum/(double)pageListCount);
		
		String pageList = "";
		
		//◀ 6 7 8 9 10 ▶ 출력 형식
		
		if (totalPage != 1) {
			for(int i = 1; i <= pageListCount; i++) {
				//1. '◀' 출력 조건
				//	- section 값이 1보다 크고 i가 
				//	- i == 1
				if(section > 1 && i == 1){
					pageList += " &nbsp; <a href=list?page=" + Integer.toString((section-2)*pageListCount + pageListCount) + "&keyword=" + keyword + ">◀</a>";
				}
				//2. 페이지 출력 중단 조건
				if(totalPage < ((section-1)*pageListCount + i)){
					break;
				}
				//3.인자로 가져온 페이지 값과 비교해서 나온 페이지 값이 같으면(현재페이지에는) 링크를 안붙이고 다른 페이지에는 해당 페이지로 갈 수 있는 링크를 붙임
				if(pageNum == (section-1)*pageListCount + i) {
					pageList += " &nbsp; <span style='font-weight: 600; font-size: 15pt; border-bottom: 1px solid rgba(88, 88, 88, 0.5);'>" + pageNum + "</span>";
				}else pageList += " &nbsp; <a href = list?page=" + ((section-1)*pageListCount+i) + "&keyword=" + keyword + ">"+ Integer.toString((section-1)*pageListCount+i) + "</a>";
				//4. '▶' 출력 조건
				//	- i == pageListCount --> 페이지 리스트 갯수 만큼 페이지 리스트를 다 출력했고, 페이지 리스트의 끝
				//	- totalSection이 1보다 커야함 섹션이 2개이상일때부터 다음섹션으로 가는게 생기니까..
				//	- totalPage > i + (section-1)*pageListCount + 1	--> 아직 출력할 페이지가 남아 있음을 의미
				if(i==pageListCount && totalSection>1 && totalPage>=(i+(section-1)*pageListCount+1)) {
					pageList += " &nbsp; <a href=list?page=" + Integer.toString(section*pageListCount + 1) + "&keyword=" + keyword + ">▶</a>";
				}
			}
		}
		return pageList;
	}
	
}