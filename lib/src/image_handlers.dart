import 'package:image/image.dart';

Image replaceColor(Image image, int oldColor, int newColoror) {
  for (var i = 0; i < image.width; i++) {
    for (var j = 0; j < image.height; j++) {
      int pixel = image.getPixel(i, j);

      if (pixel == oldColor) {
        image.setPixel(i, j, newColoror);
      }
    }
  }
  return image;
}
