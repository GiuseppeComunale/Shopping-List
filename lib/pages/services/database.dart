import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  final String tipoPagina;
  final String titoloLista;
  final String idLista;
  final String idElemento;

  DatabaseService(
      {this.uid,
      this.tipoPagina,
      this.titoloLista,
      this.idLista,
      this.idElemento});

  final CollectionReference utentiCollection =
      FirebaseFirestore.instance.collection('Utenti');

  Future updateUserData(String name, String email, dynamic provider) async {
    if (provider != 'google.com') provider = 'other';
    return await utentiCollection.doc(uid).set({
      'nome': name,
      'email': email,
      'provier': provider,
      'Voto App': null,
    });
  }

  Future creaListaPerPagina() async {
    return await utentiCollection
        .doc(uid)
        .collection(tipoPagina)
        .doc(idLista)
        .set({
      'Id Lista': idLista,
      'Uid': titoloLista,
      'Ultima Modifica': DateTime.now(),
      'Totale Spesa': 0
    });
  }

  Future aggiungiElementoAllaLista(var elem) async {
    var ref = utentiCollection
        .doc(uid)
        .collection(tipoPagina)
        .doc(idLista)
        .collection('Lista')
        .doc(elem['Id Elemento']);

    ref.set(elem);
  }

  ///cancellare lista
  deleteLista(x) {
    utentiCollection
        .doc(uid)
        .collection(tipoPagina)
        .doc(x)
        .collection('Lista')
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((element) {
        element.reference.delete();
      });
    }).then((value) {
      utentiCollection.doc(uid).collection(tipoPagina).doc(x).delete();
    });
  }

  ///cancellare elemento in una lista
  deleteElemento(x) {
    var ref = utentiCollection
        .doc(uid)
        .collection(tipoPagina)
        .doc(idLista)
        .collection('Lista')
        .doc(x);
    ref.delete();
  }

  updateElemento(prezzo, elemento, done) {
    var newData = {
      'Id Elemento': elemento.idElemento,
      'Elemento': elemento.elemento,
      'Prezzo': prezzo,
      'Descrizione': elemento.descrizione,
      'Ultima Modifica': DateTime.now(),
      'Stato': done
    };

    var ref = utentiCollection
        .doc(uid)
        .collection(tipoPagina)
        .doc(idLista)
        .collection('Lista')
        .doc(elemento.idElemento);
    ref.update(newData);
  }

  updateAnteprimaLista(dynamic totaleSpesa) {
    var newAnteprima = {
      'Id Lista': idLista,
      'Uid': titoloLista,
      'Ultima Modifica': DateTime.now(),
      'Totale Spesa': totaleSpesa
    };

    var ref = utentiCollection.doc(uid).collection(tipoPagina).doc(idLista);
    ref.set(newAnteprima);
  }

  campoValutazioneApp(
      String name, String email, dynamic provider, dynamic voto) async {
    if (provider != 'google.com') provider = 'other';
    return await utentiCollection.doc(uid).set(
        {'nome': name, 'email': email, 'provier': provider, 'Voto App': voto});
  }
}
