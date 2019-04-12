package com.itfarm.dto;

public class MemberVO {
	private String name;
	private String userid;
	private String pwd;
	private String email1;
	private String email2;
	private String phone1;
	private String phone2;
	private String phone3;
	private String roadAddr;
	private String addrDetail;
	private String zipNo;
	private String regDate;
	private int isAdmin;
	
	
	
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public int getIsAdmin() {
		return isAdmin;
	}
	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getPhone3() {
		return phone3;
	}
	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}
	public String getRoadAddr() {
		return roadAddr;
	}
	public void setRoadAddr(String roadAddr) {
		this.roadAddr = roadAddr;
	}
	public String getAddrDetail() {
		return addrDetail;
	}
	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}
	public String getZipNo() {
		return zipNo;
	}
	public void setZipNo(String zipNo) {
		this.zipNo = zipNo;
	}
	@Override
	public String toString() {
		return "MemberVO [name=" + name + ", userid=" + userid + ", pwd=" + pwd + ", email1=" + email1 + ", email2="
				+ email2 + ", phone1=" + phone1 + ", phone2=" + phone2 + ", phone3=" + phone3 + ", roadAddr=" + roadAddr
				+ ", addrDetail=" + addrDetail + ", zipNo=" + zipNo + "]";
	}
}