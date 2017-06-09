package ju.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import ju.modul.BookCateModul;

@Controller
public class AdminUploadController {
	
	/**최초 로딩*/
	@RequestMapping(value="adminUpload.ju")
	public ModelAndView adminElib(){
		BookCateModul bcm=new BookCateModul();
		String cateLg=bcm.BookLgSelect(0, 7, false);
		ModelAndView mav=new ModelAndView();
		mav.addObject("cateLg", cateLg);
		mav.setViewName("adminUpload/upload");
		return mav;
	}
	
	/** 업로드 */
	@RequestMapping(value="adminUpload.ju", method=RequestMethod.POST)
	public ModelAndView adminUpload(
			@RequestParam(value="readyIdx")String readyIdx
			, HttpServletRequest request){
		System.out.println("여긴 컨트롤러");
		
		System.out.println("넘어온 시간 : " + readyIdx);
		
		
		MultipartHttpServletRequest mphsr=(MultipartHttpServletRequest)request;
		List<MultipartFile> files = mphsr.getFiles("files");
		System.out.println(files.size());	
		
		String path=request.getSession().getServletContext().getRealPath("/")+"resources\\ebook\\";
		
		String el_idx="EB"+readyIdx;
		File bookFolder=new File(path + el_idx);
		for(int i=0 ; i<files.size() ; i++){
			if(bookFolder.isDirectory()){
				/*두번째 이후*/
				File[] fileCount=bookFolder.listFiles(new FilenameFilter() {
					public boolean accept(File dir, String name) {
						return ( name.endsWith(".jpg") || name.endsWith(".png") || name.endsWith(".gif"));
					}
				});
				/*for(int j=0 ; j<fileCount.length ; j++){
					System.out.println(fileCount[j].getName());
				}*/
				System.out.println(fileCount.length);
				copyInto(files.get(i), path+el_idx+"\\", Integer.toString(fileCount.length+1));
			}
			else{
				/*최초*/
				bookFolder.mkdirs();
				copyInto(files.get(i), path+el_idx+"\\", "1");
			}
		}
		
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("juJson");
		return mav;
	}
	
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