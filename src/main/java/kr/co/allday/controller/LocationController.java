package kr.co.allday.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/location")
public class LocationController {

    @GetMapping("/location_main")
    public String main() {
        return "location/location_main";

    }
    
    @GetMapping("/location_main2")
    public String main2() {
        return "location/location_main2";

    }
}