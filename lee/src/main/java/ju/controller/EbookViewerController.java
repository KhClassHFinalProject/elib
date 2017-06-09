package ju.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class EbookViewerController {
	
	/**뷰어 북마크 등록*/
	@RequestMapping(value="eViewerBookMakerAdd.ju")
	public ModelAndView eViewerBookMakerAdd(@RequestParam(value="page", defaultValue="a")String page) {
		System.out.println("추가 : " + page);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("juJson");
		return mav;
	}
	
	/**뷰어 북마크 삭제*/
	@RequestMapping(value="eViewerBookMakerDel.ju")
	public ModelAndView eViewerBookMakerDel(@RequestParam(value="page", defaultValue="a")String page) {
		System.out.println("삭제 : " + page);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("juJson");
		return mav;
	}
	
	/**뷰어 마지막 페이지 저장*/
	@RequestMapping(value="eViewerEndMaker.ju")
	public ModelAndView eViewerEndMaker(@RequestParam(value="endPage", defaultValue="a")String endPage) {
		System.out.println("마지막 : " + endPage);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("juJson");
		return mav;
	}

}