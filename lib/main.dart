import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        /        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
 import 'package:flame/game.dart'; import 
'package:flutter/material.dart'; import 'dart:math'; void 
main() {
  runApp(GameWidget(game: SnakeGame()));
}
class SnakeGame extends FlameGame { static const int 
  gridSize = 20; final Random random = Random(); 
  List<Point<int>> snake = [Point(10, 10)]; Point<int> 
  food = Point(5, 5); Point<int> direction = Point(1, 0); 
  late double tick = 0; @override void update(double dt) 
  {
    tick += dt; if (tick > 0.2) { tick = 0; final newHead 
      = Point(
        (snake.first.x + direction.x) % gridSize, 
        (snake.first.y + direction.y) % gridSize,
      ); if (snake.contains(newHead)) { snake = 
        [Point(10, 10)]; // Oyunu resetle
      } else {
        snake.insert(0, newHead); if (newHead == food) { 
          food = Point(random.nextInt(gridSize), 
          random.nextInt(gridSize));
        } else {
          snake.removeLast();
        }
      }
    }
  }
  @override void render(Canvas canvas) { final paintSnake 
    = Paint()..color = Colors.green; final paintFood = 
    Paint()..color = Colors.red; final sizeCell = 
    Vector2(size.x / gridSize, size.y / gridSize); for 
    (final p in snake) {
      canvas.drawRect( Rect.fromLTWH(p.x * sizeCell.x, 
        p.y * sizeCell.y, sizeCell.x, sizeCell.y), 
        paintSnake,
      );
    }
    canvas.drawRect( Rect.fromLTWH(food.x * sizeCell.x, 
      food.y * sizeCell.y, sizeCell.x, sizeCell.y), 
      paintFood,
    );
  }
  @override void onTapDown(TapDownInfo info) { final tap 
    = info.eventPosition.global; final head = 
    snake.first;
    // Basit yön değiştirme
    if (tap.x > size.x / 2) direction = Point(1, 0); if 
    (tap.x < size.x / 2) direction = Point(-1, 0); if 
    (tap.y < size.y / 2) direction = Point(0, -1); if 
    (tap.y > size.y / 2) direction = Point(0,1);
  }
}
