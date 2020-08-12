import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gods_eye/components/horizontal_line.dart';
import 'package:gods_eye/components/rounded_button.dart';
import 'package:gods_eye/screens/login_screen/login_screen.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'sign_up_screen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final RoundedButtonController _btnController = new RoundedButtonController();

  //Signup form key to manage validation
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  //Sign up data
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  String nChildren;

  //backend endpoint
  final signUpEndpoint =
      'http://godseye-env.eba-gpcz6ppk.us-east-2.elasticbeanstalk.com/parents/signup';
  bool _isInvalid =
      false; // managed after response from server to strike input field

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    TextTheme textTheme = Theme.of(context).textTheme;

    //valid firstName
    String _validateFirstName(String firstName) {
      RegExp nameRegExp = RegExp(r'(^[a-zA-Z ]*$)');
      if (firstName.length == 0) {
        return "First name is required";
      } else if (!nameRegExp.hasMatch(firstName)) {
        return "Name must be a-z and A-Z";
      }
      return null;
    }

    // validate lastName
    String _validateLastName(String lastName) {
      RegExp nameRegExp = RegExp(r'(^[a-zA-Z ]*$)');
      if (lastName.length == 0) {
        return "Last name is required";
      } else if (!nameRegExp.hasMatch(lastName)) {
        return "Name must be a-z and A-Z";
      }
      return null;
    }

    //validate email
    String _validateEmail(String email) {
      RegExp emailRegExp = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
      if (_isInvalid) {
        //disable message until after next async call
        _isInvalid = false;
        return "This email already exists";
      }
      if (emailRegExp.hasMatch(email)) {
        return null;
      } else if (email.length == 0) {
        return "Email is required";
      } else {
        return "Enter valid email";
      }
    }

    //validate number of children
    String _validateNChildren(String nChildren) {
      if (nChildren.length == 0) {
        return "Number of children is required";
      }
      return null;
    }

    //validate password
    String _validatePassword(String password) {
      // RegExp strongPassowrd = RegExp(
      //     r'^(?=.?[A-Z])(?=.?[a-z])(?=.?[0-9])(?=.?[!@#\$&*~]).{8,}$');
      if (password.length < 8) {
        return "Minimum length is 8 characters";
      }
      return null;
    }

    //validate confirm password
    String _validateConfirmPassword(String confirmPassword) {
      if (password != confirmPassword) {
        return "Password does not match";
      }
      return null;
    }

    void _validateSignUp() async {
      if (_signUpFormKey.currentState.validate()) {
        //everything okay so proceed to sign up
        _signUpFormKey.currentState.save();

        //dismiss keyboard during async call
        FocusScope.of(context).requestFocus(new FocusNode());

        // md5 hash password before posting
        var passwordUTF8 = utf8.encode(password); //data being hashed
        var hashedPassword = md5.convert(passwordUTF8);

        Map postData = {
          "firstName": "$firstName",
          "lastName": "$lastName",
          "password": "$hashedPassword",
          "nChildren": "$nChildren",
          "email": "$email"
        };
        //post data to backend and await response
        var response = await http.post(signUpEndpoint, body: postData);
        var data = jsonDecode(response.body);

        //check if whether sign up was successful
        if (data["status"].containsKey("failure")) {
          //Sign up failure(email already exists)
          setState(() {
            _isInvalid = true;
          });
          //show error animation of button
          _btnController.error();
          Timer(Duration(seconds: 2), () {
            _btnController.stop();
            _btnController.reset();
          });
        } else if (data["status"].containsKey("success")) {
          //Sign up success
          // show success animation of button and pyush back to login screen
          _btnController.success();
          Timer(Duration(seconds: 2), () {
            Navigator.pushNamed(context, LoginScreen.id);
            _btnController.stop();
            _btnController.reset();
          });
        }
      } else {
        //show error animation on button
        _btnController.error();
        Timer(Duration(seconds: 2), () {
          _btnController.stop();
          _btnController.reset();
        });
      }
    }

// run the validators on reload to process async results
    _signUpFormKey.currentState?.validate();

    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
          Positioned(
            right: screenWidth * -0.07,
            top: screenHeight * 0.024,
            child: SvgPicture.asset(
              'images/sign_up_background.svg',
              height: screenHeight * 0.305,
              width: screenWidth * 0.305,
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
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                            fontSize: 26),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.148, left: screenWidth * 0.033),
                    child: Text(
                      'Enter details to register.',
                      style: textTheme.headline1.copyWith(
                        fontSize: 17.5,
                        color: Colors.black,
                      ),
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
                      child: Stack(
                        children: <Widget>[
                          SingleChildScrollView(
                              physics: BouncingScrollPhysics(),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Sign Up",
                                        style: textTheme.headline1.copyWith(
                                            letterSpacing: .6,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black,
                                            fontSize: 24.8)),
                                    SizedBox(
                                      height: screenHeight * 0.0225,
                                    ),
                                    Form(
                                      key: _signUpFormKey,
                                      child: Column(
                                        children: <Widget>[
                                          TextFormField(
                                              validator: _validateFirstName,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: 'First Name',
                                                labelStyle:
                                                    TextStyle(fontSize: 19.3),
                                              ),
                                              onChanged: (value) {
                                                firstName = value;
                                                setState(() {
                                                  _validateFirstName(firstName);
                                                });
                                              }),
                                          SizedBox(
                                            height: screenHeight * 0.0225,
                                          ),
                                          TextFormField(
                                              validator: _validateLastName,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                labelText: 'Last Name',
                                                labelStyle:
                                                    TextStyle(fontSize: 19.3),
                                              ),
                                              onChanged: (value) {
                                                lastName = value;
                                                setState(() {
                                                  _validateLastName(lastName);
                                                });
                                              }),
                                          SizedBox(
                                            height: screenHeight * 0.0225,
                                          ),
                                          TextFormField(
                                            validator: _validateEmail,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Email',
                                              labelStyle:
                                                  TextStyle(fontSize: 19.3),
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
                                              validator: _validateNChildren,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                labelText: 'Number of Children',
                                                labelStyle:
                                                    TextStyle(fontSize: 19.3),
                                              ),
                                              onChanged: (value) {
                                                nChildren = value;
                                                setState(() {
                                                  _validateNChildren(nChildren);
                                                });
                                              }),
                                          SizedBox(
                                            height: screenHeight * 0.0225,
                                          ),
                                          TextFormField(
                                              validator: _validatePassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                labelText: 'Password',
                                                labelStyle:
                                                    TextStyle(fontSize: 19.3),
                                              ),
                                              onChanged: (value) {
                                                password = value;
                                                setState(() {
                                                  _validatePassword(password);
                                                });
                                              }),
                                          SizedBox(
                                            height: screenHeight * 0.0225,
                                          ),
                                          TextFormField(
                                              validator:
                                                  _validateConfirmPassword,
                                              obscureText: true,
                                              decoration: InputDecoration(
                                                labelText: 'Confirm Password',
                                                labelStyle:
                                                    TextStyle(fontSize: 19.3),
                                              ),
                                              onChanged: (value) {
                                                confirmPassword = value;
                                                setState(() {
                                                  _validateConfirmPassword(
                                                      confirmPassword);
                                                });
                                              }),
                                          Padding(
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.045))
                                        ],
                                      ),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      RoundedButton(
                        text: "SIGN UP",
                        controller: _btnController,
                        onPressed: _validateSignUp,
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
                        width: screenWidth * 0.03,
                      ),
                      horizontalLine()
                    ],
                  ),
                ],
              ),
            ),
          )
        ])));
  }
}
