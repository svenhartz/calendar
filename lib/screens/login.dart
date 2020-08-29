import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_app/constants.dart';
import 'calendar_app.dart';

var users = {
  'mail@svenhartz.com': '123',
};

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  bool authentication = false;
  FocusNode emailFN = new FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black87,
              child: Center(
                child: Text(
                  'CALENDAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w100,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                TextFormField(
                  controller: emailController,
                  focusNode: emailFN,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.email),
                    labelText: 'Email',
                  ),
                ),
                kVerticalSpacer8,
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: 'Password',
                  ),
                  obscureText: true,
                ),
                kVerticalSpacer24,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: FlatButton(
                        padding: EdgeInsets.all(16.0),
                        color: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        onPressed: () {
                          auth(emailController.text, passwordController.text);
                        },
                        child: Text(
                          "Log in",
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat',
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                    kHorizontalSpacer16,
                    Expanded(
                      child: OutlineButton(
                        padding: EdgeInsets.all(16.0),
                        borderSide: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        onPressed: () {
                          signup(emailController.text, passwordController.text);
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
                kVerticalSpacer24,
                Text(
                  'Forgot password?',
                  style: TextStyle(color: Colors.black45, fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void auth(String email, String password) {
    // UI error handling
    // email and password mustn't be null
    print(users);
    // db call
    print('email: ' + email + ' , password:' + password);
    if (users[email] != null && users[email] == password) {
      // with username
      Navigator.pushNamed(context, '/app', arguments: CalendarApp(title: email),);
      print('Authentication successful');
    } else {
      print('Authentication failed');
    }
  }

  void signup(String email, String password) {
    if (users[email] == null) {
      users[email] = password;
      print('Signup successful');
    } else {
      print('Signup failed');
    }
  }
}
