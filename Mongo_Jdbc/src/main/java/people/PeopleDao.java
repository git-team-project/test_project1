package people;

import static com.mongodb.client.model.Filters.eq;

import static com.mongodb.client.model.Sorts.ascending;

import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Sorts;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.InsertOneResult;
import com.mongodb.client.result.UpdateResult;

import util.MongoInfo;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class PeopleDao {
	
	public List<People> findAll() {
		List<Document> findList = new ArrayList<>();
		List<People> dtoList = new ArrayList<>();
		
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("people");
			
			collection.find().sort(ascending("_id")).into(findList);
			
			for (int i = 0; i < findList.size(); i++) {
				People dto = new People();
				dto.setId((ObjectId) findList.get(i).get("_id"));
				dto.setName(findList.get(i).getString("name"));
				dto.setAge(findList.get(i).getInteger("age"));
				dtoList.add(dto);
			}
		} 
		
		return dtoList;
	}
	
	public long delete(String id) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("people");
			
			Bson query = eq("_id", new ObjectId(id));
	        DeleteResult result = collection.deleteOne(query);
	        
			return result.getDeletedCount();
		}
	}
	
	public People findOneById(String id) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("people");
		
			Bson query = eq("_id", new ObjectId(id));
			Document doc = collection.find(query).sort(Sorts.ascending("_id")).first();
	       
			People dto = new People();
			dto.setId((ObjectId) doc.get("_id"));
			dto.setName(doc.getString("name"));
			dto.setAge(doc.getInteger("age"));
			
			return dto;
		}
	}
	
	public long update(People dto) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("people");
			
			Document query = new Document().append("_id", dto.getId());
	        Bson updates = Updates.combine(
	                Updates.set("name", dto.getName()),
	                Updates.set("age", dto.getAge()));
			
			UpdateResult result = collection.updateOne(query, updates);
        
			return result.getModifiedCount();
		}
	}

	public boolean insert(People dto) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("people");
			String entyptPw = "";
			try {
				entyptPw = PeopleDao.entyptPassword(dto.getMemberId(), dto.getPw());
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			Document doc = new Document();
			doc.append("_id", new ObjectId());
			doc.append("memberId", dto.getMemberId());
		
			doc.append("pw", entyptPw);
			doc.append("address", dto.getAdress());
			doc.append("name", dto.getName());
			doc.append("dept", dto.getDept());
			doc.append("pno", dto.getPno());
			doc.append("email", dto.getEmail());
		
			InsertOneResult result = collection.insertOne(doc);
			
			return result.wasAcknowledged();
		}
	}
	
	static String entyptPassword(String id,String pw) throws NoSuchAlgorithmException{
	
		
		MessageDigest md = MessageDigest.getInstance("SHA-256");

		// 평문+id 암호화
		md.update(id.getBytes());
		pw = String.format("%064x", new BigInteger(1, md.digest()));
		System.out.println("raw+salt의 해시값 : "+ pw);
		return pw;
	}
}
