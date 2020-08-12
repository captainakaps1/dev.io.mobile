import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gods_eye/components/horizontal_line.dart';
import 'package:gods_eye/components/radio_button.dart';
import 'package:gods_eye/components/rounded_button.dart';
import 'package:gods_eye/screens/main_nav.dart';
import 'package:gods_eye/screens/sign_up_screen/sign_up_screen.dart';
import 'package:gods_eye/services/user_service.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSelected = false;
  final RoundedButtonController _btnController = new RoundedButtonController();

  // Login form key to manage validation
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  // user serice object
  final UserService service = UserService();

  // Login data
  String email;
  String password;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  bool _isInvalidEmail =
      false; // managed after response from server to strike email input field
  bool _isInvalidPassword =
      false; // managed after response from server to strike password input field
  bool _loggedIn =
      false; // managed after response from server to strike input field

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    // validate email
    String _validateEmail(String email) {
      RegExp emailRegExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (_isInvalidEmail) {
        // disable message until after next async call
        _isInvalidEmail = false;
        return "Incorrect Email";
      }
      if (_loggedIn) {
        // disable message until after next async call
        _loggedIn = false;
        return "User already logged in";
      }
      if (emailRegExp.hasMatch(email)) {
        return null;
      } else if (email.length == 0) {
        return "Email is required";
      } else {
        return "Enter valid email";
      }
    }

    // validate password
    String _validatePassword(String password) {
      // RegExp strongPassword = Reg( r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$');
      if (_isInvalidPassword) {
        // disable message until after next async call
        _isInvalidPassword = false;
        return "Incorrect Password";
      }
      if (password.length == 0) {
        return "Password is required";
      } else if (password.length < 8) {
        return "Minimum length is 8 characters";
      }
      return null;
    }

    void _validateLogin() async {
      if (_loginFormKey.currentState.validate()) {
        // everything okay so proceed to login
        _loginFormKey.currentState.save();

        // dismiss keyboard during async call
        FocusScope.of(context).requestFocus(new FocusNode());

        // call log in function
        service.userLogin(email: email, password: password).then((res) {
          if (res == 0) {
            // Login failure(User not found)
            setState(() {
              _isInvalidEmail = true;
              _isInvalidPassword = true;
            });
            // show error animation of button
            _btnController.error();
            Timer(Duration(seconds: 2), () {
              _btnController.stop();
              _btnController.reset();
            });
          } else if (res == 1) {
            // Login failure(Wrong password)
            setState(() {
              _isInvalidPassword = true;
            });
            // show error animation of button
            _btnController.error();
            Timer(Duration(seconds: 2), () {
              _btnController.stop();
              _btnController.reset();
            });
          } else if (res == 2) {
            // Login failure(User already logged in)
            setState(() {
              _loggedIn = true;
            });
            // show error animation of button
            _btnController.error();
            Timer(Duration(seconds: 2), () {
              _btnController.stop();
              _btnController.reset();
            });
          } else if (res == 3) {
            // Login Success
            // remember user if selectd
            if (_isSelected) service.rememberMe();

            //show sucess animation of button and push to main screen
            _btnController.success();
            Timer(Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(context, MainNav.id);
              _btnController.stop();
              _btnController.reset();
            });
          }
        });
      } else {
        // show error animation on button
        _btnController.error();
        Timer(Duration(seconds: 2), () {
          _btnController.stop();
          _btnController.reset();
        });
      }
    }

    _loginFormKey.currentState?.validate();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              right: screenWidth * -0.07,
              top: screenHeight * 0.023,
              child: SvgPicture.asset(
                'images/login_background.svg',
                height: screenHeight * 0.297,
                width: screenWidth * 0.297,
              ),
            ),
            Positioned(
              right: 0.0,
              bottom: 0.0,
              child: Image.asset("images/city.png"),
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  left: screenWidth * 0.068,
                  right: screenWidth * 0.068,
                  top: screenHeight * 0.088,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset(
                          "images/ball.png",
                          width: screenWidth * 0.147,
                          height: screenWidth * 0.138,
                        ),
                        Text(
                          "Welcome.",
                          style: textTheme.headline1.copyWith(
                              letterSpacing: .6,
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 26),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.0965,
                          left: screenWidth * 0.033),
                      child: Text(
                        'Sign in to continue.',
                        style: textTheme.headline1
                            .copyWith(fontSize: 17.5, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.037,
                    ),
                    Container(
                      width: screenWidth,
                      height: screenHeight * 0.405,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(screenHeight * 0.015),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, screenHeight * 0.02),
                              blurRadius: screenHeight * 0.02,
                            ),
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0.0, screenHeight * -0.015),
                              blurRadius: screenHeight * 0.015,
                            ),
                          ]),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: screenWidth * 0.038,
                          right: screenWidth * 0.038,
                          top: screenHeight * 0.023,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("Login",
                                style: textTheme.headline1.copyWith(
                                    letterSpacing: .6,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24.8)),
                            SizedBox(
                              height: screenHeight * 0.0225,
                            ),
                            Form(
                              key: _loginFormKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: _validateEmail,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle: TextStyle(fontSize: 19.3),
                                    ),
                                    onChanged: (value) {
                                      email = value;
                                      setState(() {
                                        _validateEmail(email);
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: screenHeight * 0.0225,
                                  ),
                                  TextFormField(
                                    validator: _validatePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle: TextStyle(fontSize: 19.3),
                                    ),
                                    onChanged: (value) {
                                      password = value;
                                      setState(() {
                                        _validatePassword(password);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            // Padding(
                            //   padding:
                            //       EdgeInsets.only(top: screenHeight * 0.045),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.end,
                            //     children: <Widget>[
                            //       Text(
                            //         "Forgot Password?",
                            //         style: textTheme.bodyText1.copyWith(
                            //             color: Colors.blue,
                            //             fontWeight: FontWeight.w800),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: screenWidth * 0.03,
                            ),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(
                              width: screenWidth * 0.02,
                            ),
                            Text("Remember me",
                                style: textTheme.bodyText1.copyWith(
                                    fontSize: 12.7,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: .005))
                          ],
                        ),
                        RoundedButton(
                          text: "SIGN IN",
                          controller: _btnController,
                          onPressed: _validateLogin,
                          width: screenWidth * 0.44,
                          height: screenHeight * 0.075,
                        )
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        SizedBox(
                          width: screenWidth * 0.07,
                        ),
                        horizontalLine()
                      ],
                    ),
                    // SizedBox(
                    //   height: screenHeight * 0.053,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     Text(
                    //       "New User? ",
                    //       style: textTheme.bodyText1
                    //           .copyWith(fontWeight: FontWeight.w800),
                    //     ),
                    //     InkWell(
                    //       onTap: () {
                    //         Navigator.pushNamed(context, SignUpScreen.id);
                    //       },
                    //       child: Text(
                    //         "Sign Up",
                    //         style: textTheme.bodyText1.copyWith(
                    //             color: Colors.blue,
                    //             fontWeight: FontWeight.w800),
                    //       ),
                    //     )
                      // ],
                    // )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
