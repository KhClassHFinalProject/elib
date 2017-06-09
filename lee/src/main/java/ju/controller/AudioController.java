package ju.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ju.audiobook.model.AudioDAO;
import ju.dto.ElibDTO;
import ju.modul.BookCateModul;

@Controller
public class AudioController {
	
	@Autowired
	private AudioDAO audioDao;
	
	//오디오 플레이어
	@RequestMapping(value="aPlayer.ju")
	public ModelAndView aPlayer(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ebook/eAudio/audioPlayer/aPlayer");
		return mav;
	}
	//오디오 메인으로..
	@RequestMapping(value="eAudio.ju")
	public ModelAndView eAudio(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ebook/eAudio/eAudio");
		return mav;
	}
	
	//오디오 책 선택시..
	@RequestMapping(value="eAudioSelect.ju")
	public ModelAndView eAudioSelect(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("ebook/eAudio/eAudioSelect");
		return mav;
	}
	
	/**최초 접근 검색내용*/
	@RequestMapping(value="audioFirst.ju")
	public ModelAndView audioFirst(
		@RequestParam(value="page", defaultValue="1")int page
		, @RequestParam(value="order", defaultValue="new")String order)	{
		ModelAndView mav=new ModelAndView();
		List<ElibDTO> list = audioDao.selectImg();
		
		mav.addObject("ebArr", list);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**오디오책 컨텐츠 선택*/
	@RequestMapping(value="audioContent.ju")
	public ModelAndView ebookContent(@RequestParam(value="el_idx", defaultValue="0")String el_idx) {
		
		ModelAndView mav=new ModelAndView();
		ElibDTO dto = audioDao.selContent(el_idx);
		mav.addObject("ebArr", dto);
		mav.setViewName("juJson");
		return mav;
	}
	
	/**상세 검색*/
	@RequestMapping(value="audioDetailSearch.ju")
	public ModelAndView audioDetailSearch(
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
		List<ElibDTO> abArr = audioDao.selectlgmd(cateLg, cateMd);
		
		mav.addObject("ebArr", abArr);
		mav.setViewName("juJson");
		return mav;
	}
	/**단순 검색*/
	@RequestMapping(value="audioSimpleSearch.ju")
	public ModelAndView audioSimpleSearch(
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
	
	/**소분류 고침 Ajax*/
	@RequestMapping(value="audioCate.ju")
	public ModelAndView audioCate(@RequestParam(value="cateLgVal", defaultValue="0")int cateLgVal) {
		BookCateModul bcm=new BookCateModul();
		ArrayList<String> cateMd=bcm.BookMdArr(cateLgVal);
		ModelAndView mav=new ModelAndView();
		mav.addObject("cateMd", cateMd);
		mav.setViewName("juJson");
		return mav;
	}
	
}
