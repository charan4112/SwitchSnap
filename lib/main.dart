import 'package:flutter/material.dart';

void main() {
  runApp(SwitchSnapApp());
}

class SwitchSnapApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  bool _showFirstImage = true;
  bool _isToggled = false; // Track switch state

  // Increment Counter
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // Toggle Image
  void _toggleImage(bool value) {
    setState(() {
      _isToggled = value;
      _showFirstImage = !_showFirstImage;
    });
  }

  // Reset Function with Confirmation Dialog
  void _resetApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reset App?"),
        content: Text("Are you sure you want to reset the counter and image?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("Cancel", style: TextStyle(color: Colors.red))
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter = 0;
                _showFirstImage = true;
                _isToggled = false;
              });
              Navigator.pop(context);
            },
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SwitchSnap", style: Theme.of(context).textTheme.titleLarge),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Counter at the top
            Text(
              "Counter: $_counter",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Image Display
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                _showFirstImage ? "assets/image1.jpg" : "assets/image2.jpg",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(height: 20),

            // Toggle Switch with Label
            Column(
              children: [
                Text(
                  "Image Toggle",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Switch(
                  value: _isToggled,
                  onChanged: _toggleImage,
                  activeColor: Colors.blue,
                  inactiveThumbColor: Colors.grey,
                  inactiveTrackColor: Colors.grey.shade400,
                ),
              ],
            ),

            SizedBox(height: 20),

            // Reset Button - Centered at Bottom
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ElevatedButton.icon(
                onPressed: _resetApp,
                icon: Icon(Icons.refresh, size: 30),
                label: Text("Reset", style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
      
      // Floating Action Button for Increment
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
