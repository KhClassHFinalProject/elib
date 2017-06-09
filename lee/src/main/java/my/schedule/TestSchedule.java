package my.schedule;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class TestSchedule {
	
	@Scheduled(cron="0/5 * * * * *")
	public void testSchedule() {
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		System.out.println("현재시간 : " + dateFormat.format(cal.getTime()));
	}

}
