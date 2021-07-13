import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prototipo_shopping_list/pages/services/view_lista.dart';

class SearchService extends SearchDelegate<String> {
  final String tipoPagina;
  final Color colore;

  SearchService({
    this.tipoPagina,
    this.colore,
  });

  List<String> newList = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Pulisci',
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: Icon(Icons.clear_rounded),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, 'null');
        newList.clear();
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var ref = FirebaseFirestore.instance
        .collection('Utenti')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(tipoPagina)
        .get();

    ref.then((value) {
      var data = value.docs;
      newList.clear();

      data.forEach((element) {
        newList.add(element['Uid']);
      });
    });

    final suggestions = query.isEmpty
        ? newList
        : newList.where((element) => element.startsWith(query)).toList();

    return suggestions == newList
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Utenti')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(tipoPagina)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Caricamento...'),
                    SizedBox(
                      height: 8.0,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey[400],
                    )
                  ],
                ));
              } else {
                return ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(suggestions[index]),
                        onTap: () {
                          Map data = snapshot.data.docs[index].data();
                          query = suggestions[index];
                          newList.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewLista(data, tipoPagina, colore),
                            ),
                          );
                          newList.clear();
                        },
                      );
                    });
              }
            })
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Utenti')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(tipoPagina)
                .where('Uid', isGreaterThanOrEqualTo: query)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Caricamento...'),
                    SizedBox(
                      height: 8.0,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey[400],
                    )
                  ],
                ));
              } else {
                return ListView.builder(
                    itemCount: suggestions.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data.docs[index];
                      return ListTile(
                        title: Text(documentSnapshot['Uid']),
                        onTap: () {
                          Map data = snapshot.data.docs[index].data();
                          query = suggestions[index];
                          newList.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewLista(data, tipoPagina, colore),
                            ),
                          );
                          newList.clear();
                        },
                      );
                    });
              }
            });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var ref = FirebaseFirestore.instance
        .collection('Utenti')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection(tipoPagina)
        .get();

    ref.then((value) {
      var data = value.docs;
      newList.clear();

      data.forEach((element) {
        newList.add(element['Uid']);
      });
    });

    final suggestions = query.isEmpty
        ? newList
        : newList.where((element) => element.startsWith(query)).toList();

    return suggestions == newList
        ? StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Utenti')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(tipoPagina)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Caricamento...'),
                    SizedBox(
                      height: 8.0,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey[400],
                    )
                  ],
                ));
              } else {
                return ListView.builder(
                    itemCount: suggestions?.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(suggestions[index]),
                        onTap: () {
                          Map data = snapshot.data?.docs[index].data();
                          query = suggestions[index];
                          newList.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewLista(data, tipoPagina, colore),
                            ),
                          );
                          newList.clear();
                        },
                      );
                    });
              }
            })
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Utenti')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .collection(tipoPagina)
                .where('Uid', isGreaterThanOrEqualTo: query)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Caricamento...'),
                    SizedBox(
                      height: 8.0,
                    ),
                    CircularProgressIndicator(
                      backgroundColor: Colors.grey[400],
                    )
                  ],
                ));
              } else {
                return ListView.builder(
                    itemCount: suggestions?.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot documentSnapshot =
                          snapshot.data?.docs[index];

                      return ListTile(
                        title: Text(documentSnapshot['Uid']),
                        onTap: () {
                          Map data = snapshot.data.docs[index].data();
                          query = suggestions[index];
                          newList.clear();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ViewLista(data, tipoPagina, colore),
                            ),
                          );
                          newList.clear();
                        },
                      );
                    });
              }
            });
  }
}
