import 'dart:collection';
import 'dart:io';
import 'package:image/image.dart';

class FloodFill {
  Image image;
  FloodFill(this.image);

  Image get getImage => image;

  void queueFloodFill(Image image, int x, int y, int newColor) {
    int srcColor = image.getPixel(x, y);
    List<List<bool>> hits = List.generate(
        image.height, (index) => List.generate(image.width, (index) => false));

    Queue<Point> queue = Queue<Point>();
    queue.add(Point(x, y));

    while (queue.isNotEmpty) {
      Point p = queue.removeFirst();

      if (lineFill(image, hits, p.x.toInt(), p.y.toInt(), srcColor, newColor)) {
        queue.add(Point(p.x, p.y - 1));
        queue.add(Point(p.x, p.y + 1));
        queue.add(Point(p.x - 1, p.y));
        queue.add(Point(p.x + 1, p.y));
      }
    }
  }

  basicFill(int x, int y, int oldColor, int newColor) {
    if (x < 0 || x >= image.width) return;
    if (y < 0 || y >= image.height) return;

    int currentColor = image.getPixel(x, y);

    if (currentColor == oldColor) {
      image.setPixel(x, y, newColor);
      basicFill(x + 1, y, oldColor, newColor);
      basicFill(x - 1, y, oldColor, newColor);
      basicFill(x, y + 1, oldColor, newColor);
      basicFill(x, y - 1, oldColor, newColor);
      basicFill(x + 1, y + 1, oldColor, newColor);
      basicFill(x - 1, y + 1, oldColor, newColor);
      basicFill(x + 1, y - 1, oldColor, newColor);
      basicFill(x - 1, y - 1, oldColor, newColor);
    }
  }

  bool lineFill(Image image, List<List<bool>> hits, int x, int y, int srcColor,
      int tgtColor) {
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
    image.setPixel(x, y, tgtColor);

    ///assign hit
    hits[y][x] = true;

    return true;
  }
}
