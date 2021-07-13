import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/pages/altro.dart';
import 'package:prototipo_shopping_list/pages/cibo.dart';
import 'package:prototipo_shopping_list/pages/elettronica.dart';
import 'package:prototipo_shopping_list/pages/giochi.dart';
import 'package:prototipo_shopping_list/pages/homepage.dart';
import 'package:prototipo_shopping_list/pages/libri.dart';
import 'package:prototipo_shopping_list/pages/profilo.dart';
import 'package:prototipo_shopping_list/pages/valuta_app.dart';
import 'package:prototipo_shopping_list/pages/vestiti.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0, top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => Profilo()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: profiloTypeColor, width: 2),
                        borderRadius: BorderRadius.circular(40)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 33.0,
                      child: ClipOval(
                        child:
                            FirebaseAuth.instance.currentUser?.photoURL != null
                                ? Image(
                                    image: FirebaseAuth.instance.currentUser
                                                ?.providerData[0].providerId ==
                                            'google.com'
                                        ? NetworkImage(FirebaseAuth
                                            .instance.currentUser?.photoURL)
                                        : AssetImage(FirebaseAuth
                                            .instance.currentUser?.photoURL))
                                : Image(
                                    height: 83,
                                    width: 83,
                                    image: AssetImage('assets/no-image.png'),
                                  ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_rounded,
                size: 16.0,
                color: profiloTypeColor,
              ),
              SizedBox(
                width: 5.0,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => Profilo()));
                },
                child: Text(
                  FirebaseAuth.instance.currentUser?.email != null
                      ? FirebaseAuth.instance.currentUser.email
                      : 'Nessun accesso effettuato',
                  style: TextStyle(color: Colors.blue[700], fontSize: 13),
                ),
              ),
            ],
          ),
          Divider(
            height: 10.0,
            color: Colors.grey[850],
          ),
          ListTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading:
                Icon(Icons.home_rounded, color: homePageTypeColor, size: 20.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey[850],
          ),
          Text(
            '\t\t\tCATEGORIE',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey[400], fontSize: 15),
          ),
          ListTile(
              title: Text(
                'Cibo',
                style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
              ),
              leading: Icon(Icons.local_dining_rounded,
                  color: ciboTypeColor, size: 20.0),
              onTap: () async {
                Navigator.of(context).pop();
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => Cibo()));
              }),
          ListTile(
            title: Text(
              'Elettronica',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.devices_other_rounded,
                color: elettronicaTypeColor, size: 20.0),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Elettronica()));
            },
          ),
          ListTile(
            title: Text(
              'Giochi',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading:
                Icon(Icons.gamepad_rounded, color: giochiTypeColor, size: 20.0),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Giochi()));
            },
          ),
          ListTile(
            title: Text(
              'Vestiti',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.local_mall_rounded,
                color: vestitiTypeColor, size: 20.0),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Vestiti()));
            },
          ),
          ListTile(
            title: Text(
              'Libri',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading:
                Icon(Icons.book_rounded, color: libriTypeColor, size: 20.0),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Libri()));
            },
          ),
          ListTile(
            title: Text(
              'Altro',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Altro()));
            },
            leading: Icon(Icons.add_shopping_cart_rounded,
                color: altroTypeColor, size: 20.0),
          ),
          Divider(
            height: 10.0,
            color: Colors.grey[850],
          ),
          Text(
            '\t\t\tLE MIE INFORMAZIONI',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey[400], fontSize: 15),
          ),
          ListTile(
            title: Text(
              'Profilo',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading: Icon(Icons.person, color: profiloTypeColor, size: 20.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Profilo()));
            },
          ),
          Divider(
            height: 10.0,
            color: Colors.grey[850],
          ),
          Text(
            '\t\t\tAlLTRI SERVIZI',
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.grey[400], fontSize: 15),
          ),
          ListTile(
            title: Text(
              'Valuta App',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
            ),
            leading:
                Icon(Icons.star_rounded, color: valutaAppTypeColor, size: 20.0),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ValutaApp()));
            },
          ),
        ],
      ),
    );
  }
}
