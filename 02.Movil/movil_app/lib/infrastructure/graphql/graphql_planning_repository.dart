import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain/Transaction/entities/transaction.dart';
import '../repositories/planning_respository.dart';

class GraphQLPlanningRepository implements PlanningRepository {
  final dynamic client;

  GraphQLPlanningRepository({required this.client});

  void _clearCache() {
    client.cache.store.reset();
  }

  Future<List<Map<String, dynamic>>> _refetchTransacciones(String gmail) async {
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
        final List<Map<String, dynamic>> transacciones =
        (result.data?['listTransacciones'] as List<dynamic>)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
        return transacciones;
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
        await _refetchTransacciones(transaction.gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar la transacción: $e');
    }
  }

  @override
  Future<void> actualizarTransaccion(Transaction transaction) async {
    const mutation = '''
    mutation ActualizarTransaccion(
      \$gmail: String!,
      \$transaccion_id: Int!,
      \$categoria_transaccion: String,
      \$fecha: String,
      \$monto: Float,
      \$nota: String,
      \$tipo_moneda: String,
      \$tipo_transaccion: String
    ) {
      actualizarTransaccion(
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
      'tipo_moneda': transaction.tipoMoneda.name,
      'tipo_transaccion': transaction.tipoTransaccion.name,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error al actualizar la transacción: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Transacción actualizada exitosamente con ID: ${result.data!['actualizarTransaccion']['transaccion_id']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchTransacciones(transaction.gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar la solicitud de actualización: $e');
    }
  }

  @override
  Future<void> eliminarTransaccion(String gmail, int id) async {
    const mutation = '''
      mutation EliminarTransaccion(\$gmail: String!, \$transaccion_id: Int!) {
        eliminarTransaccion(gmail: \$gmail, transaccion_id: \$transaccion_id)
      }
    ''';

    final variables = {'gmail': gmail, 'transaccion_id': id};

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error al eliminar la transacción: ${result.exception.toString()}');
      } else {
        print('Transacción eliminada exitosamente');

        _clearCache();

        await _refetchTransacciones(gmail);
      }
    } catch (e) {
      print('Error al eliminar la transacción: $e');
    }
  }

  @override
  Future<List<Map<String, dynamic>>> obtenerTransacciones(String gmail) async {
    return await _refetchTransacciones(gmail);
  }
}
