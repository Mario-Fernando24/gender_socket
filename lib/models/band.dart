class Band{

  String? id;
  String? name;
  int ?votes;


  Band({
     this.id,
     this.name,
     this.votes
  });

  //recibo un mapa con la llave de tipo string con valores dynamicos
  //retorno una nueva instancia con los type de valores que le estoy diciendo
  factory Band.fromMap(Map<String, dynamic> obj)
  =>Band(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes']
  );
     
  



} 