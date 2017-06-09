package ju.audiobook.model;

import java.util.List;

import ju.dto.ElibDTO;

public interface AudioDAO {
	public int audioUp(ElibDTO dto);
	
	public List<ElibDTO> selectImg();
	
	public ElibDTO selContent(String el_idx);
	
	public List<ElibDTO> selectlgmd(String el_lg, String el_md);
	
	public ElibDTO selMplist(String el_idx);

}
