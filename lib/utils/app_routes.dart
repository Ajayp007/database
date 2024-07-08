import 'package:database/screen/category/view/category_screen.dart';
import 'package:database/screen/entry/view/entry_screen.dart';
import 'package:database/screen/home/view/home_screen.dart';
import 'package:flutter/material.dart';

Map<String,WidgetBuilder> appRoutes ={
  '/':(context) => const HomeScreen(),
  'cate':(context) => const CategoryScreen(),
  'entry':(context) => const EntryScreen(),
};