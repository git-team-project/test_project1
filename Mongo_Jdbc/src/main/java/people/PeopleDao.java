package people;

import static com.mongodb.client.model.Filters.eq;
import static com.mongodb.client.model.Sorts.ascending;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.mongodb.BasicDBObject;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Sorts;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.DeleteResult;
import com.mongodb.client.result.InsertOneResult;
import com.mongodb.client.result.UpdateResult;

import util.MongoInfo;

public class PeopleDao {
	
	static String entyptPassword(String id,String pw) throws NoSuchAlgorithmException{
		MessageDigest md = MessageDigest.getInstance("SHA-256");

		// 평문+id 암호화
		md.update(id.getBytes());
		pw = String.format("%064x", new BigInteger(1, md.digest()));
		System.out.println("raw+salt의 해시값 : "+ pw);
		return pw;
	}
	
	public boolean loginCheck(String memberId, String pw) throws NoSuchAlgorithmException{
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("member");
			
			// db에 암호화된 비번을 select하기 위해
			// 입력한 비번도 암호화
			pw = entyptPassword(memberId, pw);
			
			Bson query = Filters.and(
                    Filters.eq("memberId", memberId), 
                    Filters.eq("pw", pw));
			
			Document doc = collection.find(query).first();			
			if(doc != null) {
				return true;
			} else {
				return false;
			}
		} 
	}
	
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
			
			Document doc = new Document();
			doc.append("_id", new ObjectId());
			doc.append("name", dto.getName());
			doc.append("age", dto.getAge());
		
			InsertOneResult result = collection.insertOne(doc);
			
			return result.wasAcknowledged();
		}
	}
	
}
