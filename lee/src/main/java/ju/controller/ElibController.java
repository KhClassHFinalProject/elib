package ju.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ju.dto.ElibDTO;
import ju.elib.model.ElibDAO;
import ju.modul.BookCateModul;
import ju.modul.ElibPaging;

@Controller
public class ElibController {
	
	@Autowired
	private ElibDAO elibDAO;
	
	/**eMagazine 메인*/
	@RequestMapping(value="eMagazine.ju")
	public ModelAndView eMagazine() {
		BookCateModul bcm=new BookCateModul();
		String bookLgSelect=bcm.BookLgSelect(8, 8, false);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("bookLgSelect", bookLgSelect);
		mav.setViewName("ebook/eMagazine");
		return mav;
	}
	
	/**eEdu 메인*/
	@RequestMapping(value="eEdu.ju")
	public ModelAndView eEdu() {
		BookCateModul bcm=new BookCateModul();
		String bookLgSelect=bcm.BookLgSelect(9, 9, false);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("bookLgSelect", bookLgSelect);
		mav.setViewName("ebook/eEdu");
		return mav;
	}
	
	/**최초 접근 검색내용*/
	@RequestMapping(value="elibFirst.ju")
	public ModelAndView elibFirst(
		@RequestParam(value="page", defaultValue="1")int page
		, @RequestParam(value="orderName", defaultValue="new")String orderName 
		, @RequestParam(value="idxParam", defaultValue="EB" )String idxParam
		) {
		orderName="new".equals(orderName)?"el_idx DESC":"el_recocount DESC, el_idx DESC";
		
		int startNum=(page-1)*ElibPaging.CONTENTSIZE+1;
		int endNum=startNum+ElibPaging.CONTENTSIZE-1;
		
		List<ElibDTO> elibArr=elibDAO.elibFirst(orderName, startNum, endNum, idxParam);
		int contentMax=elibDAO.elibFirstCount(idxParam);
		String paging=ElibPaging.getPaging(page, contentMax);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("elibArr", elibArr);
		mav.addObject("paging", paging);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**단순 검색*/
	@RequestMapping(value="elibSimpleSearch.ju")
	public ModelAndView elibSimpleSearch(
		@RequestParam(value="simpleSearchText", defaultValue="" )String simpleSearchText
		, @RequestParam(value="page", defaultValue="1" )int page
		, @RequestParam(value="orderName", defaultValue="new" )String orderName
		, @RequestParam(value="idxParam", defaultValue="EB" )String idxParam
		) {
		orderName="new".equals(orderName)?"el_idx DESC":"el_recocount DESC, el_idx DESC";
		
		int startNum=(page-1)*ElibPaging.CONTENTSIZE+1;
		int endNum=startNum+ElibPaging.CONTENTSIZE-1;
		
		List<ElibDTO> elibArr=elibDAO.elibSimple(simpleSearchText, orderName, startNum, endNum, idxParam);
		int contentMax=elibDAO.elibSimpleCount(simpleSearchText, orderName, idxParam);
		String paging=ElibPaging.getPaging(page, contentMax);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("elibArr", elibArr);
		mav.addObject("paging", paging);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**상세 검색*/
	@RequestMapping(value="elibDetailSearch.ju")
	public ModelAndView elibDetailSearch(
		@RequestParam(value="detailSubject", defaultValue="" )String detailSubject
		, @RequestParam(value="detailWrite", defaultValue="" )String detailWrite
		, @RequestParam(value="detailPub", defaultValue="" )String detailPub
		, @RequestParam(value="cateLg", defaultValue="99" )String cateLg
		, @RequestParam(value="cateMd", defaultValue="99" )String cateMd
		, @RequestParam(value="page", defaultValue="1" )int page
		, @RequestParam(value="orderName", defaultValue="new" )String orderName
		, @RequestParam(value="idxParam", defaultValue="EB" )String idxParam
		) {
		
		orderName="new".equals(orderName)?"el_idx DESC":"el_recocount DESC, el_idx DESC";
		
		String where="";
		
		detailSubject="".equals(detailSubject)?"":"el_subject LIKE '%" + detailSubject + "%' ";
		detailWrite="".equals(detailWrite)?"":"el_writer LIKE '%" + detailWrite + "%' ";
		detailPub="".equals(detailPub)?"":"el_pub LIKE '%" + detailPub + "%' ";
		cateLg="99".equals(cateLg)?"":"el_lg='" + cateLg + "' ";
		cateMd="99".equals(cateMd)?"":"el_md='" + cateMd + "' ";
		
		if(!"".equals(detailSubject)) where+=detailSubject;
		if(!"".equals(detailWrite)){
			if("".equals(where)) where+=detailWrite;
			else where+="AND "+detailWrite;
		}
		if(!"".equals(detailPub)){
			if("".equals(where)) where+=detailPub;
			else where+="AND "+detailPub;
		}
		if(!"".equals(cateLg)){
			if("".equals(where)) where+=cateLg;
			else where+="AND "+cateLg;
		}
		if(!"".equals(cateMd)){
			if("".equals(where)) where+=cateMd;
			else where+="AND "+cateMd;
		}
		if(!"".equals(where)){
			where="AND "+where;
		}
		
		int startNum=(page-1)*ElibPaging.CONTENTSIZE+1;
		int endNum=startNum+ElibPaging.CONTENTSIZE-1;
		
		List<ElibDTO> elibArr=elibDAO.elibDetail(where, orderName, startNum, endNum, idxParam);
		
		int contentMax=elibDAO.elibDetailCount(where, orderName, idxParam);
		String paging=ElibPaging.getPaging(page, contentMax);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("elibArr", elibArr);
		mav.addObject("paging", paging);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**전자도서 컨텐츠 선택*/
	@RequestMapping(value="elibContent.ju")
	public ModelAndView elibContent(@RequestParam(value="el_idx", defaultValue="0")String el_idx) {
		List<ElibDTO> elibArr=elibDAO.elibContent(el_idx);
		ModelAndView mav=new ModelAndView();
		
		mav.addObject("elibArr", elibArr.get(0));
		mav.setViewName("juJson");
		return mav;
	}
	
	/**추천 기능 Ajax*/
	@RequestMapping(value="elibRecommend.ju")
	public ModelAndView elibRecommend(@RequestParam(value="el_idx", defaultValue="0")String el_idx) {
		System.out.println("추천 : " + el_idx);
		ModelAndView mav=new ModelAndView();
		mav.addObject("recommend", el_idx);
		mav.setViewName("juJson");
		return mav;
	}

}