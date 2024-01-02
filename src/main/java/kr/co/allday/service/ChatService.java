package kr.co.allday.service;

import java.io.IOException;
import java.nio.charset.StandardCharsets;

import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

/*
@Service
public class ChatService {

    private static final String OPENAI_CHAT_URL = "https://api.openai.com/v1/chat/completions";
    private static final String API_KEY = "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"; // OpenAI API 키

    public String getChatResponse(String userMessage) throws IOException {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(OPENAI_CHAT_URL);
            request.setHeader("Authorization", "Bearer " + API_KEY);
            request.setHeader("Content-Type", "application/json");
            System.out.println(userMessage);
            System.err.println(request);

            // 요청 본문 구성
            String jsonBody = "{"
                    + "\"model\": \"gpt-3.5-turbo\","
                    + "\"messages\": ["
                    + "  {"
                    + "    \"role\": \"system\","
                    + "    \"content\": \"You are a helpful assistant.\""
                    + "  },"
                    + "  {"
                    + "    \"role\": \"user\","
                    + "    \"content\": \"" + userMessage + "\""
                    + "  }"
                    + "]}";

            request.setEntity(new StringEntity(jsonBody, StandardCharsets.UTF_8));

            // OpenAI API 호출
            String responseString = httpClient.execute(request, httpResponse ->
                    EntityUtils.toString(httpResponse.getEntity()));

            System.out.println(responseString);
            // JSON 응답 처리
            ObjectMapper mapper = new ObjectMapper();
            String textResponse = mapper.readTree(responseString).at("/choices/0/message/content").asText();
            System.out.println(textResponse);
            return textResponse;
        }
    }
}
*/

@Service
public class ChatService {

    private static final String OPENAI_CHAT_URL = "https://api.openai.com/v1/chat/completions";
    private static final String API_KEY = "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"; // 여기에 OpenAI API 키를 입력하세요.

    public ResponseEntity<?> getChatResponse(String userMessage) throws IOException {
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost request = new HttpPost(OPENAI_CHAT_URL);
            request.setHeader("Authorization", "Bearer " + API_KEY);
            request.setHeader("Content-Type", "application/json");

            // 요청 본문 구성
            String jsonBody = "{"
                    + "\"model\": \"gpt-3.5-turbo\","
                    + "\"messages\": ["
                    + "  {"
                    + "    \"role\": \"system\","
                    + "    \"content\": \"You are a helpful assistant.\""
                    + "  },"
                    + "  {"
                    + "    \"role\": \"user\","
                    + "    \"content\": \"" + userMessage + "\""
                    + "  }"
                    + "]}";

            request.setEntity(new StringEntity(jsonBody, StandardCharsets.UTF_8));

            // OpenAI API 호출
            String responseString = httpClient.execute(request, httpResponse ->
                    EntityUtils.toString(httpResponse.getEntity()));

            // JSON 응답 처리
            ObjectMapper mapper = new ObjectMapper();
            JsonNode responseJson = mapper.readTree(responseString).at("/choices/0/message");
            return ResponseEntity.ok(responseJson);
        }
    }
}