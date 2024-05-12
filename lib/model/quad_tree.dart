import 'dart:math';

class QuadTree {
  final int capacity;
  final Rectangle boundary;

  QuadTree? _northWest;
  QuadTree? _northEast;
  QuadTree? _southWest;
  QuadTree? _southEast;

  final List<Point> _points = [];

  QuadTree({
    required this.boundary,
    this.capacity = 4,
  });

  bool insert(Point point) {
    // Игнорировать объекты, не принадлежащие дереву
    if (!boundary.containsPoint(point)) {
      return false; // Объект не может быть добавлен
    }

    // Если есть место, осуществить вставку
    if (_points.length < capacity) {
      _points.add(point);

      return true;
    }

    // Далее необходимо разделить область и добавить точку в какой-либо узел
    if (_northWest == null) {
      _subdivide();
    }

    if (_northWest?.insert(point) == true) {
      return true;
    }

    if (_northEast?.insert(point) == true) {
      return true;
    }

    if (_southWest?.insert(point) == true) {
      return true;
    }

    if (_southEast?.insert(point) == true) {
      return true;
    }

    // По каким-то причинам вставка может не осуществиться (чего на самом деле не должно происходить)
    return false;
  }

  void insertAll(Iterable<Point> points) {
    for (final point in points) {
      insert(point);
    }
  }

  // Найти точки, входящие в диапазон
  List<Point> queryRange(Rectangle rectangle) {
    // Подготовить массив под результат
    final List<Point> pointsInRange = [];

    // Отмена, если диапазон не совпадает с квадрантом
    if (!boundary.intersects(rectangle)) {
      return pointsInRange; // Пустой список
    }

    // Проверить объекты текущего уровня
    for (final point in _points) {
      if (rectangle.containsPoint(point)) {
        pointsInRange.add(point);
      }
    }

    // Остановка, если больше нет потомков
    if (_northWest == null) {
      return pointsInRange;
    }

    // Добавить все точки потомков
    pointsInRange.addAll(_northWest?.queryRange(rectangle) ?? []);
    pointsInRange.addAll(_northEast?.queryRange(rectangle) ?? []);
    pointsInRange.addAll(_southWest?.queryRange(rectangle) ?? []);
    pointsInRange.addAll(_southEast?.queryRange(rectangle) ?? []);

    return pointsInRange;
  }

  void _subdivide() {
    final halfWidth = boundary.width / 2;
    final halfHeight = boundary.height / 2;
    final midX = boundary.left + halfWidth;
    final midY = boundary.top + halfHeight;

    // Разделить область на 4 квадрата
    _northWest = QuadTree(
      boundary: Rectangle(boundary.left, boundary.top, halfWidth, halfHeight),
      capacity: capacity,
    );

    _northEast = QuadTree(
      boundary: Rectangle(midX, boundary.top, halfWidth, halfHeight),
      capacity: capacity,
    );

    _southWest = QuadTree(
      boundary: Rectangle(boundary.left, midY, halfWidth, halfHeight),
      capacity: capacity,
    );

    _southEast = QuadTree(
      boundary: Rectangle(midX, midY, halfWidth, halfHeight),
      capacity: capacity,
    );
  }
}
