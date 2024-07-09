import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/helper/db_helper.dart';

class EntryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  DbHelper helper = DbHelper();
  DateTime changeDate = DateTime.now();
  TimeOfDay changeTime = TimeOfDay.now();

  Future<void> readExpenseIncome() async {
    categoryList.value = await helper.readCategoryDB();
  }

  void selectedData(DateTime date) {
    changeDate = date;
  }

  void selectedTime(TimeOfDay time) {
    changeTime = time;
  }

  void insertExpenseIncome(
      String name, String amount, String date, String time, int status) {
    helper.insertProductDB(
        name, amount, date, time, categoryList.string, status);
    readExpenseIncome();
  }
}
