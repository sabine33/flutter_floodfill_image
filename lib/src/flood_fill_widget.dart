import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_floodfill_image/flutter_floodfill_image.dart';
import 'package:image/image.dart' as Img;
import 'flood_fill_controller.dart';

const blackColor = 4278190090;

class FloodFillWidget extends StatefulWidget {
  final int fillColor;
  final int avoidColor;
  final FloodFillController controller;

  const FloodFillWidget({
    Key? key,
    required this.fillColor,
    this.avoidColor = blackColor,
    required this.controller,
  }) : super(key: key);

  @override
  State<FloodFillWidget> createState() => _FloodFillWidgetState();
}

class _FloodFillWidgetState extends State<FloodFillWidget> {
  GlobalKey paintKey = GlobalKey();
  late Img.Image image;
  late Uint8List renderBytes = widget.controller.imageBytes;
  late FloodFill floodfill;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!mounted) return const CircularProgressIndicator();
    return RepaintBoundary(
        key: paintKey,
        child: GestureDetector(
          onTapDown: (d) async {
            Offset offset = d.localPosition;
            widget.controller.setScaleFactor(paintKey);
            widget.controller
                .applyFloodFill(offset, widget.fillColor, widget.avoidColor);
            setState(() {});
          },
          child: Image.memory(
            widget.controller.currentBytes,
            isAntiAlias: true,
            gaplessPlayback: true,
            fit: BoxFit.fill,
          ),
        ));
  }
}
