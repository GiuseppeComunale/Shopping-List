import 'dart:math';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/account/controllers/autenticazione.dart';
import 'package:prototipo_shopping_list/account/login_screen.dart';
import 'package:prototipo_shopping_list/pages/homepage.dart';
import 'package:prototipo_shopping_list/pages/profilo.dart';
import 'package:prototipo_shopping_list/standard/costanti.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Autenticazione auth = Autenticazione();
  String email;
  String nome;
  String immagine;
  String password;
  Random rand = Random();
  String error = '';
  bool isHiddenPassword = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void _togglePasswordView() {
    if (isHiddenPassword == true) {
      isHiddenPassword = false;
    } else {
      isHiddenPassword = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(children: [
                SizedBox(
                  width: 10.0,
                ),
                IconButton(
                    icon: Icon(Icons.close_rounded),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => Profilo(),
                        ),
                      );
                    })
              ]),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image(
                        height: 130,
                        width: 130,
                        image: AssetImage('assets/login-immagine.png'),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Text('Registrati qui',
                            style: TextStyle(fontSize: 30.0))),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome Utente'),
                                validator: (_val) {
                                  if (_val.isEmpty) {
                                    return error =
                                        'Il campo non può essere vuoto. Immeti un nome';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    nome = val;
                                  });
                                },
                              ),
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email'),
                              validator: (_val) {
                                if (!EmailValidator.validate(_val)) {
                                  return error = 'Inserisci una email valida';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 15.0),
                              child: TextFormField(
                                obscureText: isHiddenPassword,
                                decoration: InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: _togglePasswordView,
                                      child: isHiddenPassword
                                          ? Icon(Icons.visibility_off_rounded)
                                          : Icon(Icons.visibility_rounded),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Password'),
                                validator: (_val) {
                                  if (_val.length < 6) {
                                    return error =
                                        'Inserisci una password di almeno 6 caratteri';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                              ),
                            ),
                            //Bottone di registrazione email e password
                            ElevatedButton(
                              onPressed: () async {
                                try {
                                  if (formkey.currentState.validate()) {
                                    immagine =
                                        randImageAccount[rand.nextInt(6)];
                                    dynamic result = await auth
                                        .registerWithEmailAndPassword(
                                            email.trim(),
                                            password,
                                            nome,
                                            immagine)
                                        .then(
                                          (v) => Navigator.of(context)
                                              .pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) => HomePage(),
                                            ),
                                          ),
                                        );
                                    if (result == null) {
                                      setState(
                                        () {
                                          error = 'Inserire una email valida';
                                        },
                                      );
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  print(e);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  onPrimary: Colors.white),
                              child: Text('Registrati'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    //Link per andare alla pagina di Accesso(Login screen)
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      },
                      child: Text('Accedi qui'),
                    ),
                    SizedBox(
                      height: 15.0,
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
