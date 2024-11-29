import '../value_objects/amount.dart';
import '../value_objects/coin_type.dart';
import '../value_objects/date.dart';
import '../value_objects/transaction_type.dart';
import 'category.dart';


class Transaction {
  final int id;
  final String gmail;
  final Fecha fecha;
  final Monto monto;
  final Category categoria;
  final String? nota;
  final TipoMoneda tipoMoneda;
  final TipoTransaccion tipoTransaccion;

  Transaction({
    required this.id,
    required this.gmail,
    required this.fecha,
    required this.monto,
    required this.categoria,
    this.nota,
    required this.tipoMoneda,
    required this.tipoTransaccion,
  });

  @override
  String toString() {
    return 'Transaction(id: $id, gmail: $gmail, fecha: $fecha, monto: $monto, categoria: ${categoria.nombre}, tipoMoneda: $tipoMoneda, tipoTransaccion: $tipoTransaccion)';
  }

}