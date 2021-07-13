import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/pages/services/profile_view.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';
import 'package:prototipo_shopping_list/standard/my_drawer.dart';

class Profilo extends StatefulWidget {
  @override
  _ProfiloState createState() => _ProfiloState();
}

class _ProfiloState extends State<Profilo> {
  Image images = Image(image: AssetImage('assets/noAccount2.jpg'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: profiloTypeColor,
          centerTitle: true,
          title: Text(
            'Profilo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
            ),
          ),
          elevation: 0.0,
        ),
        drawer: MyDrawer(),
        body: ProfileView());
  }
}
