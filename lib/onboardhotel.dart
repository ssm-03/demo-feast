import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HotelOnboardingPage extends StatefulWidget {
  @override
  _HotelOnboardingPageState createState() => _HotelOnboardingPageState();
}

class _HotelOnboardingPageState extends State<HotelOnboardingPage> {
  int _currentImageIndex = 0;

  final List<String> images = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',
    // Add more image paths here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          CarouselSlider(
            items: images.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: 400.0,
              initialPage: 0,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentImageIndex = index;
                });
              },
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.map((url) {
              int index = images.indexOf(url);
              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentImageIndex == index ? Colors.blue : Colors.grey,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Handle button press to navigate to the next page
            },
            child: Text('Get Started'),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HotelOnboardingPage(),
  ));
}
