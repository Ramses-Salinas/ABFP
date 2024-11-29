import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

import '../../domain/user_management/entities/user.dart';
import '../repositories/user_repository.dart';


class GraphQLUserRepository implements UserRepository {
  final dynamic client;

  GraphQLUserRepository({required this.client});

  void _clearCache() {
    client.cache.store.reset();
  }

  Future<Map<String, dynamic>> _refetchUsuario(String gmail) async {
    const query = '''
    query getUsuario(\$Gmail: String!) {
      getUsuario(Gmail: \$Gmail) {
        Nombre
        Gmail
        Pasword
      }
    }
    ''';

    final variables = {'Gmail': gmail};

    try {
      final QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
        fetchPolicy: FetchPolicy.networkOnly,
      );

      final QueryResult result = await client.query(options);

      print("Result: ${result.data}");

      if (result.hasException) {
        throw Exception('Error al obtener el usuario: ${result.exception.toString()}');
      } else if (result.data != null && result.data!['getUsuario'] != null) {
        final Map<String, dynamic> usuarioData = result.data!['getUsuario'];
        print("Usuario obtenido: $usuarioData");
        return usuarioData;
      } else {
        throw Exception('No se encontró el usuario con el correo proporcionado.');
      }
    } catch (e) {
      throw Exception('Error al ejecutar el query: $e');
    }
  }


  @override
  Future<void> crearUsuario(User user) async {
    const mutation = '''
    mutation CrearUsuario(
      \$Gmail: String!,
      \$Nombre: String!,
      \$Pasword: String!,
    ) {
      crearUsuario(
        Gmail: \$Gmail,
        Nombre: \$Nombre,
        Pasword: \$Pasword,
      ) {
        Gmail
      }
    }
    ''';


    final variables = {
      'Gmail': user.gmail,
      'Nombre': user.nombre,
      'Pasword': user.contrasenia,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error en el registro: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Usuario creada exitosamente con gmail: ${result.data!['crearUsuario']['Gmail']}');

        _clearCache();

        await _refetchUsuario(user.gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar el usuario: $e');
    }
  }

  @override
  Future<void> actualizarUsuario(User user) async {
    const mutation = '''
    mutation ActualizarUsuario(
      \$gmail: String!,
      \$nombre: String,
      \$password: String,
    ) {
      actualizarUsuario(
        gmail: \$gmail,
        nombre: \$nombre,
        password: \$password,
      ) {
        gmail
      }
    }
    ''';


    final variables = {
      'gmail': user.gmail,
      'nombre': user.nombre,
      'password': user.contrasenia,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        print('Error al actualizar el usuario: ${result.exception.toString()}');
      } else if (result.data != null) {
        print('Usuario actualizada exitosamente con gmail: ${result.data!['actualizarUsuario']['gmail']}');

        // Limpiar caché después de la mutación
        _clearCache();

        // Refrescar los datos después de la mutación
        await _refetchUsuario(user.gmail);
      } else {
        print('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      print('Error al enviar la solicitud de actualización: $e');
    }
  }

  @override
  Future<void> eliminarUsuario(String gmail, int id) async {
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

        await _refetchUsuario(gmail);
      }
    } catch (e) {
      print('Error al eliminar la transacción: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> obtenerUsuario(String gmail) async {
    return await _refetchUsuario(gmail);
  }


  @override
  Future<Map<String, dynamic>> autenticarUsuario(String gmail, String password) async {
    const mutation = '''
    mutation AutenticarUsuario(\$Gmail: String!, \$Pasword: String!) {
      autenticarUsuario(Gmail: \$Gmail, Pasword: \$Pasword) {
        Gmail
        Nombre
        Pasword
      }
    }
    ''';

    final variables = {
      'Gmail': gmail,
      'Pasword': password,
    };

    try {
      final MutationOptions options = MutationOptions(
        document: gql(mutation),
        variables: variables,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw Exception('Error al autenticar usuario: ${result.exception.toString()}');
      } else if (result.data != null) {
        final usuario = result.data!['autenticarUsuario'];
        if (usuario != null) {
          return Map<String, dynamic>.from(usuario);
        } else {
          throw Exception('Credenciales incorrectas o usuario no encontrado.');
        }
      } else {
        throw Exception('Error desconocido. Sin datos ni excepciones.');
      }
    } catch (e) {
      throw Exception('Error al autenticar usuario: $e');
    }
  }


}
