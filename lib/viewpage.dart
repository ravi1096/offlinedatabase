import 'package:flutter/material.dart';
import 'package:offlinedatabase/DbHelper.dart';
import 'package:offlinedatabase/insertpage.dart';
import 'package:sqflite/sqflite.dart';

import 'editpage.dart';

class viewpage extends StatefulWidget {
  const viewpage({Key? key}) : super(key: key);

  @override
  _viewpageState createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  DbHelper dbHelper = DbHelper();
  Database? db;

  List<Map> list = [];

  bool ready = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initDatabase();
  }

  initDatabase() {
    // Database db = await dbHelper.createDatabase();

    dbHelper.createDatabase().then((value) async {
      db = value;

      String qry = "select * from contactbook";
      list = await db!.rawQuery(qry);

      print(list);

      ready = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contactbook"),
      ),
      body: ready
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                Map map = list[index];

                return ListTile(
                  leading: Text("${map['id']}"),
                  title: Text("${map['name']}"),
                  subtitle: Text("${map['contact']}"),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("update or delete"),
                              content: Text("enter ur choice"),
                              actions: [
                                TextButton.icon(
                                    onPressed: () async {

                                     int id = map['id'];
                                     String qry = "delete from contactbook where id = '$id'";
                                     await db!.rawDelete(qry);
                                     Navigator.pop(context);
                                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                       return viewpage();
                                     },));

                                    },
                                    icon: Icon(Icons.delete),
                                    label: Text("delete")),
                                TextButton.icon(
                                    onPressed: () {
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                        return edit(map);
                                      },));

                                    },
                                    icon: Icon(Icons.edit),
                                    label: Text("update")),
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.more_vert)),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return insertpage();
            },
          ));
        },
        child: Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
