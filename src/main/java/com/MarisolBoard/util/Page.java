package com.MarisolBoard.util;

import java.net.URLEncoder;

public class Page {

// postNum == pageListCount 일때만 사용할 수 있는 소스
	/****게시글 리스트 페이지****/
	public String getPageList(int pageNum, int postNum, int pageListCount, int totalCount) {
		
		String pageList = "";
		
		//페이지 리스트에서 마지막 번호
		int endPageNum = (int)(Math.ceil(pageNum/(double)postNum)*pageListCount);
		
		//페이지 리스트에서 시작 번호
		int startPageNum = endPageNum - pageListCount + 1;
		
		//실제 마지막 페이지 번호 계산
		int realEndPageNum = (int)(Math.ceil(totalCount/(double)pageListCount));
		if (endPageNum > realEndPageNum) {
			endPageNum = realEndPageNum;
		}
		
		//이전 페이지 목록 버튼 출력 조건 prev //다음 페이지 목록 버튼 출력 조건 nextv
		boolean prev = startPageNum == 1?false:true;
		boolean nextv = endPageNum*pageListCount >= totalCount?false:true;	
		
		//이전 페이지 목록 버튼 출력 조건 충족 시 버튼 출력
		if (prev) {
			pageList += " <a href=list?page=" + Integer.toString(startPageNum - 1) + ">◀</a>";
		}		
		
		//페이지 리스트 출력
		for(int i = startPageNum; i <= endPageNum; i++) {
			//링크가 붙는 페이지 번호
			if(pageNum != i) {
				pageList += " <a href=list?page=" + Integer.toString(i) + ">"+ i +"</a>";
			}
			
			//링크가 안붙는 페이지 번호(현재페이지)
			if(pageNum == i) {
				pageList += " <span style='font-weight:bold'>"+Integer.toString(i)+"</span>";
			}
		}
		
		//다음 페이지 목록 버튼 출력 조건 충족 시 버튼 출력
		if (nextv) {
			pageList += " <a href=list?page=" + Integer.toString(endPageNum + 1) + ">▶</a>";
		}		
				
		return pageList;
	}
	
	/****우편번호 주소 검색 리스트 생성****/
	public String getPageAddress(int pageNum, int postNum, int listCount, int totalCount, String addrSearch) throws Exception {

	System.out.println("addrSearch = " + addrSearch);	
		
	int totalPage = (int) Math.ceil(totalCount/(double)postNum); //전체 페이지 갯수
	int totalSection = (int) Math.ceil(totalPage/(double)listCount); //전체 섹션 개수
	
	pageNum = pageNum-1; //계산에 사용되는 페이지 번호는 0부터 시작
	int section = (int) Math.ceil(pageNum/listCount); //현재 위치한 섹션 번호	

	String pageList = "";
	
	if(totalPage != 1 )
	{
		for(int i=0; i < listCount ; i++){ 
			if(section > 0 && i == 0) 
				pageList +=	"<a href=addrSearch?page=" + Integer.toString((section-1)*listCount+(listCount)) + "&addrSearch=" + URLEncoder.encode(addrSearch,"UTF-8" ) + ">◀</a> ";
			if(totalPage == (i+section*listCount)){  break; }
			if(pageNum != (section*listCount + i))
				pageList += " <a href=addrSearch?page=" + Integer.toString(i+section*listCount+1) + "&addrSearch=" + URLEncoder.encode(addrSearch,"UTF-8" ) + ">" + Integer.toString(i+section*listCount+1) + "</a> ";
			else pageList += " <span style='font-weight: bold'>" + Integer.toString(section*listCount+i+1) + "</span>";
			if(totalSection >1 && i==(listCount-1) && totalPage != (i+section*listCount+1)) 
				pageList += "<a href=addrSearch?page=" + Integer.toString((section+1)*listCount+1) + "&addrSearch=" + URLEncoder.encode(addrSearch,"UTF-8" ) + ">▶</a>";
			
		}
 	} 
	return pageList==null?"":("[" + pageList + "]"); 
	}
	
}
