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

public class PeopleDao {
	
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
	                Updates.set("id", dto.getName()),
	                Updates.set("address", dto.getAddress()),
	                Updates.set("name", dto.getName()),
	                Updates.set("dept", dto.getDept()),
	                Updates.set("pno", dto.getPno()),
	                Updates.set("email", dto.getEmail()));
			
			UpdateResult result = collection.updateOne(query, updates);
        
			return result.getModifiedCount();
		}
	}

}
