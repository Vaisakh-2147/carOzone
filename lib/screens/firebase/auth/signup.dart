import 'package:car_o_zone/screens/firebase/home.dart';
import 'package:car_o_zone/screens/firebase/auth/login_user.dart';
import 'package:car_o_zone/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String email = "", password = "", userName = "";
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if (userNameController.text != "" &&
        emailController.text != "") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        await userCredential.user!.updateDisplayName(userNameController.text);

        String userId = userCredential.user!.uid;
        await saveUserIdLocally(userId);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Registration Successfully",
                style: TextStyle(fontSize: 20))));

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account Already exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
    }
  }

  Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [titleLogo()],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Signup',
                style: GoogleFonts.roboto(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height * .55,
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        subtitle('Username', 17),
                        textFormFieldWidget(
                          controller: userNameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                          hintText: 'Username',
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        subtitle('Email', 17),
                        textFormFieldWidget(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your Email';
                              }
                              return null;
                            },
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress),
                        const SizedBox(
                          height: 10,
                        ),
                        subtitle('Password', 17),
                        textFormFieldWidget(
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            hintText: 'Password',
                            keyboardType: TextInputType.text,
                            obscureText: true),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            loginSigninButton(
                                onPressed: () async {
                                  if (_formkey.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      userName = userNameController.text;
                                      password = passwordController.text;
                                    });
                                  }
                                  registration();
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .add({
                                    'email': emailController.text,
                                    'userName': userNameController.text,
                                    'password': passwordController.text,
                                    'profile': null
                                  });
                                },
                                buttonText: 'signup'),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Already have an account ?",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Signin',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 29, 236, 36),
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
