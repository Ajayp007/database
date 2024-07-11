import 'package:database/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  List<Map> liveSearchList = <Map>[];
  List<Map> allCategoryList = <Map>[];
  DbHelper helper = DbHelper();

  Future<void> readCategory() async {
    categoryList.value = await helper.readCategoryDB();
    allCategoryList = List.from(categoryList);
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

  void liveSearchCategory(String text) {
    categoryList.value = allCategoryList;
    liveSearchList.clear();
    for (var x in categoryList) {
      if (x['category'].contains(text)) {
        liveSearchList.add(x);
      }
      categoryList.value = List.from(liveSearchList);
    }
  }
}
