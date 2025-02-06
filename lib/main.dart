import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SwitchSnap',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CounterScreen(),
    );
  }
}

class CounterScreen extends StatefulWidget {
  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  bool _showFirstImage = true; // Boolean to track image state
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
      lowerBound: 0.8,
      upperBound: 1.2,
    );

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    _controller.forward().then((_) => _controller.reverse()); // Scale effect
  }

  void _toggleImage() {
    setState(() {
      _showFirstImage = !_showFirstImage; // Toggle between images
    });
  }

  // Function to reset counter & image with a confirmation dialog
  void _resetCounterAndImage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Confirmation"),
          content: Text("Are you sure you want to reset everything?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            ElevatedButton(
              child: Text("Reset"),
              onPressed: () {
                setState(() {
                  _counter = 0;
                  _showFirstImage = true; // Reset image
                });
                Navigator.of(context).pop(); // Close dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SwitchSnap App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),

          // Animated Counter
          ScaleTransition(
            scale: _scaleAnimation,
            child: Text(
              '$_counter',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 20),

          // Animated Image Toggle
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            transitionBuilder: (widget, animation) {
              return FadeTransition(
                opacity: animation,
                child: widget,
              );
            },
            child: Container(
              key: ValueKey<bool>(_showFirstImage),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    _showFirstImage ? 'assets/image1.jpg' : 'assets/image2.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          SizedBox(height: 20),

          // Toggle Image Button
          ElevatedButton.icon(
            onPressed: _toggleImage,
            icon: Icon(Icons.image),
            label: Text("Toggle Image"),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              backgroundColor: Colors.orangeAccent,
            ),
          ),

          SizedBox(height: 20),

          // Reset Button
          ElevatedButton.icon(
            onPressed: _resetCounterAndImage,
            icon: Icon(Icons.refresh),
            label: Text("Reset"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
      ),
    );
  }
}
