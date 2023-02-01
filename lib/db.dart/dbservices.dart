import'package:sqflite/sqflite.dart';
import '../model.dart/contacts.dart';
import '../pages.dart/addcontacts.dart';

class DatabaseHelper{
  String contactTable='contact_table';
  String colId='id';
  String colContactName='name';
  String colContactNumber='number';

  //named private constructor..used to create an instance of a singleton class
  //it will be used to create an instance of databaseHelper class

  DatabaseHelper._createInstance();

  //create an instance of the database
  static DatabaseHelper? _databaseHelper;
  //this _databasehelper will be referenced using this keyword.ti helps to access getters and setters of the class.
  
  factory DatabaseHelper(){
    //it allows the constructor to return some value
    if(_databaseHelper==null){
      //create an instance of _databaseHelper if there is no instance created before
      _databaseHelper =DatabaseHelper._createInstance();
      //because of that null check this line above run once only
    }
    return _databaseHelper!;
  }

  //initialize the database
  static Database? _database;
  Future<Database> get database async{
    if(_database==null){
      _database=await initializeDatabase();

    }
    return _database!;

  }

  Future<Database> initializeDatabase() async{
    //String directoryPath=await getDatabasePath();
    String directoryPath = await getDatabasesPath();
    String dbLocation= directoryPath + 'contact.db';

    var contactDatabase=
    await openDatabase(dbLocation,version: 1,onCreate:_createDbTable );
    return contactDatabase;

  }

  void _createDbTable(Database db,int newVersion) async{
    await db.execute(
      'CREATE TABLE $contactTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colContactName TEXT,$colContactNumber TEXT)');
    
  }

  //Fetch operation get contact object from db
  Future<List<Map<String,dynamic>>> getContactMapList() async{
    Database db=await this.database;
    List<Map<String,dynamic>> result=
    await db.rawQuery('SELECT * FROM $contactTable order by $colId ASC');
    return result;
  }
  //Insert a contact object
  Future<int> insertContact(Tcontact contact) async {
    Database db = await this.database;
    var result = await db.insert(contactTable, contact.toMap());
    // print(await db.query(contactTable));
    return result;
  }

  // update a contact object
  Future<int> updateContact(Tcontact contact) async {
    Database db = await this.database;
    var result = await db.update(contactTable, contact.toMap(),
        where: '$colId = ?', whereArgs: [contact.id]);
    return result;
  }

  //delete a contact object
  Future<int> deleteContact(int id) async {
    Database db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $contactTable WHERE $colId = $id');
    // print(await db.query(contactTable));
    return result;
  }

  //get number of contact objects
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $contactTable');
    int result = Sqflite.firstIntValue(x)!;
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Contact List' [ List<Contact> ]
  Future<List<Tcontact>> getContactList() async {
    var contactMapList =
        await getContactMapList(); // Get 'Map List' from database
    int count =
        contactMapList.length; // Count the number of map entries in db table

    List<Tcontact> contactList = <Tcontact>[];
    // For loop to create a 'Contact List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      contactList.add(Tcontact.fromMapObject(contactMapList[i]));
    }

    return contactList;
  }


}