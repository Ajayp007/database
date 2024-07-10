import 'package:database/screen/category/controller/category_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController txtCategory = TextEditingController();
  TextEditingController txtUpdate = TextEditingController();
  TextEditingController txtSearch = TextEditingController();
  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    controller.readCategory();
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
          Padding(
            padding: const EdgeInsets.only(top: 40, left: 10, right: 20),
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
                  "Category",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Icon(
                  (Icons.notification_add_outlined),
                  color: Colors.black,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100, left: 10, right: 10),
            child: Column(
              children: [
                TextField(
                  controller: txtCategory,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    label: Text("Category"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (txtCategory.text.isNotEmpty) {
                      controller.insertCategory(txtCategory.text);
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 120,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.redAccent.shade200,
                          Colors.blueAccent.shade200
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade700,
                          blurRadius: 1,
                        ),
                      ],
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SearchBar(
                  backgroundColor: const WidgetStatePropertyAll(Colors.white),
                  controller: txtSearch,
                  shadowColor: const WidgetStatePropertyAll(Colors.white),
                  hintText: "Search",
                  trailing: [
                    IconButton(
                      onPressed: () {
                        controller.liveSearchCategory(txtSearch.text);
                      },
                      icon: const Icon(Icons.search),
                    ),
                  ],
                  onChanged: (value) {
                    controller.liveSearchCategory(value);
                  },
                ),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          collapsedIconColor: Colors.black,
                          title: Text(
                            "${controller.categoryList[index]['category']}",
                            style: const TextStyle(color: Colors.black),
                          ),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    updateCategory(index);
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.black,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.deleteCategory(
                                      controller.categoryList[index]['id'],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete_outline,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateCategory(int index) {
    txtUpdate.text = controller.categoryList[index]['category'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update"),
          actions: [
            TextField(
              controller: txtUpdate,
            ),
            TextButton(
              onPressed: () {
                controller.updateCategory(
                    txtUpdate.text, controller.categoryList[index]['id']);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
