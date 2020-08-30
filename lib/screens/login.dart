import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_app/constants.dart';
import 'home.dart';

var users = {
  'mail@sven.com': '123',
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
                  style: kHeadlineLogin,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: kPrimaryButtonText,
                        ),
                      ),
                    ),
                    kHorizontalSpacer16,
                    OutlineButton(
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
                        style: kSecondaryButtonText,
                      ),
                    ),
                  ],
                ),
                kVerticalSpacer24,
                Text(
                  'Forgot password?',
                  style: kTextButton,
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
      Navigator.pushNamed(context, '/home', arguments: Home(title: email),);
      print('Authentication successful');
    } else {
      print('Authentication failed');
    }
  }

  void signup(String email, String password) {
    if (users[email] == null) {
      users[email] = password;
      print('Sign up successful');
    } else {
      print('Sign up failed');
    }
  }
}
