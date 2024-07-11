import 'package:database/screen/entry/controller/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EntryController controller = Get.put(EntryController());
  TextEditingController txtUpdateName = TextEditingController();
  TextEditingController txtUpdateAmount = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.readCategory();
    controller.transactionRead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/iPhone.png",
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 10, right: 10),
                child: Row(
                  children: [
                    const Icon(Icons.menu),
                    const SizedBox(
                      width: 140,
                    ),
                    const Text(
                      "Dashboard",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'cate');
                      },
                      icon: const Icon(
                        Icons.category,
                        color: Colors.black,
                      ),
                    ),
                    PopupMenuButton(
                      iconColor: Colors.black,
                      color: Colors.transparent,
                      shadowColor: Colors.white,
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () => controller.filterTransaction("all"),
                            child: const Text("All"),
                          ),
                          PopupMenuItem(
                            onTap: () => controller.filterTransaction("income"),
                            child: const Text("Income"),
                          ),
                          PopupMenuItem(
                            onTap: () =>
                                controller.filterTransaction("expense"),
                            child: const Text("Expense"),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.transactionList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.sizeOf(context).width,
                        margin: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              blurRadius: 7,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: ExpansionTile(
                          title: Text(
                            "${controller.transactionList[index]['name']}",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.transactionList[index]
                                            ['status'] ==
                                        0
                                    ? Colors.blue
                                    : Colors.red),
                          ),
                          subtitle: Text(
                              "${controller.transactionList[index]['date']}  ${controller.transactionList[index]['time']}"),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Rs.${controller.transactionList[index]['amount']}",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: controller.transactionList[index]
                                                    ['status'] ==
                                                0
                                            ? Colors.blue
                                            : Colors.red),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () {
                                      updateTransaction(index);
                                    },
                                    icon: const Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.deleteTransaction(controller
                                          .transactionList[index]['id']);
                                    },
                                    icon: const Icon(Icons.delete_outline),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black87,
        onPressed: () {
          Get.toNamed('entry');
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void updateTransaction(int index) {
    txtUpdateName.text = controller.transactionList[index]['name'];
    txtUpdateAmount.text = controller.transactionList[index]['amount'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: txtUpdateName,
                ),
                TextField(
                  controller: txtUpdateAmount,
                ),
                Row(
                  children: [
                    const Text(
                      "Date/Time",
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                    ),
                    const Text(
                      ":",
                      style: TextStyle(color: Colors.black54, fontSize: 17),
                    ),
                    Obx(
                      () => TextButton.icon(
                        onPressed: () async {
                          DateTime? d1 = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2050),
                          );
                          if (d1 != null) {
                            controller.selectedData(d1);
                          }
                        },
                        label: Text(
                          "${controller.changeDate.value.day}/${controller.changeDate.value.month}/${controller.changeDate.value.year}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Obx(
                      () => TextButton.icon(
                        onPressed: () async {
                          TimeOfDay? t1 = await showTimePicker(
                              context: context,
                              initialTime: controller.changeTime.value);
                          if (t1 != null) {
                            controller.selectedTime(t1);
                          }
                        },
                        label: Text(
                          "${controller.changeTime.value.hour}:${controller.changeTime.value.minute}",
                          style: const TextStyle(color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.watch_later_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Select Category",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(20),
                    child: DropdownButton(
                      hint: const Text("Category"),
                      value: controller.changeCategory.value,
                      isExpanded: true,
                      items: controller.categoryList
                          .map(
                            (e) => DropdownMenuItem(
                              value: "${e['category']}",
                              child: Text("${e['category']}"),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.changeCategory.value = value as String;
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.updateTransaction(
                            txtUpdateName.text, txtUpdateAmount.text, 1);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Income",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.updateTransaction(
                            txtUpdateName.text, txtUpdateAmount.text, 0);
                      },
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Expense",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
