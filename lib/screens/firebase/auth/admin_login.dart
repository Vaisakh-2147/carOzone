import 'package:car_o_zone/functions/functions.dart';
import 'package:car_o_zone/screens/firebase/admin_panel.dart';
import 'package:car_o_zone/screens/firebase/auth/login_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminloginScreen extends StatelessWidget {
  AdminloginScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Column(
                  children: [
                    titleLogo(),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'Admin Login',
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height * .50,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    subtitle('Email', 17),
                    textFormFieldWidget(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    subtitle('Password', 17),
                    textFormFieldWidget(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Password';
                        }
                        return null;
                      },
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: loginSigninButton(
                        onPressed: () {
                          if (_formKey.currentState != null &&
                              _formKey.currentState!.validate()) {
                            try {
                              if (_emailController.text ==
                                      'vaisakh@gmail.com' &&
                                  _passwordController.text == '123456789') {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminpanelScreen(),
                                ));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  createCustomSnackBar(
                                    text: 'Invalid username or password',
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              print('Error: $e');
                            }
                          }
                        },
                        buttonText: 'Login',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Are you user ?",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
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
                            'Sign In',
                            style: TextStyle(
                              color: Color.fromARGB(255, 29, 236, 36),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
