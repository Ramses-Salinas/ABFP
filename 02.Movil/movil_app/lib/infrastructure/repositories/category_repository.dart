import '../../domain/Transaction/entities/category.dart';
import '../graphql/local_database.dart';

class CategoryRepository {
  final LocalDatabase _localDatabase = LocalDatabase.instance;

  List<Category> getAllCategories() {
    return _localDatabase.getAllCategories();
  }

  void addCategory(Category category) {
    _localDatabase.addCategory(category);
  }
}
