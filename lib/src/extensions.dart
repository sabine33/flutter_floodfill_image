import 'dart:io';
import 'dart:typed_data';

import 'package:image/image.dart';

extension ToInt32 on List<int> {
  ///converts 8 bit integer list [r,g,b,a] to 32 bit int color
  int toInt32() {
    int output = this[3] << 24 | this[2] << 16 | this[1] << 8 | this[0];
    return output;
  }
}

extension ToInt8 on int {
  ///convwers 32 bit color to [r,g,b,a] 8 bit color values
  List<int> toInt8() {
    int red = this >> 0xff;
    int green = (this >> 8) & 0xff;
    int blue = (this >> 16) & 0xff;
    int alpha = (this >> 24) & 0xff;
    return [red, green, blue, alpha];
  }
}

extension ImageArray on Image {
  ///encodes  Uint8List to PNG Image
  Uint8List toInt8List() {
    return Uint8List.fromList(encodePng(this));
  }

  ///writes [Image] to file
  toFile(String filename) {
    File(filename).writeAsBytesSync(encodePng(this));
  }

  ///convolute [Image] using given filter
  convolute(List<num> filter) {
    assert(filter.length == 9);
    return convolution(this, filter);
  }
}

extension ToImage on Uint8List {
  ///converts Uint8List to PNG Image
  Image toImage() {
    return decodePng(this)!;
  }
}
