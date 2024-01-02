package kr.co.allday.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import kr.co.allday.service.ChatService;

/*
@RestController
public class ChatbotController {

	@Autowired
    private ChatService openAIService;

    @PostMapping("/chatbot")
    public ResponseEntity<String> getChatbotResponse(@RequestParam String message) {
        try {
        	System.out.println(message);
            String response = openAIService.getChatResponse(message);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
        }
    }
}
*/

@RestController
public class ChatbotController {
    @Autowired
    private ChatService openAIService;

    @PostMapping("/chatbot")
    public ResponseEntity<?> getChatbotResponse(@RequestParam String message) {
        try {
            return openAIService.getChatResponse(message);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error: " + e.getMessage());
        }
    }
}