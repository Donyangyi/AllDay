package kr.co.allday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/event")
public class EventController {

	@GetMapping("/event_main")
	public String main() {
	    return "event/event_main";
	}

	@GetMapping("/event_end")
	public String event_end() {
		return "event/event_end";
	}
	
	@GetMapping("/event_winning")
	public String event_winning() {
		return "event/event_winning";
	}
	
}
