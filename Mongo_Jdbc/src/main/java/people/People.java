package people;

import org.bson.types.ObjectId;

public class People {
	private ObjectId id;
	private String memberId;
	private String pw;
	private String address;
	private String name;
<<<<<<< HEAD
	private String dept;
	private String pno;
	private String email;
	
=======
	private int age;
	private String memberId;
	private String pw;
	private String address;
	private String pno;
	private String email;
	private String dept;

>>>>>>> main
	public People() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public People(ObjectId id, String memberId, String address, String name, String dept, String pno,
			String email) {
		super();
		this.id = id;
		this.memberId = memberId;
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
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getPno() {
		return pno;
	}
	public void setPno(String pno) {
		this.pno = pno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
		return "People [id=" + id + ", memberId=" + memberId + ", pw=" + pw + ", address=" + address + ", name=" + name
				+ ", dept=" + dept + ", pno=" + pno + ", email=" + email + "]";
	}

}
