import 'package:graphql_flutter/graphql_flutter.dart';
import '../repositories/planning_respository.dart';

class GraphQLPlanningRepository implements PlanningRepository {
  final dynamic client;

  GraphQLPlanningRepository({required this.client});

  void _clearCache() {
    client.cache.store.reset();
  }

  Future<Map<String, dynamic>> _refetchPresupuesto(String gmail) async {
    const query = '''
    query ListPresupuesto(\$gmail: String!) {
      listpresupuesto(gmail: \$gmail) {
        Gmail
        Meta_ahorro
        Balanza_actual_real
        Sugerencia
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
        throw Exception('Error al obtener el presupuesto: ${result.exception.toString()}');
      } else if (result.data != null) {
        print("presupuesto:${result.data}");
        final List<dynamic> presupuestoList = result.data!['listpresupuesto'];
        final Map<String, dynamic> presupuestoData = presupuestoList.first as Map<String, dynamic>;
        print("Presupuesto obtenido: $presupuestoData");
        return presupuestoData;
      } else {
        throw Exception('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      throw Exception('Error al ejecutar el query: $e');
    }
  }

  Future<Map<String, dynamic>> _refetchPreCat(String gmail) async {
    const query = '''
    query ListPresCat(\$Gmail: String!, \$Id_categoria: Int) {
      listPrecat(Gmail: \$Gmail, Id_categoria: \$Id_categoria) {
        Gmail
        Id_categoria
        Categoria_mensual
        Categoria_semestral
        Categoria_anual
      }
    }
    ''';

    final variables = {'Gmail': gmail, 'Id_categoria': 0,};

    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw Exception('Error al obtener el precat: ${result.exception.toString()}');
      } else if (result.data != null) {
        print("precat:${result.data}");
        final List<dynamic> precatList = result.data!['listPrecat'];
        final Map<String, dynamic> precatData = precatList
            .cast<Map<String, dynamic>>()
            .firstWhere(
              (item) => item['Id_categoria'] == 0,
          orElse: () => throw Exception('No se encontró el precat con Id_categoria: 0'),
        );        print("Precat obtenido: $precatData");
        return precatData;
      } else {
        throw Exception('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      throw Exception('Error al ejecutar el query: $e');
    }
  }


  @override
  Future<void> crearPresupuesto(String gmail) async {
    const mutation = '''
    mutation CrearPresupuesto(
      \$Gmail: String!,
      \$Tipo_presupuesto: String!,
      \$Gasto_estimado: Int,
      \$Meta_ahorro: Int,
      \$Monto_presupuesto: Int,
      \$Sugerencia: String,
      \$Ingreso_Presupuestado: Int,
      \$Ingreso_realMes: Int,
      \$Gasto_Presupuestado: Int,
      \$Balanza_final_presupuestadaMes: Int,
      \$Balanza_actual_real: Int,
    ) {
      crearPresupuesto(
        Gmail: \$Gmail,
        Tipo_presupuesto: \$Tipo_presupuesto,
        Gasto_estimado: \$Gasto_estimado,
        Meta_ahorro: \$Meta_ahorro,
        Monto_presupuesto: \$Monto_presupuesto,
        Sugerencia: \$Sugerencia,
        Ingreso_Presupuestado: \$Ingreso_Presupuestado,
        Ingreso_realMes: \$Ingreso_realMes,
        Gasto_Presupuestado: \$Gasto_Presupuestado,
        Balanza_final_presupuestadaMes: \$Balanza_final_presupuestadaMes,
        Balanza_actual_real: \$Balanza_actual_real,
      ) {
        Tipo_presupuesto
      }
    }
    ''';


    final variables = {
      'Gmail': gmail,
      'Tipo_presupuesto': "Mensual",
      'Gasto_estimado': 0,
      'Meta_ahorro': 0,
      'Monto_presupuesto': 0,
      'Sugerencia': "",
      'Ingreso_Presupuestado': 0,
      'Ingreso_realMes': 0,
      'Gasto_Presupuestado': 0,
      'Balanza_final_presupuestadaMes': 0,
      'Balanza_actual_real': 0,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error en el presupeusto: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Presupuesto creada exitosamente con ID: ${result.data!['crearPresupuesto']['Tipo_presupuesto']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchPresupuesto(gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar el presupuesto: $e');
    }
  }

  @override
  Future<void> crearPreCat(String gmail) async {
    const mutation = '''
    mutation CrearPreCat(
      \$Gmail: String!,
      \$Id_categoria: Int!,
      \$Nombre_categoria: String!,
      \$Categoria_mensual: Int,
      \$Categoria_semestral: Int,
      \$Categoria_anual: Int,

    ) {
      crearPreCat(
        Gmail: \$Gmail,
        Id_categoria: \$Id_categoria,
        Nombre_categoria: \$Nombre_categoria,
        Categoria_mensual: \$Categoria_mensual,
        Categoria_semestral: \$Categoria_semestral,
        Categoria_anual: \$Categoria_anual,
      ) {
        Gmail
      }
    }
    ''';


    final variables = {
      'Gmail': gmail,
      'Id_categoria': 0,
      'Nombre_categoria': "General",
      'Categoria_mensual': 0,
      'Categoria_semestral': 0,
      'Categoria_anual': 0,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error en el presupuesto Categoría: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Presupuesto creada exitosamente con ID: ${result.data!['crearPreCat']['Gmail']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchPresupuesto(gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar el presupuesto: $e');
    }
  }

  @override
  Future<void> actualizarMetaAhorro(String gmail, double nuevaMeta) async {
    const mutation = '''
    mutation ActualizarPresupuesto(
      \$Gmail: String!,
      \$Tipo_presupuesto: String!,
      \$Meta_ahorro: Int,
    ) {
      actualizarPresupuesto(
        Gmail: \$Gmail,
        Tipo_presupuesto: \$Tipo_presupuesto,
        Meta_ahorro: \$Meta_ahorro,

      ) {
        Tipo_presupuesto
      }
    }
    ''';


    final variables = {
      'Gmail': gmail,
      'Tipo_presupuesto': "Mensual",
      'Meta_ahorro': nuevaMeta.toInt(),

    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error al actualizar el Presupuesto: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Transacción actualizada exitosamente con ID: ${result.data!['actualizarPresupuesto']['Tipo_presupuesto']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchPresupuesto(gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar la solicitud de actualización: $e');
    }
  }

  @override
  Future<void> actualizarPresupuestoPlazo(String gmail, double nuevaMeta, String plazo) async {
    // Variable para guardar la mutación específica según el plazo
    String mutation;

    // Variables comunes
    final variables = {
      'Gmail': gmail,
      'Id_categoria': 0,
    };

    switch (plazo) {
      case 'Corto plazo':
        mutation = '''
        mutation ActualizarPrecat(
          \$Gmail: String!,
          \$Id_categoria: Int!,
          \$Categoria_mensual: Int
        ) {
          actualizarPrecat(
            Gmail: \$Gmail,
            Id_categoria: \$Id_categoria,
            Categoria_mensual: \$Categoria_mensual
          ) {
            Id_categoria
          }
        }
      ''';
        variables['Categoria_mensual'] = nuevaMeta.toInt();
        break;

      case 'Mediano plazo':
        mutation = '''
        mutation ActualizarPrecat(
          \$Gmail: String!,
          \$Id_categoria: Int!,
          \$Categoria_semestral: Int
        ) {
          actualizarPrecat(
            Gmail: \$Gmail,
            Id_categoria: \$Id_categoria,
            Categoria_semestral: \$Categoria_semestral
          ) {
            Id_categoria
          }
        }
      ''';
        variables['Categoria_semestral'] = nuevaMeta.toInt();
        break;

      case 'Largo plazo':
        mutation = '''
        mutation ActualizarPrecat(
          \$Gmail: String!,
          \$Id_categoria: Int!,
          \$Categoria_anual: Int
        ) {
          actualizarPrecat(
            Gmail: \$Gmail,
            Id_categoria: \$Id_categoria,
            Categoria_anual: \$Categoria_anual
          ) {
            Id_categoria
          }
        }
      ''';
        variables['Categoria_anual'] = nuevaMeta.toInt();
        break;

      default:
        print('Plazo no reconocido: $plazo');
        return;
    }

    // Ejecución de la mutación
    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error al actualizar el Precat: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Precat actualizada exitosamente con ID: ${result.data!['actualizarPrecat']['Id_categoria']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchPresupuesto(gmail);
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

        await _refetchPresupuesto(gmail);
      }
    } catch (e) {
      print('Error al eliminar la transacción: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerPresupuesto(String gmail) async {
    return await _refetchPresupuesto(gmail);
  }

  @override
  Future<Map<String, dynamic>> obtenerPreCat(String gmail) async {
    return await _refetchPreCat(gmail);

  }
}
