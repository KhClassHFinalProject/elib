package ju.audiobook.model;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import ju.dto.ElibDTO;

public class AudioDAOImple implements AudioDAO {
	
	private SqlSessionTemplate sqlMap;
	
	public AudioDAOImple(SqlSessionTemplate sqlMap) {
		super();
		this.sqlMap = sqlMap;
	}

	public int audioUp(ElibDTO dto){
		int count = sqlMap.insert("abINSaudio",dto);
		return count;
	}
	
	public List<ElibDTO> selectImg(){
		List<ElibDTO> list = sqlMap.selectList("abSELaudio");
		return list;
	}
	
	public ElibDTO selContent(String el_idx){
		ElibDTO dto = sqlMap.selectOne("abSELcon", el_idx);
		return dto;
	}
	
	public List<ElibDTO> selectlgmd(String el_lg, String el_md){
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("el_lg", el_lg);
		map.put("el_md", el_md);
		List<ElibDTO> list = sqlMap.selectList("abSELlgmd", map);
		return list;
	}

	public ElibDTO selMplist(String el_idx) {
		ElibDTO dto = sqlMap.selectOne("abSELmp",el_idx);
		return dto;
	}
	
}
