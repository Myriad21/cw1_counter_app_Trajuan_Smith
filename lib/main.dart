import 'package:flutter/material.dart';

void main() => runApp(const CounterImageToggleApp());


class CounterImageToggleApp extends StatelessWidget {
  const CounterImageToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _isDark = false;
  bool _isFirstImage = true;
  bool _isZero = false;

  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      value: 1
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      toggleZero();
    });
  }

  void _incrementFive() {
    setState(() {
      _counter+=5;
      toggleZero();
    });
  }

  void _incrementTen() {
    setState(() {
      _counter+=10;
      toggleZero();
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
      if (_counter <= 0) {
        _counter =0;
        toggleZero();
      }
    });
  }
  void _decrementFive() {
    setState(() {
      _counter -= 5;
      if (_counter <= 0) {
        _counter =0;
        toggleZero();
      }
    });
  }
  void _decrementTen() {
    setState(() {
      _counter -= 10;
      if (_counter <= 0) {
        _counter =0;
        toggleZero();
      }
    });
  }

  void _reset() {setState(() {
    _counter=0;
    toggleZero();
  });}

  void _toggleTheme() {
    setState(() => _isDark = !_isDark);
  }
void _toggleImage() {
  setState(() => _isFirstImage = !_isFirstImage);
  _controller.forward(from: 0.0);
}


//checks if _counter is zero and sets _isZero to false if it is.
  void toggleZero() {
    if (_counter == 0) {
        _isZero = false;
      } else {
        _isZero = true;
      }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CW1 Counter & Toggle'),
          actions: [
            IconButton(
              onPressed: _toggleTheme,
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: _isDark ? Colors.white : Colors.black),
              ),

              // Row to add all increment buttons horizontally
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Increment:  '),
                  ElevatedButton(
                    onPressed: _incrementCounter,
                    child: const Text('+1'),
                  ),
                  ElevatedButton(
                    onPressed: _incrementFive,
                    child: const Text('+5'),
                  ),
                  ElevatedButton(
                    onPressed: _incrementTen,
                    child: const Text('+10'),
                  ),
                ],
              ),

              // 2nd Row for all decrement buttons
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Decrement:  '),
                  ElevatedButton(
                    onPressed: _isZero ? _decrementCounter : null,
                    child: const Text('-1'),
                  ),
                  ElevatedButton(
                    onPressed: _isZero ? _decrementFive : null,
                    child: const Text('-5'),
                  ),
                  ElevatedButton(
                    onPressed: _isZero ? _decrementTen : null,
                    child: const Text('-10'),
                  ),
                ],
              ),

              //Reset Button
              const SizedBox(height: 12),
              ElevatedButton(onPressed: _isZero ? _reset : null, child: const Text('Reset')),

              const SizedBox(height: 24),
              FadeTransition(
                opacity: _fade,
                child: Image.asset(
                  _isFirstImage ? 'assets/image1.jpg' : 'assets/image2.avif',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _toggleImage,
                child: const Text('Toggle Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}