package people;

import org.bson.types.ObjectId;

public class People {
	private ObjectId id;
	private String name;
	private int age;

	public People() {
		super();
	}
	
	public People(ObjectId id, String name, int age) {
		super();
		this.id = id;
		this.name = name;
		this.age = age;
	}
	
	public People(String name, int age) {
		super();
		this.name = name;
		this.age = age;
	}

	public ObjectId getId() {
		return id;
	}

	public void setId(ObjectId id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}

	@Override
	public String toString() {
		return "PeopleDto [id=" + id + ", name=" + name + ", age=" + age + "]";
	}
}
