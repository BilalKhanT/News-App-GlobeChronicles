import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/screens/login.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  var auth = FirebaseAuth.instance;
  bool isActiveHelp = false;
  bool isActiveFav = false;
  bool isActiveHome = false;
  bool isActiveSearch = false;
  bool isActiveSaved = false;
  bool isActiveNot = false;
  bool isActiveLog = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ListTile(leading: CircleAvatar(
                backgroundColor: Colors.white24,
                child: Icon(Icons.person_outline_outlined, color: Colors.white,),
              ),
              title: Text('Bilal Khan',
              style: GoogleFonts.poppins(
                color: Colors.white,
              ),),),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('BROWSE',
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 20,
                ),),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveHome ? 288 : 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveHome = true;
                            isActiveSearch = false;
                            isActiveFav = false;
                            isActiveHelp = false;
                            isActiveSaved = false;
                            isActiveNot = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.home_outlined, color: Colors.white,),
                          ),
                          title: Text('Home', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveSearch ? 288 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveSearch = true;
                            isActiveHome = false;
                            isActiveFav = false;
                            isActiveHelp = false;
                            isActiveSaved = false;
                            isActiveNot = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.search_outlined, color: Colors.white,),
                          ),
                          title: Text('Search', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        height: 56,
                        width: isActiveFav ? 288 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveFav = true;
                            isActiveHome = false;
                            isActiveSearch = false;
                            isActiveHelp = false;
                            isActiveSaved = false;
                            isActiveNot = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.star_border_outlined, color: Colors.white,),
                          ),
                          title: Text('Favorites', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveHelp ? 288 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveHelp = true;
                            isActiveFav = false;
                            isActiveHome = false;
                            isActiveSearch = false;
                            isActiveSaved = false;
                            isActiveNot = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.dashboard_outlined, color: Colors.white,),
                          ),
                          title: Text('Help', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 45,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text('HISTORY',
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 20,
                  ),),
              ),
              Column(
                children: <Widget>[
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveSaved ? 288 : 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveSaved = true;
                            isActiveHome = false;
                            isActiveSearch = false;
                            isActiveFav = false;
                            isActiveHelp = false;
                            isActiveNot = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.bookmark_border_outlined, color: Colors.white,),
                          ),
                          title: Text('Saved News', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveNot ? 288 : 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xff281537),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                            isActiveNot = true;
                            isActiveHome = false;
                            isActiveSearch = false;
                            isActiveFav = false;
                            isActiveHelp = false;
                            isActiveSaved = false;
                            isActiveLog = false;
                          });
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.notifications_active_outlined, color: Colors.white,),
                          ),
                          title: Text('Notifications', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40,),
                  Padding(
                    padding: EdgeInsets.only(left: 24.0),
                    child: Divider(
                      height: 1,
                      color: Colors.white24,
                    ),
                  ),
                  Stack(
                    children: [
                      AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        height: 56,
                        width: isActiveLog ? 288 : 0,
                        child: Container(
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Color(0xffB81736),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isActiveLog = true;
                            isActiveHome = false;
                            isActiveSearch = false;
                            isActiveFav = false;
                            isActiveHelp = false;
                            isActiveNot = false;
                            isActiveSaved = false;
                          });
                          await auth.signOut();
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        child: ListTile(
                          leading: SizedBox(
                            height: 34,
                            width: 34,
                            child: Icon(Icons.logout_outlined, color: Colors.white,),
                          ),
                          title: Text('Logout', style: GoogleFonts.poppins(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
