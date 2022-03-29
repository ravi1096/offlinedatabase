import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
//
class DbHelper{

//   // CRUD Operation(Create , Read, Update, Delete)
  // location
//   // create table

  Future<Database> createDatabase()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');

    // open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE contactbook (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, contact TEXT,birth TEXT)');
        });

     return database;
  }

  void insertData(Database db, String name, String contact,String birth) async{
    String qry = "insert into contactbook (name,contact,birth) values ('$name','$contact','$birth')";
    int i = await db.rawInsert(qry);

    print(i);
 }



}
