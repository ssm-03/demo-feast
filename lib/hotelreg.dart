import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini/login.dart';

class HotelRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donor Registration',style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: RegistrationForm(),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _hotelName;
  late String _email;
  late String _password;
  late String _phoneNumber;
  late String _registerNumber;

  void _showPopupMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Donor Name',
              prefixIcon: Icon(Icons.hotel),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the Donor name';
              }
              return null;
            },
            onSaved: (value) => _hotelName = value!,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              // You can add more email validation logic if needed
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
                return 'Please enter your password';
              }
              // You can add more password validation logic if needed
              return null;
            },
            onSaved: (value) => _password = value!,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
            ),
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              // You can add more phone number validation logic if needed
              return null;
            },
            onSaved: (value) => _phoneNumber = value!,
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Register Number',
              prefixIcon: Icon(Icons.confirmation_num),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the register number';
              }
              // You can add more validation logic if needed
              return null;
            },
            onSaved: (value) => _registerNumber = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _register,
            child: Text('Register'),
          ),
        ],
      ),
    );
    
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Send registration data to PHP server
      final url = 'https://kcet-canteen-web.000webhostapp.com/register.php'; // Replace with your PHP endpoint
      final response = await http.post(Uri.parse(url), body: {
        'name': _hotelName,
        'email': _email,
        'password': _password,
        'phone': _phoneNumber,
        'reg': _registerNumber,
        'id':'1',
      });

      // Handle response from the server
      if (response.statusCode == 200) {


          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          _showPopupMessage(context, 'Restaurant registered successfully!');
        // Registration successful
        // You can navigate to the next page or show a success message
      } else {
        // Registration failed
        // Handle error, show error message, or retry registration
      }
    }
  }
}
