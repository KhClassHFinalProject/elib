package ju.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ju.dto.ElibDTO;
import ju.modul.BookCateModul;

@Controller
public class EbookController {
	
	/** 전자도서관 메인 */
	@RequestMapping(value="ebookMain.ju")
	public ModelAndView eMain() {
		ModelAndView mav=new ModelAndView();
		mav.setViewName("ebook/ebookMain");
		return mav;
	}
	
	/**전자도서 메인*/
	@RequestMapping(value="ebook.ju")
	public ModelAndView ebook() {
		BookCateModul bcm=new BookCateModul();
		String bookLgSelect=bcm.BookLgSelect(0, 7, true);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("bookLgSelect", bookLgSelect);
		mav.setViewName("ebook/ebook");
		return mav;
	}
	
	/**최초 접근 검색내용*/
	@RequestMapping(value="ebookFirst.ju")
	public ModelAndView ebookFirst(
		@RequestParam(value="page", defaultValue="1")int page
		, @RequestParam(value="order", defaultValue="new")String order 
		) {
		ModelAndView mav=new ModelAndView();
		
		ArrayList<ElibDTO> ebArr=new ArrayList<ElibDTO>(); 
		ElibDTO ebDTO=null;
		for(int i=1 ; i<6 ; i++){
			ebDTO=new ElibDTO();
			ebDTO.setEl_idx("EB"+System.currentTimeMillis());
			ebDTO.setEl_subject("제목 " + page + " / " + order);
			ebDTO.setEl_writer("지은이 " + page + " / " + order);
			ebDTO.setEl_pub("출판사 " + page + " / " + order);
			ebDTO.setEl_info("간략내용 " + page + " / " + order);
			ebArr.add(ebDTO);
		}
		
		mav.addObject("ebArr", ebArr);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**단순 검색*/
	@RequestMapping(value="ebookSimpleSearch.ju")
	public ModelAndView ebookSimpleSearch(
		@RequestParam(value="simpleSearchText", defaultValue="0" )String simpleSearchText
		, @RequestParam(value="page", defaultValue="1" )String page
		, @RequestParam(value="orderName", defaultValue="new" )String orderName
		) {
		
		simpleSearchText="".equals(simpleSearchText)?"미입력":simpleSearchText;
		page="".equals(page)?"미입력":page;
		
		ModelAndView mav=new ModelAndView();
		
		ArrayList<ElibDTO> ebArr=new ArrayList<ElibDTO>(); 
		ElibDTO ebDTO=null;
		for(int i=1 ; i<6 ; i++){
			ebDTO=new ElibDTO();
			ebDTO.setEl_idx("EB"+System.currentTimeMillis());
			ebDTO.setEl_subject(simpleSearchText + " 제목 " + page + " / " + orderName);
			ebArr.add(ebDTO);
		}
		
		mav.addObject("ebArr", ebArr);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**상세 검색*/
	@RequestMapping(value="ebookDetailSearch.ju")
	public ModelAndView ebookDetailSearch(
		@RequestParam(value="detailSubject", defaultValue="-1" )String detailSubject
		, @RequestParam(value="detailWrite", defaultValue="-1" )String detailWrite
		, @RequestParam(value="detailPub", defaultValue="-1" )String detailPub
		, @RequestParam(value="cateLg", defaultValue="-1" )String cateLg
		, @RequestParam(value="cateMd", defaultValue="-1" )String cateMd
		, @RequestParam(value="page", defaultValue="1" )String page
		, @RequestParam(value="orderName", defaultValue="new" )String orderName
		) {
		
		detailSubject="".equals(detailSubject)?"미입력":detailSubject;
		detailWrite="".equals(detailWrite)?"미입력":detailWrite;
		detailPub="".equals(detailPub)?"미입력":detailPub;
		cateLg="".equals(cateLg)?"미입력":cateLg;
		cateMd="".equals(cateMd)?"미입력":cateMd;
		page="".equals(page)?"미입력":page;
		
		ModelAndView mav=new ModelAndView();
		
		ArrayList<ElibDTO> ebArr=new ArrayList<ElibDTO>(); 
		ElibDTO ebDTO=null;
		for(int i=1 ; i<6 ; i++){
			ebDTO=new ElibDTO();
			ebDTO.setEl_idx("EB"+System.currentTimeMillis());
			ebDTO.setEl_subject(detailSubject + " / " + detailWrite + " / " + detailPub + " / " + cateLg + " / " + cateMd + " / " + page + " / " + orderName);
			ebArr.add(ebDTO);
		}
		
		mav.addObject("ebArr", ebArr);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**소분류 고침 Ajax*/
	@RequestMapping(value="ebookCate.ju")
	public ModelAndView ebookCate(@RequestParam(value="cateLgVal", defaultValue="0")int cateLgVal) {
		BookCateModul bcm=new BookCateModul();
		ArrayList<String> cateMd=bcm.BookMdArr(cateLgVal);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("cateMd", cateMd);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**전자도서 컨텐츠 선택*/
	@RequestMapping(value="ebookContent.ju")
	public ModelAndView ebookContent(@RequestParam(value="el_idx", defaultValue="0")String el_idx) {
		
		ArrayList<ElibDTO> ebArr=new ArrayList<ElibDTO>(); 
		ElibDTO ebDTO=null;
		ebDTO=new ElibDTO();
		ebDTO.setEl_idx(el_idx);
		ebArr.add(ebDTO);
		
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("ebArr", ebArr);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**전자도서 새로고침 기능 Ajax*/
	@RequestMapping(value="ebookRefresh.ju")
	public ModelAndView ebookRefresh(@RequestParam(value="el_idx", defaultValue="0")int el_idx) {
		int randomNum=(int)(Math.random()*10)+1;
		ModelAndView mav=new ModelAndView();
		if(randomNum>7){
			mav.addObject("msg", "불가?");
		}
		else{
			mav.addObject("msg", "가능!");
		}
		mav.setViewName("juJson");
		return mav;
	}
	
	/**전자도서 대출신청 기능 Ajax*/
	@RequestMapping(value="ebookLoan.ju")
	public ModelAndView ebookLoan(@RequestParam(value="el_idx", defaultValue="0")int el_idx) {
		System.out.println("대출 신청 : " + el_idx);
		ModelAndView mav=new ModelAndView();
		mav.addObject("loan", "대출 신청 : " + el_idx);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**전자도서 추천 기능 Ajax*/
	@RequestMapping(value="ebookRecommend.ju")
	public ModelAndView ebookRecommend(@RequestParam(value="el_idx", defaultValue="0")int el_idx) {
		System.out.println("추천 : " + el_idx);
		ModelAndView mav=new ModelAndView();
		mav.addObject("recommend", "추천 : " + el_idx);
		mav.setViewName("juJson");
		return mav;
	}
	
}
