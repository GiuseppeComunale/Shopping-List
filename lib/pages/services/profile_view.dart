import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/account/controllers/autenticazione.dart';
import 'package:prototipo_shopping_list/account/login_screen.dart';
import 'package:prototipo_shopping_list/pages/homepage.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  dynamic nome;

  dynamic email;

  dynamic data;

  dynamic immagine;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: Provider.of<Autenticazione>(context).getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;

    showSignOut(context, user);
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60.0,
        ),
        SizedBox(
          child: CircleAvatar(
            child: ClipOval(
              child: Image(
                image: immagine,
                height: 190.0,
                width: 190.0,
              ),
            ),
            backgroundColor: Colors.white,
            radius: 88.0,
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Divider(
          color: Colors.grey,
        ),
        SizedBox(
          height: 16.0,
        ),
        Padding(
            padding: const EdgeInsets.all(11.0),
            child: Row(children: [
              SizedBox(
                width: 30.0,
                child: Icon(
                  Icons.person_rounded,
                  size: 15.0,
                  color: Colors.grey[900],
                ),
              ),
              Text(
                "\tNome: ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                    backgroundColor: profiloTypeColor),
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                "$nome",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontSize: 13.0,
                ),
              ),
            ])),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(children: [
            SizedBox(
              width: 30.0,
              child: Icon(
                Icons.email_rounded,
                size: 15.0,
                color: Colors.grey[900],
              ),
            ),
            Text(
              "\tEmail: ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17.0,
                color: Colors.white,
                backgroundColor: profiloTypeColor,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "$email",
              style: TextStyle(
                  decoration: TextDecoration.underline, fontSize: 13.0),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(11.0),
          child: Row(children: [
            SizedBox(
                width: 30.0,
                child: Icon(
                  Icons.access_time_rounded,
                  size: 15.0,
                  color: Colors.grey[900],
                )),
            Text(
              "\tData creazione: ",
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                backgroundColor: profiloTypeColor,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text("$data",
                style: TextStyle(
                  fontSize: 13.0,
                  decoration: TextDecoration.underline,
                ))
          ]),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 16, right: 25.0, top: 30.0, bottom: 30.0),
            child: TextButton(
              child: Row(
                children: [
                  Text('\tEsci\t'),
                  Icon(
                    Icons.logout_rounded,
                    size: 16,
                  ),
                ],
              ),
              onPressed: () async {
                try {
                  if (FirebaseAuth.instance.currentUser?.uid == null) {
                    erroreUtenteNonLoggato();
                  } else {
                    await auth.signOut().whenComplete(() {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    });
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              style: TextButton.styleFrom(
                elevation: 10.0,
                side: BorderSide(
                  color: Colors.grey[900],
                ),
                primary: Colors.white,
                backgroundColor: profiloTypeColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Row(children: [
                Text('Accedi'),
                Icon(
                  Icons.login_rounded,
                  size: 16,
                )
              ]),
              onPressed: () {
                try {
                  if (FirebaseAuth.instance.currentUser?.uid != null) {
                    erroreUtenteLoggato();
                  } else {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                } catch (e) {
                  print(e.toString());
                }
              },
              style: TextButton.styleFrom(
                elevation: 10.0,
                side: BorderSide(color: Colors.grey[900]),
                primary: Colors.white,
                backgroundColor: profiloTypeColor,
              ),
            ),
          ),
        ])
      ],
    );
  }

  showSignOut(context, dynamic user) {
    try {
      nome = user?.displayName ?? 'Nome Assente';
      email = user?.email ?? "Nessun accesso";

      if (nome == 'Nome Assente') {
        data = 'no data';
        immagine = AssetImage('assets/no-image.png');
      } else {
        FirebaseAuth.instance.currentUser.providerData[0].providerId ==
                'google.com'
            ? immagine = NetworkImage(
                user.photoURL,
                scale: 0.01,
              )
            : immagine = AssetImage(user.photoURL);
        data = DateFormat('dd/MM/yyyy').format(user?.metadata?.creationTime);
      }
    } catch (e) {
      print(e);
    }
  }

  erroreUtenteLoggato() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.grey[300],
      content: Text(
        'Per cambiare account effettua prima il Log out',
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.black),
      ),
    ));
  }

  erroreUtenteNonLoggato() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      backgroundColor: Colors.grey[300],
      content: Text(
        'Nessun Log in effettuato',
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.black),
      ),
    ));
  }
}
