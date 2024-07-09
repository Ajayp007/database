import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helper/db_helper.dart';

class EntryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  DbHelper helper = DbHelper();

  Rx<DateTime> changeDate = DateTime.now().obs;
  Rx<TimeOfDay> changeTime = TimeOfDay.now().obs;
  RxnString changeCategory = RxnString();

  Future<void> readExpenseIncome() async {
    categoryList.value = await helper.readCategoryDB();
  }

  void selectedData(DateTime date) {
    changeDate.value = date;
  }

  void selectedTime(TimeOfDay time) {
    changeTime.value = time;
  }

  void insertExpenseIncome(
      String name, String amount, String date, String time, int status) {
    helper.insertProductDB(
        name, amount, date, time, categoryList.string, status);
    readExpenseIncome();
  }
}
