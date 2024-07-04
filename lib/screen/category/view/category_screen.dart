import 'package:database/utils/helper/db_helper.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  TextEditingController txtCategory = TextEditingController();

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
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                DbHelper helper = DbHelper();
                helper.insertDB(txtCategory.text);
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
