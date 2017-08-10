package com.goldcard.goldcardiot.common.utils;
import java.util.ArrayList;  
import java.util.List; 

/**
 * 心一：树形结构
 * @author Administrator
 *
 */ 
public class GeneralTree {  
      
    private List<Node> lst = new ArrayList<Node>();  
    public class Node{  
        public String data;    //子节点
        public String parent;  //父节点
        
        
    }  
  
    public void addNode(String parent,String child){  
        Node t = new Node();  
        t.data = child;  
        t.parent = parent;  
        lst.add(t);  
    }  
      
    public String getParent(String x){  
        for(int i = 0; i<lst.size();i++){  
            if(lst.get(i).data.equals(x))  
                return lst.get(i).parent;  
        }  
        return null;  
    }  
      
    public List<String> getChild(String x){  
        List<String> t = new ArrayList<String>();  
        for(int i=0;i<lst.size();i++){  
            if(lst.get(i).parent.equals(x))  
                t.add(lst.get(i).data);  
        }  
        return t;  
    }  
    /** 
     * @param args 
     */  
//    public static void main(String[] args) {  
//        // TODO Auto-generated method stub  
//  
//        GeneralTree t = new GeneralTree();  
//        t.addNode("世界","亚洲");  
//        t.addNode("世界","欧洲");  
//        t.addNode("世界","美洲");  
//        t.addNode("亚洲","中国");  
//        t.addNode("亚洲","日本");  
//        t.addNode("亚洲","韩国");  
//        t.addNode("中国","湖北");  
//        t.addNode("中国","北京");  
//        t.addNode("中国","上海");  
//          
//        System.out.println(t.getParent("中国"));  
//        System.out.println("-------------");  
//        System.out.println(t.getChild("中国"));  
//    }  
  
}  
