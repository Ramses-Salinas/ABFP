package com.abfp.dashboard.adapters.out;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.ExchangeFilterFunction;
import org.springframework.web.reactive.function.client.WebClient;

import com.abfp.dashboard.ports.out.GraphQLClientPort;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import reactor.core.publisher.Mono;

@Component
public class AppSyncGraphQLClient implements GraphQLClientPort {

    private final WebClient webClient;
    private final String endpoint;
    private final String apiKey;
    private final ObjectMapper objectMapper;
    
    private static final Logger logger = LoggerFactory.getLogger(AppSyncGraphQLClient.class);

    public AppSyncGraphQLClient(@Value("${appsync.endpoint}") String endpoint,
                                @Value("${appsync.apiKey}") String apiKey,
                                WebClient.Builder webClientBuilder,
                                ObjectMapper objectMapper) {
        this.endpoint = endpoint;
        this.apiKey = apiKey;
        this.objectMapper = objectMapper;

        if (endpoint == null || endpoint.isEmpty()) {
            throw new IllegalArgumentException("El endpoint de AppSync no está configurado");
        }

        // Construcción del WebClient con logging habilitado
        this.webClient = webClientBuilder
                .baseUrl(this.endpoint)
                .filter(logRequest())  // Logging de solicitudes
                .filter(logResponse()) // Logging de respuestas
                .build();
        logger.info(webClient.head()+"");
    }

    @Override
    public Map<String, Object> executeQuery(String query) {
        // Construir el mapa para el payload
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("query", query);

        // Convertir el mapa a JSON usando Jackson
        String payload = "";
        try {
            payload = objectMapper.writeValueAsString(requestBody);
        } catch (Exception e) {
            throw new RuntimeException("Error al serializar el payload", e);
        }

        return webClient.post()
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(new ParameterizedTypeReference<Map<String, Object>>() {})
                .block();
    }

    @Override
    public String executeQueryString(String query) {
        // Construir el mapa para el payload
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("query", query);

        // Convertir el mapa a JSON usando Jackson
        String payload = "";
        try {
            payload = objectMapper.writeValueAsString(requestBody);
            logger.info(payload);
        } catch (Exception e) {
            throw new RuntimeException("Error al serializar el payload", e);
        }

        return webClient.post()
                .header("x-api-key", apiKey)
                .header("Content-Type", "application/json")
                .bodyValue(payload)
                .retrieve()
                .bodyToMono(String.class)
                .block();
    }
    
    private static ExchangeFilterFunction logRequest() {
        Logger log = LoggerFactory.getLogger(AppSyncGraphQLClient.class);
        return ExchangeFilterFunction.ofRequestProcessor(request -> {
            log.info("Request: {} {}", request.method(), request.url());
            return Mono.just(request);
        });
    }

    private static ExchangeFilterFunction logResponse() {
        Logger log = LoggerFactory.getLogger(AppSyncGraphQLClient.class);
        return ExchangeFilterFunction.ofResponseProcessor(response -> {
            log.info("Response: {}", response.statusCode());
            return Mono.just(response);
        });
    }
}
