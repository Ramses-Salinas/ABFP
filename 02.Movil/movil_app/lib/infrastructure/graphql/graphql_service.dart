import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphql_client.dart';

class GraphQLService {
  final GraphQLClient _client = GraphQLClientProvider.getClient();

  Future<QueryResult> performQuery(String query, {Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await _client.query(options);
  }

  Future<QueryResult> performMutation(String mutation, {Map<String, dynamic>? variables}) async {
    final MutationOptions options = MutationOptions(
      document: gql(mutation),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.noCache,
      onCompleted: (data) {
        GraphQLClientProvider.clearCache();
      },
    );
    return await _client.mutate(options);
  }

  Future<QueryResult> refetchData(String query, {Map<String, dynamic>? variables}) async {
    final QueryOptions options = QueryOptions(
      document: gql(query),
      variables: variables ?? {},
      fetchPolicy: FetchPolicy.networkOnly,
    );
    return await _client.query(options);
  }
}
