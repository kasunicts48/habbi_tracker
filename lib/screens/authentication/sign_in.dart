import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:habbi_tracker/constants/colors.dart';
import 'package:habbi_tracker/constants/description.dart';
import 'package:habbi_tracker/constants/styles.dart';
import 'package:habbi_tracker/services/auth.dart';

class SignIn extends StatefulWidget {
// function

  final Function toggle;

  const SignIn({Key? key, required this.toggle}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // create a object from AuthService
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
          title: const Text("SIGN IN"),
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
                    'assets/images/signin.png',
                    height: 250,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
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
                              ? "Enter a valid password"
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

                        const SizedBox(
                          height: 10,
                        ),
                        // GestureDetector(
                        //   // sign in with google
                        //   onTap: () async {
                        //     dynamic result =
                        //         await _authServices.signInWithGoogleAuth();

                        //     if (result == null) {
                        //       setState(() {
                        //         error = "Couldn't sign in with google Auth";
                        //       });
                        //     }
                        //   },
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
                              "Do not have an account?",
                              style: descriptionStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              // go to the sign up (Register) page
                              onTap: () {
                                widget.toggle();
                              },
                              child: const Text(
                                "REGISTER",
                                style: TextStyle(color: mainBlue),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                          height: 10,
                        ),
                        // button sign in
                        GestureDetector(
                          // log in function using email and passowrd
                          onTap: () async {
                            dynamic result = await _authServices
                                .signInUsingEmailAndPassword(email, password);

                            if (result == null) {
                              setState(() {
                                error =
                                    "Couldn't sign in with those credentials";
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
                              "LOG IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            )),
                          ),
                        ),

                        // anonymous sign in
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          // log in function anonymous
                          onTap: () async {
                            await _authServices.singInAnonymously();
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
                              "LOG AS GUEST",
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

// ElevatedButton(
//           onPressed: () async {
//             dynamic result = await _authServices.singInAnonymously();
//             if (result == Null) {
//               print("error in sign in anonymously");
//             } else {
//               print("signed in anonymously");
//               print(result.uid);
//             }
//           },
//           child: const Text("Sign In Anonymously")),