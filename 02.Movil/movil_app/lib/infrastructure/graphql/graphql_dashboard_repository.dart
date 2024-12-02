import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain/Transaction/entities/transaction.dart';
import '../repositories/dashboard_repository.dart';

class GraphQLDashboardRepository implements DashboardRepository {
  final dynamic client;

  GraphQLDashboardRepository({required this.client});

  void _clearCache() {
    client.cache.store.reset();
  }

  Future<Map<String, dynamic>> _refetchDashboard(String gmail) async {
    const query = '''
    query listTransacciones(\$gmail: String!) {
      listTransacciones(gmail: \$gmail) {
        gmail
        transaccion_id
        categoria_transaccion
        fecha
        monto
        nota
        tipo_moneda
        tipo_transaccion
      }
    }
    ''';

    final variables = {'gmail': gmail};

    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw Exception('Error al obtener transacciones: ${result.exception.toString()}');
      } else if (result.data != null) {
        final Map<String, dynamic> usuarioData = result.data!['getUsuario'];
        print("Usuario obtenido: $usuarioData");
        return usuarioData;
      } else {
        throw Exception('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      throw Exception('Error al ejecutar el query: $e');
    }
  }

  @override
  Future<void> crearTransaccion(Transaction transaction) async {
    const mutation = '''
    mutation CrearTransaccion(
      \$gmail: String!,
      \$transaccion_id: Int!,
      \$categoria_transaccion: String,
      \$fecha: String,
      \$monto: Float,
      \$nota: String,
      \$tipo_moneda: String,
      \$tipo_transaccion: String
    ) {
      crearTransaccion(
        gmail: \$gmail,
        transaccion_id: \$transaccion_id,
        categoria_transaccion: \$categoria_transaccion,
        fecha: \$fecha,
        monto: \$monto,
        nota: \$nota,
        tipo_moneda: \$tipo_moneda,
        tipo_transaccion: \$tipo_transaccion
      ) {
        transaccion_id
      }
    }
    ''';

    final formattedDate = DateFormat('yyyy-MM-dd').format(transaction.fecha.value);

    final variables = {
      'gmail': transaction.gmail,
      'transaccion_id': transaction.id.toInt(),
      'categoria_transaccion': transaction.categoria.nombre.value,
      'fecha': formattedDate.toString(),
      'monto': transaction.monto.value,
      'nota': transaction.nota!.isEmpty ? "--" : transaction.nota,
      'tipo_moneda': transaction.tipoMoneda.name ,
      'tipo_transaccion': transaction.tipoTransaccion.name,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error en la transacción: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Transacción creada exitosamente con ID: ${result.data!['crearTransaccion']['transaccion_id']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchDashboard(transaction.gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar la transacción: $e');
    }
  }


  @override
  Future<Map<String, dynamic>> obtenerDashboard(String gmail) async {
    return await _refetchDashboard(gmail);
  }
}
