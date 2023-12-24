import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/api/api_service.dart';
import 'package:news_app/database/db_service.dart';
import 'package:news_app/screens/search.dart';
import 'package:news_app/screens/update_profile.dart';
import '../model/user_model.dart';
import '../utils/images.dart';
import '../widgets/applogo.dart';
import 'bookmark.dart';
import 'home.dart';

class ProfileScreen extends StatefulWidget {
  String username;
  ProfileScreen({required this.username});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  var userData;
  File? profilePhoto;
  @override
  void initState() {
    getProfileData();
    super.initState();
  }

  void _uploadPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profilePhoto = File(pickedFile.path);
      });
    }
  }

  void getProfileData() async {
    UserModel data = await DataBaseService.getUserData(widget.username);
    setState(() {
      userData = data;
    });
  }

  Widget _buildProfileScreen() {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: screenHeight * 0.33,
          child: Container(
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
        ),
        Positioned(
          top: screenHeight * 0.33,
          left: 0,
          right: 0,
          height: screenHeight * 0.62,
          child: Container(
            color: Colors.white,
          ),
        ),
        Positioned(
          top: screenHeight * 0.28,
          left: 0,
          right: 0,
          height: screenHeight * 0.6,
          child: Center(
            child: Container(
              width: screenWidth - 60,
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
                    child: GestureDetector(
                      onTap: _uploadPhoto,
                      child: CircleAvatar(
                        backgroundColor: Color(0xffB81736).withOpacity(0.8),
                        radius: 60,
                        backgroundImage: profilePhoto != null ? FileImage(profilePhoto!) : null,
                        child: profilePhoto == null ? Icon(Icons.person, color: Colors.white, size: 50) : null,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Container(
                    width: screenWidth - 250,
                    child:
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            backgroundColor: Color(0xff281537),
                            padding: EdgeInsets.symmetric(vertical: 12),
                            minimumSize: Size(double.infinity, 25)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => UpdateProfileScreen(username: widget.username,)));
                        },
                        child: Text('Edit Profile', style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16
                        ),)),
                  ),
                  Container(
                    width: screenWidth - 70,
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        ListTile(
                          title: Text("Username",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          leading: Icon(Icons.person, color: Color(0xffB81736),),
                          trailing: Text("${userData.user_name}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                        ),
                        ListTile(
                          title: Text("Password",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          leading: Icon(Icons.lock, color: Color(0xffB81736),),
                          trailing: Text("${userData.password}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                        ),
                        ListTile(
                          title: Text("Mail",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          leading: Icon(Icons.mail, color: Color(0xffB81736),),
                          trailing: Text("${userData.email}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                        ),
                        ListTile(
                          title: Text("Contact",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                          leading: Icon(Icons.phone, color: Color(0xffB81736),),
                          trailing: Text("${userData.phone.toString().substring(1, 14)}",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w500
                            ),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              gradient: LinearGradient(colors: [
                Color(0xffB81736),
                Color(0xff281537),
              ]),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(username: widget.username)));
                          },
                          icon: Icon(
                            Icons.home_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(username: widget.username, flag: 0, query: '')));
                          },
                          icon: Icon(
                            Icons.search_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookMarkScreen(username: widget.username)));
                          },
                          icon: Icon(
                            Icons.star_border_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                          iconSize: 20,
                          onPressed: ()  {
                            
                          },
                          icon: Icon(
                            Icons.person_2_outlined,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: userData != null
            ? _buildProfileScreen()
            :  Center(child: SpinKitCubeGrid(
          color: Color(0xffB81736),
          size: 80,
        ),),
    );
  }
}
