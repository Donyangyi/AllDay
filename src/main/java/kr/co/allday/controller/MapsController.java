package kr.co.allday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/maps")
public class MapsController {
	
	@GetMapping("/maps_main")
    public String owner_main() {
        return "maps/maps_main";
    }

}
