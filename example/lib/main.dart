import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  int x = 100;
  int y = 100;

  runApp(FloodFillApp());
}

class FloodFillApp extends StatefulWidget {
  FloodFillApp({Key? key}) : super(key: key);

  @override
  State<FloodFillApp> createState() => FloodFillAppState();
}

class FloodFillAppState extends State<FloodFillApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
          children: [CupertinoButton(onPressed: () {}, child: Text("Hey"))]),
    ));
  }
}
