import 'package:flutter/material.dart';

void main() {
  runApp(SwitchSnapApp());
}

class SwitchSnapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwitchSnap',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _showFirstImage = true;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Increment Counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Toggle Image with Animation
  void _toggleImage() {
    _controller.forward(from: 0);
    setState(() {
      _showFirstImage = !_showFirstImage;
    });
  }

  // Reset Function
  void _reset() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Reset"),
        content: Text("Are you sure you want to reset the counter and image?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter = 0;
                _showFirstImage = true;
              });
              Navigator.pop(context);
            },
            child: Text("Reset"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SwitchSnap App')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter Display
            Text(
              "You have pushed the button this many times:",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Animated Image Toggle
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                key: ValueKey<bool>(_showFirstImage),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      _showFirstImage
                          ? 'assets/image1.jpg'
                          : 'assets/image2.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _incrementCounter,
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _toggleImage,
                  tooltip: 'Toggle Image',
                  child: Icon(Icons.image),
                ),
                SizedBox(width: 20),
                FloatingActionButton(
                  onPressed: _reset,
                  tooltip: 'Reset',
                  backgroundColor: Colors.red,
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
