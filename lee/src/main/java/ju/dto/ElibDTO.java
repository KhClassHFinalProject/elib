package ju.dto;

public class ElibDTO {

	private String el_idx;
	private String el_lg;
	private String el_md;
	private String el_subject;
	private String el_writer;
	private String el_pub;
	private String el_info;
	private String el_path;
	private String el_recommend;
	private int el_recocount;
	
	public ElibDTO() {
	}

	public ElibDTO(String el_idx, String el_lg, String el_md, String el_subject, String el_writer, String el_pub,
			String el_info, String el_path, String el_recommend, int el_recocount) {
		super();
		this.el_idx = el_idx;
		this.el_lg = el_lg;
		this.el_md = el_md;
		this.el_subject = el_subject;
		this.el_writer = el_writer;
		this.el_pub = el_pub;
		this.el_info = el_info;
		this.el_path = el_path;
		this.el_recommend = el_recommend;
		this.el_recocount = el_recocount;
	}

	public String getEl_idx() {
		return el_idx;
	}

	public void setEl_idx(String el_idx) {
		this.el_idx = el_idx;
	}

	public String getEl_lg() {
		return el_lg;
	}

	public void setEl_lg(String el_lg) {
		this.el_lg = el_lg;
	}

	public String getEl_md() {
		return el_md;
	}

	public void setEl_md(String el_md) {
		this.el_md = el_md;
	}

	public String getEl_subject() {
		return el_subject;
	}

	public void setEl_subject(String el_subject) {
		this.el_subject = el_subject;
	}

	public String getEl_writer() {
		return el_writer;
	}

	public void setEl_writer(String el_writer) {
		this.el_writer = el_writer;
	}

	public String getEl_pub() {
		return el_pub;
	}

	public void setEl_pub(String el_pub) {
		this.el_pub = el_pub;
	}

	public String getEl_info() {
		return el_info;
	}

	public void setEl_info(String el_info) {
		this.el_info = el_info;
	}

	public String getEl_path() {
		return el_path;
	}

	public void setEl_path(String el_path) {
		this.el_path = el_path;
	}

	public String getEl_recommend() {
		return el_recommend;
	}

	public void setEl_recommend(String el_recommend) {
		this.el_recommend = el_recommend;
	}

	public int getEl_recocount() {
		return el_recocount;
	}

	public void setEl_recocount(int el_recocount) {
		this.el_recocount = el_recocount;
	}
	
}