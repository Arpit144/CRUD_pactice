import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {


  final _formkey = GlobalKey<FormState>();

  var name ="";
  var email ="";
  var password ="";

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

@override
  void dispose() {
        nameController.dispose();
        emailController.dispose();
        passwordController.dispose();
    super.dispose();
  }

  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  CollectionReference students =
  FirebaseFirestore.instance.collection('students');
  Future<void> addUser(){
    return students
        .add({"name": name , "email": email , "password" : password})
        .then((value) => print('Student added successfully'))
        .catchError((error) => print('Failed to Delete user: $error'));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Student Entry'),
      centerTitle: true,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
              ),


              SizedBox(height: 15,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Email';
                  }else if(!value.contains('@')){
                    return 'Please Enter Valid Email';
                  }
                  return null;
                },
              ),

              SizedBox(height: 15,),
              TextFormField(
                obscureText: true,
                obscuringCharacter: '*',
                controller: passwordController,
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {

                    if(_formkey.currentState!.validate()){
                      setState(() {
                        name = nameController.text;
                        email = emailController.text;
                        password = passwordController.text;
                        addUser();
                        clearText();
                        Navigator.pop(context);
                      });
                    }



                  }, child: Text('Save Data'),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                  ElevatedButton(onPressed: () {
                    clearText();
                  }, child: Text('Reset'),
                    style: ElevatedButton.styleFrom(primary: Colors.black12),

                  ),

                ],
              )
            ],
          ),
        )
      ),

    );
  }
}
