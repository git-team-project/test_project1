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
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

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
                    Filters.eq("id", memberId), 
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
			MongoCollection<Document> collection = database.getCollection("member");
			
			collection.find().sort(ascending("_id")).into(findList);
			
			for (int i = 0; i < findList.size(); i++) {
				People dto = new People();
				dto.setId((ObjectId) findList.get(i).get("_id"));
				dto.setMemberId(findList.get(i).getString("id"));
				dto.setPw(findList.get(i).getString("pw"));
				dto.setAddress(findList.get(i).getString("address"));
				dto.setPno(findList.get(i).getString("pno"));
				dto.setEmail(findList.get(i).getString("email"));
				dto.setDept(findList.get(i).getString("dept"));
				dto.setName(findList.get(i).getString("name"));
				dtoList.add(dto);
			}
		} 
		
		return dtoList;
	}

	public long delete(String id) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("member");
			
			Bson query = eq("_id", new ObjectId(id));
	        DeleteResult result = collection.deleteOne(query);
	        
			return result.getDeletedCount();
		}
	}
	
	public People findOneById(String id) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("member");
		
			Bson query = eq("_id", new ObjectId(id));
			Document doc = collection.find(query).sort(Sorts.ascending("_id")).first();
	       
			People dto = new People();
			dto.setId((ObjectId) doc.get("_id"));
			dto.setMemberId(doc.getString("id"));
			dto.setAddress(doc.getString("address"));
			dto.setName(doc.getString("name"));
			dto.setDept(doc.getString("dept"));
			dto.setPno(doc.getString("pno"));
			dto.setEmail(doc.getString("email"));
			
			return dto;
		}
	}
	
	public long update(People dto) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("member");
			
			Document query = new Document().append("_id", dto.getId());
	        Bson updates = Updates.combine(
	                Updates.set("id", dto.getMemberId()),
	                Updates.set("address", dto.getAddress()),
	                Updates.set("name", dto.getName()),
	                Updates.set("dept", dto.getDept()),
	                Updates.set("pno", dto.getPno()),
	                Updates.set("email", dto.getEmail()));
			
			UpdateResult result = collection.updateOne(query, updates);
        
			return result.getModifiedCount();
		}
	}

	public boolean insert(People dto) {
		try(MongoClient mongoClient = MongoClients.create(MongoInfo.getUri())) {
			MongoDatabase database = mongoClient.getDatabase(MongoInfo.getDataBase());
			MongoCollection<Document> collection = database.getCollection("member");
			String entyptPw = "";
			try {
				entyptPw = PeopleDao.entyptPassword(dto.getMemberId(), dto.getPw());
			} catch(Exception e) {
				e.printStackTrace();
			}
			
			Document doc = new Document();
			doc.append("_id", new ObjectId());
			doc.append("id", dto.getMemberId());
		
			doc.append("pw", entyptPw);
			doc.append("address", dto.getAddress());
			doc.append("name", dto.getName());
			doc.append("dept", dto.getDept());
			doc.append("pno", dto.getPno());
			doc.append("email", dto.getEmail());
		
			InsertOneResult result = collection.insertOne(doc);
			
			return result.wasAcknowledged();
		}
	}
	
}
