import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/account/login_screen.dart';
import 'package:prototipo_shopping_list/pages/services/rating_app.dart';
import 'package:prototipo_shopping_list/pages/services/valuta_app_view.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';
import 'package:prototipo_shopping_list/standard/my_drawer.dart';

class ValutaApp extends StatefulWidget {
  const ValutaApp({Key key}) : super(key: key);

  @override
  _ValutaAppState createState() => _ValutaAppState();
}

class _ValutaAppState extends State<ValutaApp> {
  String nomePagina = 'Valuta App';
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser?.uid == null) {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: valutaAppTypeColor,
          title: Text(nomePagina,
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.star_border_rounded,
              color: Colors.grey[850],
              size: 70.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              "Per poter lasciare un voto alla nostra app",
              style: TextStyle(color: Colors.grey[400]),
            ),
            Text("Premi il tasto e accedi con il tuo account",
                style: TextStyle(color: Colors.grey[400])),
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    style: TextButton.styleFrom(primary: valutaAppTypeColor),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()));
                    },
                    icon: Icon(Icons.login_rounded),
                    label: Text(
                      "Accedi",
                      style: TextStyle(color: valutaAppTypeColor),
                    ))
              ],
            )
          ],
        ),
      );
    } else {
      return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          backgroundColor: valutaAppTypeColor,
          centerTitle: true,
          title: Text(nomePagina,
              style: TextStyle(color: Colors.white, fontSize: 25.0)),
        ),
        body: RatingApp(
          builder: (rateMyApp) => ValutaAppView(rateMyApp: rateMyApp),
        ),
      );
    }
  }
}
