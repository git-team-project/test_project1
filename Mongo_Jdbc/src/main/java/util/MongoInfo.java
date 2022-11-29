package util;

import java.io.FileReader;
import java.util.Properties;

public class MongoInfo {
	
	private static String path = MongoInfo.class.getResource("jdbc.properties").getPath();
	
	private MongoInfo() {} // private, 객체 생성 방지 
	
	public static String getUri() {
		String uri = "";
		try {
			Properties prop = new Properties();
			prop.load(new FileReader(path));
			
			uri = prop.getProperty("uri");
			String db = prop.getProperty("database");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return uri;
	}
	
	public static String getDataBase() {
		String db = "";
		try {
			Properties prop = new Properties();
			prop.load(new FileReader(path));
			
			db = prop.getProperty("database");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return db;
	}
}
