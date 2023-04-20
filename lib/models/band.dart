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
    id: obj.containsKey('id') ? obj['id']: 'no-id',
    name:  obj.containsKey('name') ? obj['name']: 'no-name',
    votes:  obj.containsKey('votes') ? obj['votes']: 0
  );
     
  



} 