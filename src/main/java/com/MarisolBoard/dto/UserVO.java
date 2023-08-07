package com.MarisolBoard.dto;

//import java.util.List;

public class UserVO {
	
	private String userid;
	private String username;
	private String password;
	private String pw_set_date;
	private String gender;
	private String hobby;
	private String job;
	private String description;
	private String signup_date;
	private String zipcode;
	private String address;	//실무에서는 대부분 분리해서 저장 함 
	private String telno;
	private String email;
	private String authkey;
	private String role;
	
	private String org_filename;
	private String stored_filename;
	private long filesize;
	
	private String addr1;
	private String addr2;
	
	private String authcode;
	

	public String getAuthcode() {
		return authcode;
	}
	public void setAuthcode(String authcode) {
		this.authcode = authcode;
	}
	
	public String getSignup_date() {
		return signup_date;
	}
	public void setSignup_date(String signup_date) {
		this.signup_date = signup_date;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getPw_set_date() {
		return pw_set_date;
	}
	public void setPw_set_date(String pw_set_date) {
		this.pw_set_date = pw_set_date;
	}
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getHobby() {
		return hobby;
	}
	public void setHobby(String hobby) {
		this.hobby = hobby;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAuthkey() {
		return authkey;
	}
	public void setAuthkey(String authkey) {
		this.authkey = authkey;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	public String getOrg_filename() {
		return org_filename;
	}
	public void setOrg_filename(String org_filename) {
		this.org_filename = org_filename;
	}
	public String getStored_filename() {
		return stored_filename;
	}
	public void setStored_filename(String stored_filename) {
		this.stored_filename = stored_filename;
	}
	public long getFilesize() {
		return filesize;
	}
	public void setFilesize(long filesize) {
		this.filesize = filesize;
	}
	

	public String getAddr1() {
		return addr1;
	}
	public void setAddr1(String addr1) {
		this.addr1 = addr1;
	}
	public String getAddr2() {
		return addr2;
	}
	public void setAddr2(String addr2) {
		this.addr2 = addr2;
	}
	
}