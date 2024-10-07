import 'package:financial_app/domain/Transaction/value_objects/category_icon.dart';
import 'package:financial_app/domain/Transaction/value_objects/category_name.dart';
import '../value_objects/category_color.dart';

class Category {
  final int id;
  final NombreCategoria nombre;
  final IconoCategoria icono;
  final ColorCategoria color;

  Category({
    required this.id,
    required this.nombre,
    required this.icono,
    required this.color,
  });


  @override
  String toString() {
    return 'Category(id: $id, nombre: ${nombre.value}, icono: ${icono.value}, color: ${color.value})';
  }
}