import 'dart:async';
import 'package:flutter/material.dart';
import 'Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Authentications.dart';


class MyHomePage extends StatefulWidget {
  @override
  State createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  //***************Creating Animation for App Icon*****************
  AnimationController _iconAnimationController;
  Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );
    _iconAnimation = new CurvedAnimation(
        parent: _iconAnimationController,
        curve: Curves.easeOut
    );
    _iconAnimation.addListener(()=> this.setState((){}));
    _iconAnimationController.forward();
  }
  // #####################Creating Animation Ends#########################

//  //*********************Authentication For Login***************************

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async{
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    FirebaseUser user = await _auth.signInWithGoogle(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    print("User: ${user.displayName}");
    return user;
  }

  void _signOut(){
    googleSignIn.signOut();

    print("User signed out");
  }

//  //#####################Authentication functions Ends##########################

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.red,
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new FlutterLogo(
                size: _iconAnimation.value * 100.0,
              ),
              new Form(
                child: new Theme(
                  data: new ThemeData(
                      brightness: Brightness.dark,
                      primarySwatch: Colors.teal,
                      inputDecorationTheme: new InputDecorationTheme(
                          labelStyle: new TextStyle(
                            color: Colors.amber,
                            fontSize: 20.0,
                          )
                      )
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new TextField(
                          decoration: new InputDecoration(
                              labelText: "Enter Email",
                              hintText: "xyz@gmail.com"
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        new TextField(
                          decoration: new InputDecoration(
                              labelText: "Enter Password"
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: true,
                        ),
                        new Padding(padding: const EdgeInsets.only(top: 20.0)),
                        new MaterialButton(
                          onPressed: () {Navigator.of(context).pushNamed("/Homepage");},
//                          onPressed: () => _signIn()
//                              .then((FirebaseUser user) => print(user))
//                              .catchError((e) => print(e))
//                              .whenComplete(() {Navigator.of(context).pushNamed("/Homepage");}),
                          color: Colors.amber,
                          textColor: Colors.deepOrangeAccent,
                          child: new Text("Login"),
                          splashColor: Colors.deepOrangeAccent,
                        )
                      ],
                    ),
                  ),
                ),)
            ],
          )
        ],
      ),
    );
  }
}