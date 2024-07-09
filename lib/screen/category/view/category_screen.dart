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
  CategoryController controller = Get.put(CategoryController());

  @override
  void initState() {
    super.initState();
    controller.readCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: txtCategory,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Category"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if (txtCategory.text.isNotEmpty) {
                  controller.insertCategory(txtCategory.text);
                }
              },
              child: const Text("Submit"),
            ),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.categoryList.length,
                  itemBuilder: (context, index) {
                    return ExpansionTile(
                      title:
                          Text("${controller.categoryList[index]['category']}"),
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                updateCategory(index);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteCategory(
                                  controller.categoryList[index]['id'],
                                );
                              },
                              icon: const Icon(Icons.delete_outline),
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
