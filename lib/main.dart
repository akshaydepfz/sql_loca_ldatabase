import 'package:database_helper/database_helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("SQL Database"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                onPressed: () async {
                  int i = await DatabaseHelper.instance.insert({
                    DatabaseHelper.ColumnName: 'Akshay',
                  });
                  print('the inserted id $i');
                },
                child: Text('Insert'),
                color: Colors.yellow,
              ),
              FlatButton(
                onPressed: () async {
                  List<Map<String, dynamic>> quaryRows =
                      await DatabaseHelper.instance.quaryAll();
                  print(quaryRows);
                },
                child: Text('Quary'),
                color: Colors.green,
              ),
              FlatButton(
                onPressed: () async {
                  int updateid = await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId: 1,
                    DatabaseHelper.ColumnName: 'Mark',
                  });
                  print(updateid);
                },
                child: Text('Update'),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: () async {
                  int roweffected = await DatabaseHelper.instance.delete(2);
                  print(roweffected);
                },
                child: Text('delete'),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
