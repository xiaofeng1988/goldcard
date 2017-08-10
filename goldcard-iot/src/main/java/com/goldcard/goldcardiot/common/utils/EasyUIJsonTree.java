package com.goldcard.goldcardiot.common.utils;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 树形结构实体
 * @author 心一
 *
 */
public class EasyUIJsonTree implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 424305061995010924L;
	private String id;
	private String text;
	private String no;
	private String pno;
	private String iconCls;
	private List<EasyUIJsonTree> children ;
	private String state = CommonValue.TREE_OPEN_STATE;
	private boolean checked = false;
	private Map<String,Object> attributes = new HashMap<String, Object>();
	
	public EasyUIJsonTree() {
	}
	
	public EasyUIJsonTree(String id, String text, String iconCls,
			List<EasyUIJsonTree> children, String state, boolean checked,
			Map<String, Object> attributes) {
		super();
		this.id = id;
		this.text = text;
		this.iconCls = iconCls;
		this.children = children;
		this.state = state;
		this.checked = checked;
		this.attributes = attributes;
	}

	/**  
	 * 返回 no 的值   
	 * @return no  
	 */
	public String getNo() {
		return no;
	}

	/**  
	 * 设置 no 的值  
	 * @param no
	 */
	public void setNo(String no) {
		this.no = no;
	}

	/**  
	 * 返回 pno 的值   
	 * @return pno  
	 */
	public String getPno() {
		return pno;
	}

	/**  
	 * 设置 pno 的值  
	 * @param pno
	 */
	public void setPno(String pno) {
		this.pno = pno;
	}

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
	public String getIconCls() {
		return iconCls;
	}
	public void setIconCls(String iconCls) {
		this.iconCls = iconCls;
	}
	public List<EasyUIJsonTree> getChildren() {
		return children;
	}
	public void setChildren(List<EasyUIJsonTree> children) {
		this.children = children;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
	public Map<String, Object> getAttributes() {
		return attributes;
	}
	public void setAttributes(Map<String, Object> attributes) {
		this.attributes = attributes;
	}
	
}
