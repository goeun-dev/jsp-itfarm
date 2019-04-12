package com.itfarm.dto;

/**
 * @author goeun
 *
 */
public class ExperienceVO {

	private String title; // 상품명 o
	private String adultPrice; // 대인가격 o
	private String childPrice; // 대인가격 o
	private String imgPath;
	// 이미지경로 o
	/* private String minStartday; // 출발일(부터) o private String maxStartday; //
	 * 출발일(까지) o */ 
	private String prodCode;
	// 상품코드
	/* private String prodStatusCode; //예약상태코드 o */ 
	private String sidoCode; // 시도코드
	private String sidoName; // 시도명 o
	private String villageName; // 마을명 o


	public String getChildPrice() {
		return childPrice;
	}

	public void setChildPrice(String childPrice) {
		this.childPrice = childPrice;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAdultPrice() {
		return adultPrice;
	}

	public void setAdultPrice(String adultPrice) {
		this.adultPrice = adultPrice;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getProdCode() {
		return prodCode;
	}

	public void setProdCode(String prodCode) {
		this.prodCode = prodCode;
	}

	public String getSidoCode() {
		return sidoCode;
	}

	public void setSidoCode(String sidoCode) {
		this.sidoCode = sidoCode;
	}

	public String getSidoName() {
		return sidoName;
	}

	public void setSidoName(String sidoName) {
		this.sidoName = sidoName;
	}

	public String getVillageName() {
		return villageName;
	}

	public void setVillageName(String villageName) {
		this.villageName = villageName;
	}

}
