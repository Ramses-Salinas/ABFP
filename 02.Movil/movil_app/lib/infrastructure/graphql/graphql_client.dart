import 'package:graphql_flutter/graphql_flutter.dart';
import '../../../config/config.dart';

class GraphQLClientProvider {
  static final HttpLink _httpLink = HttpLink(
    AWSConfig.graphqlEndpoint,
    defaultHeaders: {
      'x-api-key': AWSConfig.apiKey,
    },
  );

  static final GraphQLClient client = GraphQLClient(
    link: _httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  );

  static GraphQLClient getClient() {
    return client;
  }

  static void clearCache() {
    client.cache.store.reset();
  }
}
