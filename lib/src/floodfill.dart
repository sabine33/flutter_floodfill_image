import 'dart:collection';
import 'dart:typed_data';
import 'package:image/image.dart';

class FloodFill {
  Image image;
  FloodFill(this.image);

  Image get getImage => image;

  Uint8List get getBuffer => Uint8List.fromList(encodePng(image));

  ///[image] an Image object
  ///[x] and [y] are pixel positions to start fill.
  ///[newColor] is the int32 rgba color.
  ///use toInt8 to convert int32 to List of r,g,b,a values
  queueFloodFill(int x, int y, int newColor, int avoidColor) {
    int srcColor = image.getPixel(x, y);
    if (srcColor == avoidColor) {
      return;
    }
    List<List<bool>> hits = List.generate(
        image.height, (index) => List.generate(image.width, (index) => false));

    Queue<Point> queue = Queue<Point>();
    queue.add(Point(x, y));

    while (queue.isNotEmpty) {
      // print("NOT EMPTY");
      Point p = queue.removeFirst();

      if (_lineFill(
          image, hits, p.x.toInt(), p.y.toInt(), srcColor, newColor)) {
        queue.add(Point(p.x, p.y - 1));
        queue.add(Point(p.x, p.y + 1));
        queue.add(Point(p.x - 1, p.y));
        queue.add(Point(p.x + 1, p.y));
      }
    }
    // print("DONE");
  }

  bool _lineFill(Image image, List<List<bool>> hits, int x, int y, int srcColor,
      int targetColor) {
    ///[x] and [y] must not be negative
    ///[x] and [y] must not be larger than image size
    if (y < 0 || x < 0 || y > image.height - 1 || x > image.width - 1) {
      return false;
    }

    ///if [hits] already contains -> return
    if (hits[y][x]) return false;

    ///if given pixel not equals to source color: return
    if (image.getPixel(x, y) != srcColor) {
      return false;
    }

    ///else fill pixel with target color
    image.setPixel(x, y, targetColor);

    ///assign hit
    hits[y][x] = true;

    return true;
  }
}
