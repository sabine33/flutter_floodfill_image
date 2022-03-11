import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

extension ToInt32 on List<int> {
  toInt32() {
    int output = this[3] << 24 | this[2] << 16 | this[1] << 8 | this[0];
    return output;
  }
}

extension ToInt8 on int {
  List<int> toInt8() {
    int red = this >> 0xff;
    int green = (this >> 8) & 0xff;
    int blue = (this >> 16) & 0xff;
    int alpha = (this >> 24) & 0xff;
    return [red, green, blue, alpha];
  }
}

extension ImageArray on Image {
  Uint8List toInt8List() {
    return Uint8List.fromList(encodePng(this));
  }

  toFile(String filename, Image image) {
    File(filename).writeAsBytesSync(encodePng(image));
  }
}

extension ToImage on Uint8List {
  Image toImage() {
    return decodeImage(this)!;
  }
}
