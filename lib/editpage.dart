import 'package:flutter/material.dart';
import 'package:offlinedatabase/viewpage.dart';
import 'package:sqflite/sqflite.dart';

import 'DbHelper.dart';

class edit extends StatefulWidget {
  Map<dynamic, dynamic> map;

  edit(this.map);


  // const edit({Key? key}) : super(key: key);

  @override
  _editState createState() => _editState();
}

class _editState extends State<edit> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController tdate = TextEditingController();

  DbHelper dbHelper = DbHelper();
  Database? db;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tname.text = widget.map['name'];
    tcontact.text = widget.map['contact'];
    tdate.text = widget.map['birth'];
    dbHelper.createDatabase().then((value) {
      db = value;

      print(db);
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tname,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tcontact,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              controller: tdate,
              decoration: InputDecoration(labelText: "birthdate",border: OutlineInputBorder()),
              onTap: () {

              },
            ),
          ),
          ElevatedButton(
              onPressed: ()  async {
                String newname = tname.text;
                String newcontact = tcontact.text;
                String newbirth = tdate.text;
                int id = widget.map['id'];
                String qry = "update contactbook set name = '$newname',contact = '$newcontact',birth = '$newbirth' where id = '$id'";
               await db!.rawUpdate(qry);
               Navigator.pushReplacement(context, MaterialPageRoute(  builder: (context) {
                 return viewpage();
               },));

              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
