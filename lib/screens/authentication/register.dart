import 'package:flutter/material.dart';
import 'package:habbi_tracker/constants/colors.dart';
import 'package:habbi_tracker/constants/description.dart';
import 'package:habbi_tracker/constants/styles.dart';
import 'package:habbi_tracker/services/auth.dart';

class Register extends StatefulWidget {
  // funtion
  final Function toggle;

  const Register({Key? key, required this.toggle}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthServices _authServices = AuthServices();

  // form key
  final _formKey = GlobalKey<FormState>();

  // email password states
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("REGISTER"),
          backgroundColor: bgBlack,
          foregroundColor: Colors.white,
        ),
        backgroundColor: bgBlack,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 10),
            child: Column(
              children: [
                // description
                const Text(
                  description,
                  style: descriptionStyle,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/register.png',
                    height: 300,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // email
                        TextFormField(
                          style: const TextStyle(color: Colors.white),
                          decoration: textInputDecoration,
                          validator: (value) => value?.isEmpty == true
                              ? "Enter a valid emial"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // password
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: textInputDecoration.copyWith(
                              hintText: "Enter password"),
                          validator: (value) => value!.length < 6
                              ? "Password must be at least 6 characters"
                              : null,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),

                        // show error text
                        Text(
                          error,
                          style: TextStyle(color: Colors.red.shade600),
                        ),

                        const Text(
                          "Login with social accounts",
                          style: descriptionStyle,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // google authenticate
                        // GestureDetector(
                        //   // sign in with google
                        //   onTap: () {},
                        //   child: Center(
                        //     child: Image.asset(
                        //       'assets/images/android_dark_google_signin.png',
                        //       height: 40,
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 10,
                        // ),

                        // register
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Do you have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              // go to the login page
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "LOGIN",
                                style: TextStyle(color: mainBlue),
                              ),
                            ),
                          ],
                        ),

                        // button sign in
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          // register function
                          onTap: () async {
                            dynamic result = await _authServices
                                .registerWithEmailAndPassword(email, password);

                            if (result == null) {
                              // set error
                              setState(() {
                                error = "please enter a valid email";
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 200,
                            decoration: BoxDecoration(
                                color: bgBlack,
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 2,
                                  color: mainYellow,
                                )),
                            child: const Center(
                                child: Text(
                              "REGISTER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
