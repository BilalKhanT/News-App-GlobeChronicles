import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:news_app/screens/login.dart';
import '../database/db_service.dart';
import '../utils/images.dart';
import '../widgets/applogo.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = GlobalKey<FormState>();
  var userController = TextEditingController();
  var passController = TextEditingController();
  var conPassController = TextEditingController();
  var mailController = TextEditingController();
  bool passVisible = true;
  bool pass_Visible = true;
  var phoneController = TextEditingController();
  var completePhoneNumber;

  signUpUser() async {
    String name = userController.text;
    String pass = passController.text;
    String conPass = conPassController.text;
    String mail = mailController.text;
    int id =
        await DataBaseService.saveData(name, pass, mail, completePhoneNumber);
  }

  firebaseSignUp() async {
    String mail = mailController.text.trim();
    String pass = passController.text.trim();
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: mail, password: pass);
  }

  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
  );

  void _togglePasswordVisibility() {
    setState(() {
      passVisible = !passVisible;
    });
  }

  void togglePasswordVisibility() {
    setState(() {
      pass_Visible = !pass_Visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.35,
              width: screenWidth,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xffB81736),
                  Color(0xff281537),
                ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(112, 90),
                    bottomRight: Radius.elliptical(112, 90)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AppLogo(),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Text(
                    "GlobeChronicles",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: screenHeight * 0.65,
              width: screenWidth,
              color: Colors.white,
              child: Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 25,
                    ),

                    Text(
                      "Register",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Create your new account",
                      style: GoogleFonts.poppins(
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                        width: screenWidth - 80,
                        child: Column(
                          children: <Widget>[
                            Form(
                                key: formKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: userController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter a username';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.black,
                                        ),
                                        hintText: "Enter Username",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: mailController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter an email';
                                        }
                                        if (!emailRegex.hasMatch(value!)) {
                                          return 'Invalid email format';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.mail_rounded,
                                          color: Colors.black,
                                        ),
                                        hintText: "Enter Email",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: passController,
                                      obscureText: passVisible,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter a password';
                                        }
                                        if (!passwordRegex.hasMatch(value!)) {
                                          return 'Password must contain at least 1 lowercase, 1 uppercase, and 1 number';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: _togglePasswordVisibility,
                                          icon: Icon(
                                            passVisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: "Enter Password",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: conPassController,
                                      validator: (value) {
                                        if (value != passController.text) {
                                          return 'Passwords do not match';
                                        }
                                      },
                                      obscureText: pass_Visible,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Colors.black,
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: togglePasswordVisibility,
                                          icon: Icon(
                                            pass_Visible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.black,
                                          ),
                                        ),
                                        hintText: "Confirm Password",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    IntlPhoneField(
                                      controller: phoneController,
                                      onChanged: (value) {
                                        setState(() {
                                          var countryCode = value.countryCode ?? '';
                                          completePhoneNumber = '+' + countryCode + phoneController.text;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.phone, color: Colors.white,),
                                        hintText:
                                        'Enter Phone Number',
                                        hintStyle: GoogleFonts.poppins(
                                            color: Colors.black.withOpacity(0.7), fontSize: 12),
                                      ),
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                )),
                            const SizedBox(
                              height: 25,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  minimumSize: Size(screenWidth - 250, 55)),
                              onPressed: () async {
                                if (formKey.currentState?.validate() ?? true) {
                                  await signUpUser();
                                  await firebaseSignUp();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()));
                                }
                              },
                              child: Text(
                                'Signup',
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        )),
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
