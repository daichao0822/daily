package com.bean;

import java.sql.Date;

public class Memo {
	private int g_intMemoId;
	private int g_intMemoUser;
	private Date g_datMemoDate;
	private String g_strMemoContent;

	public int getG_intMemoId() {
		return g_intMemoId;
	}

	public void setG_intMemoId(int memoId) {
		g_intMemoId = memoId;
	}

	public int getG_intMemoUser() {
		return g_intMemoUser;
	}

	public void setG_intMemoUser(int memoUser) {
		g_intMemoUser = memoUser;
	}

	public Date getG_datMemoDate() {
		return g_datMemoDate;
	}

	public void setG_datMemoDate(Date memoDate) {
		g_datMemoDate = memoDate;
	}

	public String getG_strMemoContent() {
		return g_strMemoContent;
	}

	public void setG_strMemoContent(String memoContent) {
		g_strMemoContent = memoContent;
	}
}
