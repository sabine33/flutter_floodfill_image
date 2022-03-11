final bwFilter = [0, 0, 0, 0, 9, 0, 0, 0, 0].map((e) => e).toList();
final sharpFilter = [0, -1, 0, -1, 5, -1, 0, -1, 0].map((e) => e * 3).toList();
final blurFilter = [1, 1, 1, 1, 1, 1, 1, 1, 1].map((e) => e / 9).toList();
final laplacianEdge = [-1, -1, -1, -1, 8, -1, -1, -1, -1].toList();
