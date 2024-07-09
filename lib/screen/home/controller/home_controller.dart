import 'package:database/utils/helper/db_helper.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxList<Map> incomeExpenseList = <Map>[].obs;

  DbHelper helper = DbHelper();

  Future<void> readIncomeExpense() async {
    helper.readProductDB();
  }
}
