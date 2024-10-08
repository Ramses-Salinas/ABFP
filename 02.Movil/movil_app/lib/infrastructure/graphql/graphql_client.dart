import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientManager {
  static final HttpLink httpLink = HttpLink('https://example.com/graphql');

  static ValueNotifier<GraphQLClient> initClient() {
    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer <Your-Token>',
    );

    Link link = authLink.concat(httpLink);

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: link,
    );

    return ValueNotifier(client);
  }

  static Future<QueryResult> runQuery(String query, {Map<String, dynamic>? variables}) async {
    final client = GraphQLClientManager.initClient().value;
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
    );
    return await client.query(options);
  }

  static Future<QueryResult> runMutation(String mutation, {Map<String, dynamic>? variables}) async {
    final client = GraphQLClientManager.initClient().value;
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
    );
    return await client.mutate(options);
  }
}
