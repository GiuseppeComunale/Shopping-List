class MyLista {
  String idElemento;
  String elemento;
  bool done;
  dynamic prezzo;
  String descrizione;
  MyLista(
      this.idElemento, this.elemento, this.descrizione, this.prezzo, this.done);

//costruttore che mi serve poi per prendere gli elementi dal database per visualizzare la lista in un secondo momento
  MyLista.fromMap(Map<String, dynamic> data) {
    idElemento = data['Id Elemento'];
    elemento = data['Elemento'];
    descrizione = data['Descrizione'];
    prezzo = data['Prezzo'];
    done = data['Stato'];
  }
}
