package ju.dto;

public class AudioListDTO {
	private int track;
	private String name;
	private String file;
	private String length;//재생 시간 보류~

	public AudioListDTO() {
		super();
	}

	public AudioListDTO(int track, String name, String file, String length) {
		super();
		this.track = track;
		this.name = name;
		this.file = file;
		this.length = length;
	}

	public int getTrack() {
		return track;
	}

	public void setTrack(int track) {
		this.track = track;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getLength() {
		return length;
	}

	public void setLength(String length) {
		this.length = length;
	}

}
