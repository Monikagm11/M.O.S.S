import 'package:flutter/material.dart';
import'../model.dart/contacts.dart';
import '../db.dart/dbservices.dart';
import '../pages.dart/addcontacts.dart';

class TrustedContactPage extends StatelessWidget {
  // DatabaseHelper databaseHelper = DatabaseHelper();
  // List<Tcontact> contactList = [];
   DatabaseHelper databaseHelper=DatabaseHelper();
  List<Tcontact>? contactList=[];


  

  void showContact(Tcontact contact) async {
    //await databaseHelper.getContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        ListTile(
            leading: TextButton(
              child: Text('Trusted Contact'),
              onPressed: () {
                showContact(Tcontact contact) async {
    await databaseHelper.getContactList();
  };
              },
            ),
            trailing: TextButton(
                child: const Text('Edit'),
                 onPressed: () async{
               bool result= await Navigator.push(

                              context, MaterialPageRoute(builder: ((context) => AddContactsPage()
                             )));
            },
                ))
      ],
    ));
  }
}
