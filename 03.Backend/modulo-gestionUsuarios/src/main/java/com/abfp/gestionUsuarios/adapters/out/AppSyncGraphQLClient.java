package com.abfp.gestionUsuarios.adapters.out;

import java.util.HashMap;
import java.util.Map;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import com.abfp.gestionUsuarios.ports.out.GraphQLClientPort;

@Component
public class AppSyncGraphQLClient  implements GraphQLClientPort{
	
	private final WebClient webClient;
    private final String endpoint;
    private final String apiKey;
    private final ObjectMapper objectMapper;

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

        this.webClient = webClientBuilder.baseUrl(this.endpoint).build();
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
}
