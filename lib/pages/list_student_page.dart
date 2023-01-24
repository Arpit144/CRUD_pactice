import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'update_student.dart';

class ListStudentPage extends StatefulWidget {
  const ListStudentPage({Key? key}) : super(key: key);

  @override
  State<ListStudentPage> createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {

  final Stream<QuerySnapshot> studentsStream =
  FirebaseFirestore.instance.collection('students').snapshots();


  CollectionReference students =
  FirebaseFirestore.instance.collection('students');

  Future<void> deleteUser(id){
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Student Deleted Successfully')));
  }


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

        return Scaffold(
        body: Container(
          margin: EdgeInsets.all(5),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              border: TableBorder.all(),
              columnWidths: const <int ,TableColumnWidth>{
                1:FixedColumnWidth(140)
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: [
                    TableCell(child: Container(
                      color: Colors.blue.shade400,
                      child: Center(
                        child: Text('Name',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                      )
                    ),
                    TableCell(child: Container(
                      color: Colors.blue.shade400,
                      child: Center(
                        child: Text('Email',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                     )
                    ),
                    TableCell(child: Container(
                      color: Colors.blue.shade400,
                      child: Center(
                        child: Text('Action',style: TextStyle(fontSize: 20,color: Colors.white),),
                      ),
                     )
                    )
                  ],
                ),



            for (var i = 0; i < storedocs.length; i++) ...[
                TableRow(
                  children: [
                    TableCell(child: Center(
                     child: Text(storedocs[i]['name'],style: TextStyle(fontSize: 18),),
                    )
                    ),
                    TableCell(child: Center(
                      child: Text(storedocs[i]['email'],style: TextStyle(fontSize: 18),),
                    )
                    ),
                    TableCell(child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return UpdateStudentPage(id:storedocs[i]['id']);
                          },));
                        }, icon: Icon(Icons.edit,color: Colors.teal,)),
                        IconButton(onPressed: () => {deleteUser(storedocs[i]['id'])},
                            icon: Icon(Icons.delete,color: Colors.red,))
                      ],
                    ))
                  ]
                )
                ]
              ]
            ),
          ),
        ),
      );
     }
    );
  }
}
