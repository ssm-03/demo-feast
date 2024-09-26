import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:mini/hotelreg.dart';
import 'package:mini/orpreg.dart';
import 'package:mini/home.dart';
import 'package:mini/home2.dart';
//import 'package:mini/onboardhotel.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage2(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            CarouselSlider(
              items: [
                'assets/logo.png',
                'assets/img1.jpg',
                'assets/img2.png',
              ].map((item) => Image.asset(item)).toList(),
              options: CarouselOptions(
                height: 100,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the email';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value!,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _loginUser(context);
                    },
                    child: Text('Login'),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HotelRegistrationPage()),
                      );
                    },
                    child: Text('Register as a Donor'),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrphanageRegistrationPage()),
                      );
                    },
                    child: Text('Register as an Orphanage'),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loginUser(BuildContext context) async {
    final form = _formKey.currentState;
    if (form != null && form.validate()) {
      form.save();

      var url = 'https://kcet-canteen-web.000webhostapp.com/login.php';

      var data = {
        'email': _email.toString(),
        'password': _password.toString(),
      };

      var response = await http.post(Uri.parse(url), body: data);

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        if (jsonData['status'] == 'success') {
          // Login successful, extract user ID
          var userId = jsonData['id'];
          if(userId=='1'){
          // Navigate to another screen with the user ID
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),//orphan
          );
          }
          else{
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage2()),//hotel
            );
          }

        } else {
          print('Failed to login. Please try again later.');
        }
      }
    }
  }
}