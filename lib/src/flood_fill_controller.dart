import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_floodfill_image/flutter_floodfill_image.dart';
import 'package:image/image.dart' as Img;

class FloodFillController {
  final List<Uint8List> _operations = List.empty(growable: true);
  late FloodFill floodFill;
  final Uint8List imageBytes;
  late Img.Image _image;
  late Offset scaleFactor = const Offset(1, 1);
  late Uint8List _currentBytes;

  get currentBytes => _currentBytes;

  ///[imageBytes] is Uint8List
  FloodFillController({required this.imageBytes}) {
    _currentBytes = imageBytes;
    _image = _currentBytes.toImage();
    addOperation(_currentBytes);
    floodFill = FloodFill(_image);
  }

  ///set scale factor to catch touch position accurately
  setScaleFactor(GlobalKey paintKey) {
    final parentSize = paintKey.currentContext?.size ??
        Size(_image.width.toDouble(), _image.height.toDouble());
    scaleFactor = Offset(
        (_image.width / parentSize.width), (_image.height / parentSize.height));
    print(scaleFactor);
  }

  /// add stuffs to operation stack
  void addOperation(Uint8List byte) {
    _operations.add(byte);
  }

  ///undo
  undoOperation() {
    //keep at least one item:original in history
    if (_operations.length < 2) return;
    _operations.removeLast();
    _currentBytes = _operations.last;
  }

  ///apply flood fill
  ///[offset] is the position of touch
  ///[fillColor] is color to fill
  ///[avoidColor] is color to avoid
  applyFloodFill(Offset offset, int fillColor, int avoidColor) {
    floodFill.queueFloodFill(
        offset.dx.toInt(), offset.dy.toInt(), fillColor, avoidColor);

    var output = floodFill.getBuffer;
    addOperation(output);
    _currentBytes = output;
  }
}
