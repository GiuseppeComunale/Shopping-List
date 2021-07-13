import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:prototipo_shopping_list/account/controllers/autenticazione.dart';
import 'package:prototipo_shopping_list/pages/homepage.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Shopping List';

  @override
  Widget build(BuildContext context) => Provider(
        create: (context) => Autenticazione(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: title,
          home: MySplashScreen(),
        ),
      );
}

class MySplashScreen extends StatefulWidget {
  MySplashScreen({Key key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
          transitionDuration: Duration(seconds: 1),
          transitionsBuilder: (_, animation, secAnim, child) {
            var tween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: Curves.easeInOutCirc),
            );
            return FadeTransition(
              opacity: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blue[100]),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 66.0,
                        child: Image(
                          height: 100,
                          image: AssetImage('assets/icona-appbianca.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Text(
                        "Shopping List",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 30.0,
                      ),
                    ),
                    Text(
                      "FROM",
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[850],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Shopping List Team',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.orange[600],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
