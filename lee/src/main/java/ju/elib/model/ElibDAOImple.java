package ju.elib.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import ju.dto.ElibDTO;

public class ElibDAOImple implements ElibDAO {

	private SqlSessionTemplate sqlMap;
	
	public ElibDAOImple(SqlSessionTemplate sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}
	
	/**전자도서관 책 등록*/
	public int elibInsert(ElibDTO dto) {
		int resultCount=sqlMap.insert("elibINSelib", dto);
		return resultCount;
	}
	
	/**eEdu 최초 접근*/
	public List<ElibDTO> elibFirst(String orderName, int startNum, int endNum, String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>(); 
		hmap.put("orderName", orderName);
		hmap.put("startNum", Integer.toString(startNum));
		hmap.put("endNum", Integer.toString(endNum));
		hmap.put("idxParam", idxParam);
		List<ElibDTO> eEduArr=sqlMap.selectList("elibSELfir", hmap);
		return eEduArr;
	}
	
	/**eEdu 최초 접근 갯수*/
	public int elibFirstCount(String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("idxParam", idxParam);
		int contentMax=sqlMap.selectOne("elibSElfirCount", hmap);
		return contentMax;
	}
	
	/**eEdu 컨텐츠 선택*/
	public List<ElibDTO> elibContent(String el_idx) {
		List<ElibDTO> eEduArr=sqlMap.selectList("elibSELcon", el_idx);
		return eEduArr;
	}
	
	/**eEdu 단순 검색*/
	public List<ElibDTO> elibSimple(String simpleSearchText, String orderName, int startNum, int endNum, String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("simpleSearchText", simpleSearchText);
		hmap.put("orderName", orderName);
		hmap.put("startNum", Integer.toString(startNum));
		hmap.put("endNum", Integer.toString(endNum));
		hmap.put("idxParam", idxParam);
		List<ElibDTO> eEduArr=sqlMap.selectList("elibSELsimple", hmap);
		return eEduArr;
	}
	
	/**eEdu 단순 검색 갯수*/
	public int elibSimpleCount(String simpleSearchText, String orderName, String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("simpleSearchText", simpleSearchText);
		hmap.put("orderName", orderName);
		hmap.put("idxParam", idxParam);
		int contentMax=sqlMap.selectOne("elibSELsimpleCount", hmap);
		return contentMax;
	}
	
	/**eEdie 상세검색*/
	public List<ElibDTO> elibDetail(String where, String orderName, int startNum, int endNum, String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("where", where);
		hmap.put("orderName", orderName);
		hmap.put("startNum", Integer.toString(startNum));
		hmap.put("endNum", Integer.toString(endNum));
		hmap.put("idxParam", idxParam);
		List<ElibDTO> elibArr=sqlMap.selectList("elibSELdetail", hmap);
		return elibArr;
	}
	
	/**eEdie 상세검색 갯수*/
	public int elibDetailCount(String where, String orderName, String idxParam) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("where", where);
		hmap.put("orderName", orderName);
		hmap.put("idxParam", idxParam);
		int contentMax=sqlMap.selectOne("elibSELdetailCount", hmap);
		return contentMax;
	}
	
	/**eEdu 뷰어*/
	public List<ElibDTO> elibViewer(String el_idx) {
		HashMap<String, String> hmap=new HashMap<String, String>();
		hmap.put("el_idx", el_idx);
		List<ElibDTO> elibArr=sqlMap.selectList("elibSELview", hmap);
		return elibArr;
	}

}
