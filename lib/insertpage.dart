import 'package:flutter/material.dart';
import 'package:offlinedatabase/DbHelper.dart';
import 'package:offlinedatabase/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class insertpage extends StatefulWidget {
  const insertpage({Key? key}) : super(key: key);

  @override
  _insertpageState createState() => _insertpageState();
}

class _insertpageState extends State<insertpage> {
  TextEditingController tname = TextEditingController();
  TextEditingController tcontact = TextEditingController();
  TextEditingController tdate = TextEditingController();

  DbHelper dbHelper = DbHelper();
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initDatabase();
  }

  initDatabase() async {
    // Database db = await dbHelper.createDatabase();

    dbHelper.createDatabase().then((value) {
      db = value;

      print(db);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Contact"),
      ),
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
                showDatePicker(
                        context: context,
                        initialEntryMode: DatePickerEntryMode.calendar,
                        initialDatePickerMode: DatePickerMode.year,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2012),
                        lastDate: DateTime(2023))
                    .then((value) {
                  print(value);
                  tdate.text = value.toString();
                  setState(() {});
                });
              },
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                String name = tname.text;
                String contact = tcontact.text;
                String birth = tdate.text;

                // db >> contactbook >> id, name = name, contact = contact

                dbHelper.insertData(db!, name, contact,birth);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                  return viewpage();
                },));
              },
              child: Text("Save"))
        ],
      ),
    );
  }
}
