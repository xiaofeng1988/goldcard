package com.goldcard.goldcardiot.common.utils;

/***
 * 周恪竭：处理分页信息的对象
 * 
 * @author Administrator
 * 
 */
//@SuppressWarnings("unused")
public class Paging {

	private int pageSize = CommonValue.PAGE_SIZE;// 每页显示多少条
	private int total;// 总共多少条
	private int currentPage = 1;// 当前第几页
	private int nextPage;// 下一页页码
	private int prevPage;// 上一页页码
	private int firstPage = 1;// 首页页码
	private int endPage;// 尾页页码
	
	private int firstIndex; // 
	private int rows; //==pageSize
	private int page;//==currentPage
	

	public int getPageSize() {
		pageSize=this.getRows();
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		if(pageSize != 0){
			int cp = (total / pageSize);
			if(cp < currentPage){
				this.setCurrentPage(cp+1);
			}
		}
		this.total = total;
	}

	public int getCurrentPage() {
		currentPage=this.getPage();
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		if(currentPage <= 0){
			currentPage = 1;
		}
		this.currentPage = currentPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getFirstPage() {
		return firstPage;
	}


	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getFirstIndex() {
		firstIndex = (this.getCurrentPage() - 1 ) * this.getPageSize();
		if(firstIndex < 0){
			firstIndex = 0;
		}else if(firstIndex > total){
			firstIndex = total;
		}
		return firstIndex;
	}

	public void setFirstIndex(int firstIndex) {
		this.firstIndex = (this.getCurrentPage() - 1 ) * this.getPageSize() ;
	}
	
	public int getRows() {
		return rows;
	}

	public void setRows(int rows) {
		this.rows = rows;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}


	@Override
	public String toString() {
		return "Paging [currentPage=" + currentPage + ", endPage=" + endPage
				+ ", firstIndex=" + firstIndex + ", firstPage=" + firstPage
				+ ", nextPage=" + nextPage + ", pageSize=" + pageSize
				+ ", prevPage=" + prevPage + ", total=" + total + "]";
	}
	
}
