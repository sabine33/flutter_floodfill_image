import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_floodfill_image/flutter_floodfill_image.dart';

void main() {
  runApp(const MaterialApp(home: FloodFillApp()));
}

class FloodFillApp extends StatefulWidget {
  const FloodFillApp({Key? key}) : super(key: key);

  @override
  State<FloodFillApp> createState() => _FloodFillAppState();
}

class _FloodFillAppState extends State<FloodFillApp> {
  GlobalKey containerKey = GlobalKey();
  FloodFillController? controller;
  int fillColor = [255, 0, 0, 255].toInt32();

  Future<Uint8List> loadImageFromAssets(String filename) async {
    var bytes = (await rootBundle.load(filename)).buffer.asUint8List();
    return bytes;
  }

  @override
  void initState() {
    super.initState();
    loadImageFromAssets('assets/images/11.png').then((value) {
      setState(() {
        controller = FloodFillController(imageBytes: value);
      });
    });
  }

  final colorsList = [...Colors.primaries.toList(), Colors.black, Colors.white];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  controller?.undoOperation();

                  setState(() {});
                },
                icon: const Icon(Icons.undo))
          ],
        ),
        body: Column(
          children: [
            Wrap(
              runSpacing: 4,
              children: [
                ...colorsList
                    .map((color) => Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                fillColor = [
                                  color.red,
                                  color.green,
                                  color.blue,
                                  color.alpha
                                ].toInt32();
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: color,
                              radius: 20,
                            ),
                          ),
                        ))
                    .toList()
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: controller == null
                  ? Image.asset("assets/images/flower.png")
                  : FloodFillWidget(
                      key: UniqueKey(),
                      fillColor: fillColor,
                      controller: controller!,
                    ),
            ),
          ],
        ));
  }
}
