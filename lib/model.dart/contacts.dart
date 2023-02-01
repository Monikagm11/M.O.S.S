class Tcontact{
  int? _id;
  String? _number;
  String? _name;

Tcontact(this._number,this._name);
Tcontact.withID(this._id,this._number,this._name);

//getters
int get id=> _id!;
String get number=> _number!;
String get name=> _name!;

//setters
set number(String newNumber) => this._number =newNumber;
set name(String newName)=> this._name=newName;

//convert a contact object to a map object

Map<String,dynamic> toMap(){
  var map =new Map<String,dynamic>();
  map['id']=this._id;
  map['number']=this._number;
  map['name']=this._name;
  return map;


}

//Extract a contact Object from a Map object

Tcontact.fromMapObject(Map<String,dynamic> map) {
  this._id=map['id'];
  this._number=map['number'];
  this._name=map['name'];
}
}




