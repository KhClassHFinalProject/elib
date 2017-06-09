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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import ju.audiobook.model.AudioDAO;
import ju.dto.ElibDTO;
import ju.modul.BookCateModul;

@Controller
public class AdminController {
		@Autowired
		private AudioDAO audioDao;
		
		//오디오북 관리페이지
	
		//전송 submit 버튼을 클릭했을시 반응
		@RequestMapping(value="eAudioAdd2.ju")
		public String fileUpload(@RequestParam(value="audio") List<MultipartFile> audiosUp
								, @RequestParam(value="abimg") MultipartFile img 
								, @RequestParam(value="cateLg", defaultValue="0")int cateLg
						        , @RequestParam(value="cateMd", defaultValue="0")int cateMd
								, HttpServletRequest req
								, @ModelAttribute("edto")ElibDTO edto){
			
			String cAuPath = req.getSession().getServletContext().getRealPath("/")+"resources\\elib\\cover\\";
			String path = req.getSession().getServletContext().getRealPath("/resources/elib/eAudio/");
			
			//idx 지정타임 스탬프
			String el_idx = "AB"+System.currentTimeMillis();
			
			//오디오 idx 폴더를 나누기 위한 과정
			File audioFolder = new File(path+"\\"+el_idx);
			
			for(int i=0;i<audiosUp.size();i++){
				
				if(audioFolder.isDirectory()){
					File[] fileCount=audioFolder.listFiles(new FilenameFilter() {
						
						public boolean accept(File dir, String name) {
							return (name.endsWith(".mp3"));
						}
					});
					for(int j=0 ; j<fileCount.length ; j++){
					System.out.println(fileCount[j].getName());
					}
					System.out.println(fileCount.length);
				
					copyInto(audiosUp.get(i), path+"\\"+el_idx+"\\", Integer.toString(fileCount.length+1));
					
				}else{
					audioFolder.mkdirs();
					copyInto(audiosUp.get(i), path+"\\"+el_idx+"\\", "1");
				}
				
			}
			
			//표지 이미지 파일이름 split 확장자 자르기
			String[] coverName=img.getOriginalFilename().split("\\.");
			
			copyInto(img, cAuPath, el_idx);
			
			edto.setEl_lg(Integer.toString(cateLg));
		    edto.setEl_md(Integer.toString(cateMd));
			edto.setEl_idx(el_idx);
			edto.setEl_path(req.getContextPath()+"\\resources\\elib\\cover\\"+edto.getEl_idx()+"."+coverName[1]);
			edto.setEl_recommend("~");
			edto.setEl_recocount(0);
			
			
			System.out.println(edto.getEl_idx());
			System.out.println(edto.getEl_lg());
			System.out.println(edto.getEl_md());
			System.out.println(edto.getEl_subject());
			System.out.println(edto.getEl_writer());
			System.out.println(edto.getEl_pub());
			System.out.println(edto.getEl_info());
			System.out.println(edto.getEl_path());
			System.out.println(edto.getEl_recommend());
			System.out.println(edto.getEl_recocount());
			
			audioDao.audioUp(edto);
			/*
			for(MultipartFile temp:audiosUp){
				System.out.println("업로드할 파일들 :"+temp.getOriginalFilename());
				copyInto2(temp,path);
			}
			*/
			
			return path;
		}
	
	
		//오디오 관리 페이지로 들어가는지 확인 및 출력
		@RequestMapping(value="eAudioAdd.ju")
		public ModelAndView eAudioAdd() {
			BookCateModul bcm = new BookCateModul();
			String cate = bcm.BookLgSelect(0, 7, false);
			System.out.println(cate);
			ModelAndView mav = new ModelAndView();
			mav.addObject("cateLg",cate);
			mav.setViewName("ebook/eAudio/eAudioAdmin/eAudioAdd");
			return mav;
		}
		
		//업로드 할 파일들의 속성을 추출 및 업로드 하기 위한 메서드
		public void copyInto(MultipartFile upload, String path, String changeName){
			
			System.out.println("파일이름 : "+upload.getOriginalFilename());
			System.out.println("파일 크기 : " + upload.getSize());
			
			try {
				byte bytes[]=upload.getBytes();
				String[] fileName=upload.getOriginalFilename().split("\\.");
				fileName[0]=changeName;
				File outFile=new File(path+"/"+fileName[0]+"."+ fileName[1]);
				FileOutputStream fos = new FileOutputStream(outFile);
				
				fos.write(bytes);
				fos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		

}
