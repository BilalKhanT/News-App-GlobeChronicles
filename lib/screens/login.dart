import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/signup.dart';
import 'package:provider/provider.dart';
import '../database/db_service.dart';
import '../model/user_model.dart';
import '../provider/saved_provider.dart';
import '../utils/images.dart';
import '../widgets/applogo.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  var userController = TextEditingController();
  var passwordController = TextEditingController();
  bool passVisible = true;
  var dbService;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    dbService = DataBaseService();
    super.initState();
  }

  void _togglePasswordVisibility() {
    setState(() {
      passVisible = !passVisible;
    });
  }

  void showToast(String data) {
    var messengerState = ScaffoldMessenger.of(context);
    messengerState.removeCurrentSnackBar();
    messengerState.showSnackBar(SnackBar(
      content: Align(
        alignment: Alignment.center,
        child: Text(data, style: TextStyle(
          fontSize: 16,
          color: Color(0xffB81736),
        ),),
      ),
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      showCloseIcon: false,
    ));
  }

  validateUserCredentials() async{
    String mail = userController.text;
    String pass = passwordController.text.trim();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: pass);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(username: mail,)),
      );
    } catch (e) {
      print(e);
      showToast('Invalid login credentials');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.4,
                width: screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
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
                    SizedBox(height: screenHeight * 0.01,),
                    Text("GlobeChronicles",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      color: Colors.white,
                    ),),
                  ],
                ),
              ),
              Container(
                height: screenHeight * 0.6,
                width: screenWidth,
                color: Colors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Welcome Back",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 30,
                        ),),
                      Text("Sign in to your account",
                        style: GoogleFonts.poppins(
                          color: Colors.black.withOpacity(0.7),
                        ),),
                      SizedBox(height: screenHeight * 0.02,),
                      Container(
                          width: screenWidth - 80,
                          child: Column(
                            children: <Widget>[
                              Form(
                                key: formKey,
                                child: Column(
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
                                        prefixIcon: Icon(Icons.person, color: Colors.black,),
                                        hintText: "Enter Username",
                                        hintStyle: GoogleFonts.poppins(
                                          color: Colors.black.withOpacity(0.7),
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: screenHeight * 0.02,
                                    ),
                                    TextFormField(
                                      controller: passwordController,
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter a password';
                                        }
                                        return null;
                                      },
                                      obscureText: passVisible,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock, color: Colors.black,),
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
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: (){},
                                    child: Text('Forgot Password',
                                      style: GoogleFonts.poppins(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 13,
                                      ),),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.02,
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(),
                                    backgroundColor: Colors.black,
                                    minimumSize: Size(screenWidth - 250, 55)),
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ?? true ) {
                                    await validateUserCredentials();
                                  }
                                },
                                child: Text('Login', style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                ),),
                              SizedBox(height: screenHeight * 0.03,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),),
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                                    },
                                    child: Text(" Create",
                                    style: GoogleFonts.poppins(
                                      color: Color(0xffB81736),
                                      fontSize: 16,
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          )
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
