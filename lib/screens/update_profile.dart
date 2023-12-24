import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:news_app/database/db_service.dart';
import 'package:news_app/screens/profile.dart';
import '../utils/images.dart';
import '../widgets/applogo.dart';

class UpdateProfileScreen extends StatefulWidget {
  String username;
  UpdateProfileScreen({required this.username});
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var conPasswordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var completePhoneNumber;
  bool passVisible = true;

  void togglePasswordVisibility() {
    setState(() {
      passVisible = !passVisible;
    });
  }

  updateUserData() async{
    String mail = emailController.text;
    String pass = passwordController.text;
    int result = await DataBaseService.updateData(widget.username, pass, mail, completePhoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(AssetImages.bgImage), fit: BoxFit.fill
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(username: widget.username)));
            },
            icon: Icon(Icons.arrow_back_ios_new,
            color: Colors.white,),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppLogo(),
                const SizedBox(height: 10,),
                Text('GlobeChronicle',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4
                  ),),
                const SizedBox(height: 20,),
                Container(
                  height: screenHeight * 0.58,
                  width: screenWidth - 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 10),
                        blurRadius: 33,
                        color: Color(0xFFD3D3D3).withOpacity(.84),
                      )
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10,),
                      Center(
                        child: Container(
                          width: screenWidth - 100,
                          child: TextFormField(
                            controller: nameController,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please enter username';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter Username',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              prefixIcon: Icon(Icons.person, color: Colors.black,),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Container(
                          width: screenWidth - 100,
                          child: TextFormField(
                            controller: emailController,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please enter email';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter Email',
                              labelStyle: TextStyle(
                                color: Colors.black,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              prefixIcon: Icon(Icons.mail, color: Colors.black,),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Container(
                          width: screenWidth - 100,
                          child: TextFormField(
                            controller: passwordController,
                            obscureText: passVisible,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please enter password';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Enter Password',
                                labelStyle: TextStyle(
                                  color: Colors.black,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.black,),
                                suffixIcon: IconButton(
                                  icon: Icon(passVisible ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                                  onPressed: togglePasswordVisibility,
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Center(
                        child: Container(
                          width: screenWidth - 100,
                          child: TextFormField(
                            controller: conPasswordController,
                            obscureText: passVisible,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please enter password';
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                  color: Colors.black,

                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                prefixIcon: Icon(Icons.lock, color: Colors.black,),
                                suffixIcon: IconButton(
                                  icon: Icon(passVisible ? Icons.visibility_off : Icons.visibility, color: Colors.black,),
                                  onPressed: togglePasswordVisibility,
                                )
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Container(
                        width: screenWidth - 100,
                        child: IntlPhoneField(
                          controller: phoneController,
                          onChanged: (value) {
                            setState(() {
                              var countryCode = value.countryCode ?? '';
                              completePhoneNumber = '+' + countryCode + phoneController.text;
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(color: Colors.black, width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.all(Radius.circular(30)),
                                borderSide:
                                BorderSide(color: Colors.black, width: 2)),
                            label: Text(
                              'Enter Phone Number',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Container(
                        width: screenWidth - 150,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                minimumSize: Size(double.infinity, 25)),
                            onPressed: (){
                              updateUserData();
                            },
                            child: Text('Update Record', style: TextStyle(
                                color: Colors.white,
                                fontSize: 16
                            ),)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
