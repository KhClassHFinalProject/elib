package ju.modul;

public class ElibPaging {
	
	public static final int CONTENTSIZE=2;
	public static final int PAGESIZE=3;
	
	public ElibPaging() {
	}
	
	public static String getPaging(int page, int contentMax) {
		
		int pageMax=contentMax/CONTENTSIZE+(contentMax%CONTENTSIZE==0?0:1);
		int pageStart=(page/PAGESIZE-(page%PAGESIZE==0?1:0))*PAGESIZE+1;
		
		StringBuffer paging=new StringBuffer();
		paging.append("<ul class='pagination'>");
		
		/** << 만들기*/
		paging.append("<li data-page='before' ");
		if(pageStart==1){
			paging.append("class='disabled'>");
		}
		else{
			paging.append(">");
		}
		paging.append("<a href='#' onclick='return false' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>" );
		
		/**페이지 만들기*/
		for(int i=pageStart ; (i<pageStart+PAGESIZE) && (i<=pageMax) ; i++){
			paging.append("<li data-page='");
			paging.append(i);
			paging.append("'>");
			paging.append("<a href='#' onclick='return false'>");
			paging.append(i);
			paging.append("</a></li>");
		}
		
		/** >> 만들기*/
		paging.append("<li data-page='after' ");
		if( pageStart+PAGESIZE-1>=pageMax ){
			paging.append("class='disabled'>");
		}
		else{
			paging.append(">");
		}
		paging.append("<a href='#' onclick='return false' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li>" );
		
		paging.append("</ul>");
		
		return paging.toString();
	}

}