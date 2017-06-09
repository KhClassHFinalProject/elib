package ju.elib.model;

import java.util.List;

import ju.dto.ElibDTO;

public interface ElibDAO {
	
	/**전자도서관 책 등록*/
	public int elibInsert(ElibDTO dto);
	
	/**최초 접근*/
	public List<ElibDTO> elibFirst(String orderName, int startNum, int endNum, String idxParam);
	
	/**최초 접근 갯수*/
	public int elibFirstCount(String idxParam);
	
	/**컨텐츠 선택*/
	public List<ElibDTO> elibContent(String el_idx);
	
	/**단순 검색*/
	public List<ElibDTO> elibSimple(String simpleSearchText, String orderName, int startNum, int endNum, String idxParam);
	
	/**단순 검색 갯수*/
	public int elibSimpleCount(String simpleSearchText, String orderName, String idxParam);
	
	/**상세검색*/
	public List<ElibDTO> elibDetail(String where, String orderName, int startNum, int endNum, String idxParam);
	
	/**상세검색 갯수*/
	public int elibDetailCount(String where, String orderName, String idxParam);
	
	/**뷰어*/
	public List<ElibDTO> elibViewer(String el_idx);
	
}