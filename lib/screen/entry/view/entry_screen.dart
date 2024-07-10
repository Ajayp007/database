import 'package:database/screen/entry/controller/entry_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  EntryController controller = Get.put(EntryController());
  TextEditingController txtSubject = TextEditingController();
  TextEditingController txtAmount = TextEditingController();

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          "Transaction",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          (Icons.notification_add_outlined),
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 550,
                    width: MediaQuery.sizeOf(context).width,
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            blurRadius: 7,
                            //offset: const Offset(4, 4),
                          )
                        ],
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          width: MediaQuery.sizeOf(context).width,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          child: const Text(
                            "Income/Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Text(
                                "Subject",
                                style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                ":",
                                style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: txtSubject,
                                  decoration: const InputDecoration(
                                    label: Text("Enter Your Description"),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              const Text(
                                "Amount",
                                style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              const Text(
                                ":",
                                style:
                                TextStyle(color: Colors.black54, fontSize: 17),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Flexible(
                                child: TextField(
                                  controller: txtAmount,
                                  decoration:
                                  const InputDecoration(label: Text("Amount")),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text(
                            "Date/Time",
                            style: TextStyle(color: Colors.black54, fontSize: 17),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
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
                        const SizedBox(
                          height: 20,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                controller.insertTransaction(
                                    txtSubject.text, txtAmount.text, 1);
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
                                  "Income",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.insertTransaction(
                                    txtSubject.text, txtAmount.text, 0);
                              },
                              child: Container(
                                height: 40,
                                alignment: Alignment.center,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  "Expense",
                                  style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
