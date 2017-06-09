package ju.controller;

import java.io.File;
import java.io.FilenameFilter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import ju.dto.ElibDTO;
import ju.elib.model.ElibDAO;

@Controller
public class EbookViewerController{
	
	@Autowired
	private ElibDAO elibDAO;
	
	/**뷰어*/
	@RequestMapping(value="eViewer.ju")
	public ModelAndView eViewer(@RequestParam(value="el_idx")String el_idx, HttpServletRequest request) {
		System.out.println("el_idx.indexOf('EA') : " + el_idx.indexOf("EA"));
		System.out.println("el_idx.indexOf('EB') : " + el_idx.indexOf("EB"));
		System.out.println("el_idx.indexOf('EE') : " + el_idx.indexOf("EE"));
		
		List<ElibDTO> elibArr=null;
		String path=request.getSession().getServletContext().getRealPath("/")+"resources\\elib\\";
		
		if(el_idx.indexOf("EA")==1){
			/* 돌려 보내기*/
		}
		else if(el_idx.indexOf("EB")==1){
			/* 회원 검사 */
		}
		else{
			elibArr=elibDAO.elibViewer(el_idx);
			path+="eEdu\\"+elibArr.get(0).getEl_idx()+"\\";
		}
		
		ArrayList<String> imgPath=new ArrayList<String>();
		
		File elibFile=new File(path);
		File[] contentPath=elibFile.listFiles(new FilenameFilter() {
			public boolean accept(File dir, String name) {
				return ( name.endsWith(".jpg") || name.endsWith(".png") || name.endsWith(".gif"));
			}
		});
		for(int i=0 ; i<contentPath.length ; i++){
			imgPath.add("\\lee\\resources\\elib\\eEdu\\"+elibArr.get(0).getEl_idx()+"\\"+contentPath[i].getName());
		}
		System.out.println(imgPath.size());
		String endPage=Integer.toString(imgPath.size()%2==0?imgPath.size()+1:imgPath.size()+2);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("elibArr", elibArr.get(0));
		mav.addObject("imgPath", imgPath);
		mav.addObject("endPage", endPage);
		mav.setViewName("ebook/eViewer");
		return mav;
	}
	
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