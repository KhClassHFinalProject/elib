package ju.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import ju.dto.ElibDTO;
import ju.elib.model.ElibDAO;
import ju.modul.BookCateModul;

@Controller
public class AdminUploadController {
	
	@Autowired
	private ElibDAO elibDAO;
	
	/**최초 로딩*/
	@RequestMapping(value="adminUpload.ju")
	public ModelAndView adminElib(){
		ModelAndView mav=new ModelAndView();
		mav.setViewName("adminUpload/elibUpload");
		return mav;
	}
	
	/**그룹에 따른 대분류 가져오기*/
	@RequestMapping(value="adminElibGrupLg.ju")
	public ModelAndView adminElibGrupLg(@RequestParam(value="groupNum", defaultValue="7")int groupNum){
		BookCateModul bcm=new BookCateModul();
		String cateLg=null;
		if(groupNum==7){
			cateLg=bcm.BookLgSelect(0, 7, false);
		}
		else{
			cateLg=bcm.BookLgSelect(groupNum, groupNum, false);
		}
		ModelAndView mav=new ModelAndView();
		mav.addObject("cateLg", cateLg);
		mav.setViewName("juJson");
		return mav;
	}
	
	
	/** 내용 업로드 */
	@RequestMapping(value="adminUpload.ju", method=RequestMethod.POST)
	public ModelAndView adminUpload(
			@RequestParam(value="readyIdx")String readyIdx
			, @RequestParam(value="cateLg", defaultValue="0")int cateLg
			, HttpServletRequest request){
		System.out.println("여긴 컨트롤러");
		
		MultipartHttpServletRequest mphsr=(MultipartHttpServletRequest)request;
		List<MultipartFile> files = mphsr.getFiles("files");
		String path=request.getSession().getServletContext().getRealPath("/")+"resources\\elib\\";
		
		String elGroup=null;
		if(cateLg==8){
			elGroup="EM";
			path+="eMagazine\\";
		}
		else if(cateLg==9){
			elGroup="EE";
			path+="eEdu\\";
		}
		else{
			elGroup="EB";
			path+="ebook\\";
		}
		String el_idx=elGroup+readyIdx;
		System.out.println("el_idx : " + el_idx);
		System.out.println(path);
		
		File bookFolder=new File(path + el_idx);
		for(int i=0 ; i<files.size() ; i++){
			if(bookFolder.isDirectory()){
				/*두번째 이후*/
				File[] fileCount=bookFolder.listFiles(new FilenameFilter() {
					public boolean accept(File dir, String name) {
						return ( name.endsWith(".jpg") || name.endsWith(".png") || name.endsWith(".gif"));
					}
				});
				
				String changeName=Integer.toString(fileCount.length+1);
				
				while(changeName.length()!=4){
					changeName="0"+changeName;
				}
				System.out.println(changeName);
				
				copyInto(files.get(i), path+el_idx+"\\", changeName);
			}
			else{
				/*최초*/
				bookFolder.mkdirs();
				copyInto(files.get(i), path+el_idx+"\\", "0001");
			}
		}
		
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("juJson");
		return mav;
	}
	
	/*관리자 전자도서관 리스트*/
	@RequestMapping(value="adminElibList.ju", method=RequestMethod.POST)
	public void adminElibList(
			@ModelAttribute("elibDTO")ElibDTO elibDTO
			, @RequestParam(value="cateLg", defaultValue="0")int cateLg
			, @RequestParam(value="cateMd", defaultValue="0")int cateMd
			, @RequestParam(value="cover")MultipartFile cover
			, HttpServletRequest request
		){
		
		String el_idx=elibDTO.getEl_idx();
		String path=request.getSession().getServletContext().getRealPath("/")+"resources\\elib\\cover\\";
		String elGroup="EB";
		if(cateLg==8){
			elGroup="EM";
		}
		else if(cateLg==9){
			elGroup="EE";
		}
		el_idx=elGroup+el_idx;
		elibDTO.setEl_idx(el_idx);
		
		elibDTO.setEl_lg(Integer.toString(cateLg));
		elibDTO.setEl_md(Integer.toString(cateMd));
		
		String[] coverName=cover.getOriginalFilename().split("\\.");
		elibDTO.setEl_path(request.getContextPath()+"\\resources\\elib\\cover\\"+elibDTO.getEl_idx()+"."+coverName[1]);
		
		elibDTO.setEl_recommend("~");
		elibDTO.setEl_recocount(0);
		
		copyInto(cover, path, el_idx);
		
		int resultCount=elibDAO.elibInsert(elibDTO);
		System.out.println(resultCount);
	}
	
	/*파일 업로드 하는 메소드*/
	public void copyInto(MultipartFile files, String path, String changeName) {
		try {
			byte bytes[]=files.getBytes();
			String[] fileName=files.getOriginalFilename().split("\\.");
			fileName[0]=changeName;
			File outFile=new File(path+fileName[0]+"."+ fileName[1]);
			FileOutputStream fos=new FileOutputStream(outFile);
			fos.write(bytes);
			fos.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}