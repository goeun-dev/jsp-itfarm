package com.itfarm.dto;

import java.util.Date;

public class BoardVO {
	private String rcdNo;
	private String usrName;
	private String usrSubject;
	private String usrContent;
	private String usrPass;
	private String usrFileName;
	private String usrFileSize;
	private String usrDate;
	private String usrRefer;
	
	public String getRcdNo() {
		return rcdNo;
	}

	public void setRcdNo(String rcdNo) {
		this.rcdNo = rcdNo;
	}

	public String getUsrName() {
		return usrName;
	}

	public void setUsrName(String usrName) {
		this.usrName = usrName;
	}

	public String getUsrSubject() {
		return usrSubject;
	}

	public void setUsrSubject(String usrSubject) {
		this.usrSubject = usrSubject;
	}

	public String getUsrContent() {
		return usrContent;
	}

	public void setUsrContent(String usrContent) {
		this.usrContent = usrContent;
	}

	public String getUsrPass() {
		return usrPass;
	}

	public void setUsrPass(String usrPass) {
		this.usrPass = usrPass;
	}

	public String getUsrFileName() {
		return usrFileName;
	}

	public void setUsrFileName(String usrFileName) {
		this.usrFileName = usrFileName;
	}

	public String getUsrFileSize() {
		return usrFileSize;
	}

	public void setUsrFileSize(String usrFileSize) {
		this.usrFileSize = usrFileSize;
	}

	public String getUsrDate() {
		return usrDate;
	}

	public void setUsrDate(String usrDate) {
		this.usrDate = usrDate;
	}

	public String getUsrRefer() {
		return usrRefer;
	}

	public void setUsrRefer(String usrRefer) {
		this.usrRefer = usrRefer;
	}

	@Override
	public String toString() {
		return "BoardVO [RcdNo=" + rcdNo + ", UsrName=" + usrName + ", UsrSubject=" + usrSubject + ", UsrContent=" + usrContent  
				+ ", UsrPass=" + usrPass + ", UsrFileName=" + usrFileName + ", UsrFileSize=" + usrFileSize + ", UsrDate=" + usrDate
				+ ", UserRefer=" + usrRefer + "]";
	}

}