package priv.yjh.lostAndFound.utils;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MakeFolderUtil {
	
	private MakeFolderUtil() {
		
	}

	public static String makeDir(String basePath, Date date, String user) {
		
		String year = MakeFolderUtil.dateFormatToString("yyyy", date);
//		basePath = basePath + "\\" + year;
		basePath = basePath + File.separator+ year;
		File file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

		String month = MakeFolderUtil.dateFormatToString("MM", date);
//		basePath = basePath + "\\" + month;
		basePath = basePath + File.separator + month;
		file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

//		basePath = basePath + "\\" + user;
		basePath = basePath + File.separator + user;
		file = new File(basePath);
		if (!file.exists())
			file.mkdirs();

		return basePath;
	}
	
	private static String dateFormatToString(String key,Date date) {

		return new SimpleDateFormat(key).format(date);
	}

}
