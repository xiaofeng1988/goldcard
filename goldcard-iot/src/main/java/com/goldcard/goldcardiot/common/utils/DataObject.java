package com.goldcard.goldcardiot.common.utils;

import java.util.ArrayList;
import java.util.Map;

public class DataObject {
	private String message = "";
	private boolean status = true;
	private Object data = new ArrayList<Map<String, Object>>();
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
