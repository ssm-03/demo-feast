import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mini/login.dart';


class OrphanageRegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orphanage Registration',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black

      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: OrphanageRegistrationForm(),
      ),
    );
  }
}

class OrphanageRegistrationForm extends StatefulWidget {
  @override
  _OrphanageRegistrationFormState createState() => _OrphanageRegistrationFormState();
}

class _OrphanageRegistrationFormState extends State<OrphanageRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  late String _orphanageName;
  late String _email;
  late String _password;
  late String _phoneNumber;
  late String _registrationNumber;

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

  Future<void> _register() async {
    var url = 'https://kcet-canteen-web.000webhostapp.com/register.php'; // Replace with your PHP script URL

    // Data to be sent in the request body
    var data = {
      'name': _orphanageName,
      'email': _email,
      'password': _password,
      'phone': _phoneNumber,
      'reg': _registrationNumber,
      'id': '0', // Convert id to string
    };

    // Send POST request
    var response = await http.post(Uri.parse(url), body: data);

    // Check if the request was successful
    if (response.statusCode == 200) {

      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
        _showPopupMessage(context, 'Orphanage registered successfully!');
      });
    } else {
      _showPopupMessage(context, 'Failed to register orphanage. Please try again later.');
    }
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
              labelText: 'Orphanage Name',
              prefixIcon: Icon(Icons.home),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the orphanage name';
              }
              return null;
            },
            onSaved: (value) => _orphanageName = value!,
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
              labelText: 'Registration Number',
              prefixIcon: Icon(Icons.confirmation_num),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the registration number';
              }
              // You can add more validation logic if needed
              return null;
            },
            onSaved: (value) => _registrationNumber = value!,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                _register();
              }
            },
            child: Text('Register'),
          ),
        ],
      ),
    );
  }
}
