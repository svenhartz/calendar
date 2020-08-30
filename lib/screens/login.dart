import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:calendar_app/constants.dart';
import 'package:provider/provider.dart';
import 'package:calendar_app/data.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  FocusNode emailFN = new FocusNode();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorMessage = '';

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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                if(errorMessage != '') Container(
                  child: Center(
                    child: Text(
                      errorMessage ?? '',
                      style: kErrorMessage,
                    ),
                  ),
                  padding: EdgeInsets.all(16.0),
                  decoration: new BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                    ),
                    borderRadius: new BorderRadius.circular(4.0),
                  ),
                ),
                if(errorMessage != '') kVerticalSpacer16,
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
                Center(
                  child: Text(
                    'Forgot password?',
                    style: kTextButton,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void auth(String email, String password) {
    print('email: ' + email + ' , password:' + password);

    if (Provider.of<Data>(context, listen: false).auth(email, password)) {
      Provider.of<Data>(context, listen: false).setEmail(email);
      if(Provider.of<Data>(context, listen: false).firstLogin){
        Navigator.pushNamed(
          context,
          '/addCalendar',

        );
        Provider.of<Data>(context, listen: false).firstLogin = false;
      }else{
        Navigator.pushNamed(
          context,
          '/home',
          arguments: Home(
              title:
              Provider.of<Data>(context, listen: false).email),
        );
      }
    } else {
      showErrorMessage('Authentication failed');
    }
  }

  void signup(String email, String password) {
    if(email == '' || password == ''){
      showErrorMessage('Email and password is required!');
      return;
    }

    if (Provider.of<Data>(context, listen: false).signup(email, password)) {
    } else {
      showErrorMessage('Sign up failed');
    }
  }

  void showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });
  }
}
