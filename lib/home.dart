import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mini/login.dart'; // Assuming your LoginPage is imported from 'mini/login.dart'

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  int _featuredItemCount = 2; // Set the number of featured items

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToListPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListPage(_featuredItemCount)),
    );
  }

  void _showAcceptConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Accept"),
          content: Text("You have accepted the request and collect the food within 1 hour."),
          actions: [
            TextButton(
              onPressed: () {
                _showNotification('Accepted successfully'); // Show notification when accept button is pressed
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showNotification(String message) {
    // Display the notification message, for example using a snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
              // Perform logout action
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[200]!, Colors.blue[400]!],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        enableInfiniteScroll: true, // Enable infinite scroll
                        autoPlay: true, // Enable auto play
                        autoPlayInterval: Duration(seconds: 3), // Duration for auto play
                        autoPlayAnimationDuration: Duration(milliseconds: 800), // Animation duration for auto play
                        autoPlayCurve: Curves.fastOutSlowIn, // Animation curve for auto play
                        enlargeCenterPage: true, // Enable larger center item
                        viewportFraction: 0.8, // Fraction of the viewport to show (0.0 to 1.0)
                      ),
                      items: [
                        // List of widgets for carousel items
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage('assets/img1.png'), // Replace 'assets/image1.jpg' with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage('assets/img2.png'), // Replace 'assets/image2.jpg' with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              image: AssetImage('assets/img3.png'), // Replace 'assets/image3.jpg' with your image path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available hotels ',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Column(
                      children: List.generate(
                        _featuredItemCount,
                            (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Card(
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.white.withOpacity(0.8),
                              child: Container(
                                width: double.infinity,
                                height: 100.0,
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        'Hotel ${index + 1}',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                    AcceptButton(
                                      onPressed: () {
                                        _showAcceptConfirmation(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ListPage extends StatelessWidget {
  final int itemCount;

  ListPage(this.itemCount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Page'),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Hotel ${index + 1}'),
            trailing: AcceptButton(
              onPressed: () {
                // Handle the availability action
                // You can add your logic here
              },
            ),
          );
        },
      ),
    );
  }
}

class AcceptButton extends StatefulWidget {
  final VoidCallback onPressed;

  AcceptButton({required this.onPressed});

  @override
  _AcceptButtonState createState() => _AcceptButtonState();
}

class _AcceptButtonState extends State<AcceptButton> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _accepted = !_accepted;
        });
        widget.onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (_accepted) {
              return Colors.green;
            }
            return Colors.white;
          },
        ),
      ),
      child: Text(_accepted ? 'Accepted' : 'Accept'),
    );
  }
}
