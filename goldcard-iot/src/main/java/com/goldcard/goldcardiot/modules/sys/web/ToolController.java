package com.goldcard.goldcardiot.modules.sys.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.goldcard.goldcardiot.common.utils.MethodUtil;
import com.goldcard.goldcardiot.common.utils.UtilValidate;

@Controller
@RequestMapping("/tool")
public class ToolController {

	private Log log = LogFactory.getLog(ToolController.class); // 处理日志的对象
//	private static MethodUtil util = new MethodUtil(); // 信息传递公用类
	// 初始化转换页面
	@RequestMapping(value = "/binaryswap/load")
	public String binaryswapLoad() {
		return "/tool/binaryswap";
	}

	/**
	 * 心一：十进制->二进制
	 * 
	 * @param decimal
	 * @return
	 */
	@RequestMapping(value = "/decimalToBinary")
	@ResponseBody
	public Map<String, Object> decimalToBinary(HttpServletResponse response,String decimal) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		if (UtilValidate.isNotEmpty(decimal)) {
			int a = Integer.parseInt(decimal);
			String result = Integer.toBinaryString(a);
			resultMap.put("status", true);
			resultMap.put("result", result);
		}else{
			resultMap.put("status", false);
			resultMap.put("result", "");
		}
		return resultMap;
	}

	/**
	 * 心一:二进制->十进制
	 * 
	 * @param decimal
	 * @return
	 */
	@RequestMapping(value = "/binaryToDecimal")
	@ResponseBody
	public Map<String, Object> binaryToDecimal(String binary) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String result = null;
		if (UtilValidate.isNotEmpty(binary)) {
			result = Integer.valueOf(binary, 2).toString();
			resultMap.put("status", true);
			resultMap.put("result", result);
		}else{
			resultMap.put("status", false);
			resultMap.put("result", "");
		}
		return resultMap;
	}



}
