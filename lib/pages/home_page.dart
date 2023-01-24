import 'package:flutter/material.dart';
import 'add_student_page.dart';
import 'list_student_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('CRUD Practice'),
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return AddStudentPage();
            },));
          }, child: Text('Add'),
            style: ElevatedButton.styleFrom(primary: Colors.indigo),
          )
        ],
      ),centerTitle: true),

      body: ListStudentPage(),
    );
  }
}
