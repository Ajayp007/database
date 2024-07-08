import 'package:database/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  DbHelper helper = DbHelper();

  Future<void> readCategory() async {
    categoryList.value = await helper.readCategoryDB();
  }

  void insertCategory(String name) {
    helper.insertCategoryDB(name);
    readCategory();
  }

  void updateCategory(String name, int index) {
    helper.updateCategoryDB(name, index);
    readCategory();
  }

  void deleteCategory(int index) {
    helper.deleteCategoryDB(index);
    readCategory();
  }
}
