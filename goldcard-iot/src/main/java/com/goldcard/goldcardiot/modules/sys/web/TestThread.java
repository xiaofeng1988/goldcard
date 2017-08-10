package com.goldcard.goldcardiot.modules.sys.web;




public class TestThread extends Thread{
	
	 static{
		System.out.println("ppp");
	}
	
	public TestThread(){
		System.out.println("TestThread...");
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println("AAA");
	}
	
	public static void main(String[] args) {
		Thread a = new TestThread();
		a.start();
	}
	
	

}
