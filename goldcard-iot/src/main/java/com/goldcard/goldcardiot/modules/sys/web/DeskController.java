package com.goldcard.goldcardiot.modules.sys.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 桌面控制器
 * @author 心一
 *
 */
@Controller
@RequestMapping(value="/deskController")
public class DeskController {
	
	@RequestMapping("/main/load")
	public String loadDesk(){
		
		return "common/welcome";
	}

}
