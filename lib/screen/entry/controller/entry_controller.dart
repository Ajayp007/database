import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/helper/db_helper.dart';

class EntryController extends GetxController {
  RxList<Map> categoryList = <Map>[].obs;
  RxList<Map> transactionList = <Map>[].obs;

  DbHelper helper = DbHelper();

  Rx<DateTime> changeDate = DateTime.now().obs;
  Rx<TimeOfDay> changeTime = TimeOfDay.now().obs;
  RxnString changeCategory = RxnString();

  Future<void> readCategory() async {
    categoryList.value = await helper.readCategoryDB();

  }

  void selectedData(DateTime date) {
    changeDate.value = date;
  }

  void selectedTime(TimeOfDay time) {
    changeTime.value = time;
  }

  Future<void> transactionRead() async {
    transactionList.value = await helper.readProductDB();
  }

  void insertTransaction(String name, String amount, int status) {
    helper.insertProductDB(
        name,
        amount,
        "${changeDate.value.day}/${changeDate.value.month}/${changeDate.value.year}",
        "${changeTime.value.hour}:${changeTime.value.minute}",
        changeCategory.value!,
        status);
    transactionRead();
  }

  void deleteTransaction(int index) {
    helper.deleteProductDB(index);
    transactionRead();
  }

  void updateTransaction(String name, String amount, int status) {
    helper.updateProductDB(
        name,
        amount,
        "${changeDate.value.day}/${changeDate.value.month}/${changeDate.value.year}",
        "${changeTime.value.hour}:${changeTime.value.minute}",
        changeCategory.value!,
        status);
    transactionRead();
  }


}
