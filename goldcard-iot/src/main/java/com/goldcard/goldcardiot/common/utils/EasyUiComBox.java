package com.goldcard.goldcardiot.common.utils;

import java.io.Serializable;

/**
 * 心一：封装了easyUI的combox组件的实体
 * 
 * @author xinyi
 * 
 */
public class EasyUiComBox implements Serializable {
	
	private static final long serialVersionUID = 424305061995010924L;

	private String id; // id
	private String text;//
	private boolean selected;// 是否选中
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public boolean isSelected() {
		return selected;
	}

	public void setSelected(boolean selected) {
		this.selected = selected;
	}

	public EasyUiComBox(String id, String text, boolean selected) {
		this.id = id;
		this.text = text;
		this.selected = selected;
	}

	public EasyUiComBox() {
	}

	public EasyUiComBox(String id, String text) {
		super();
		this.id = id;
		this.text = text;
	}

}
