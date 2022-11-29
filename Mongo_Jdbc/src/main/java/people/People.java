package people;
import org.bson.types.ObjectId;
public class People {
	private ObjectId id;
	private String name;
	private int age;
	private String memberId;
	private String pw;
	private String address;
	private String pno;
	private String email;
	private String dept;
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
	
	public People(String id, String pw, String address, String name, String dept, String pno, String email) {
		super();
		this.memberId = id;
		this.pw = pw;
		this.address = address;
		this.name = name;
		this.dept = dept;
		this.pno = pno;
		this.email = email;
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
	
	// member_id
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	// pw
	public String getPw() {
		return pw;
	}
	
	public void setPw(String pw) {
		this.pw = pw;
	}
	
	// address
	public String getAdress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	// pno
	public String getPno() {
		return pno;
	}
	
	public void setPno(String pno) {
		this.pno = pno;
	}
	
	// email
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	// dpt
	public String getDept() {
		return dept;
	}
	
	public void setDept(String dept) {
		this.dept = dept;
	}
	
	@Override
	public String toString() {
		return "PeopleDto [id=" + id + ", name=" + name + ", age=" + age + "]";
	}
}