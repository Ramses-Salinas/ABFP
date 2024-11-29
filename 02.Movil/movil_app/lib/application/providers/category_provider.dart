import 'package:flutter/material.dart';

import '../../domain/Transaction/entities/category.dart';
import '../../domain/Transaction/value_objects/category_color.dart';
import '../../domain/Transaction/value_objects/category_icon.dart';
import '../../domain/Transaction/value_objects/category_name.dart';
import '../../infrastructure/repositories/category_repository.dart';

class CategoryProvider with ChangeNotifier {
  final CategoryRepository _categoryRepository = CategoryRepository();
  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryProvider() {
    loadCategories();
  }

  void loadCategories() {
    _isLoading = true;
    notifyListeners();

    _categories = _categoryRepository.getAllCategories();
    _isLoading = false;
    notifyListeners();
  }

  void addCategory(Category category) {
    _categoryRepository.addCategory(category);
    loadCategories();
  }

  Category getCategoryById(int categoryId) {
    return categories.firstWhere(
          (cat) => cat.id == categoryId,
      orElse: () => Category(
        id: 0,
        nombre: NombreCategoria('Desconocida'),
        icono: IconoCategoria(Icons.help),
        color: ColorCategoria(Colors.grey),
      ),
    );
  }

  Category getCategoryByName(String categoriaNombre) {
    return categories.firstWhere(
          (cat) => cat.nombre.value == categoriaNombre,
      orElse: () => Category(
        id: 0,
        nombre: NombreCategoria('Desconocida'),
        icono: IconoCategoria(Icons.help),
        color: ColorCategoria(Colors.grey),
      ),
    );
  }

  List<Category> getAllCategories(){
    return _categoryRepository.getAllCategories();
  }

}