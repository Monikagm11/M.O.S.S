//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../screens/bottomscreen.dart';
import '../emergencysos/sos.dart';
import 'package:moss_project/db.dart/dbservices.dart';
import 'package:moss_project/model.dart/contacts.dart';
//import '../Pages.dart/gridview.dart';
import 'package:sqflite/sqflite.dart';
import '../home/home_page.dart';

class AddContactsPage extends StatefulWidget {
  const AddContactsPage({super.key});

  @override
  State<AddContactsPage> createState() => _AddContactsPageState();
}

class _AddContactsPageState extends State<AddContactsPage> {
  DatabaseHelper databaseHelper=DatabaseHelper();
  List<Tcontact>? contactList=[];
  int count=0;

void showList(){
Future<Database> dbFuture=databaseHelper.initializeDatabase();
dbFuture.then((database) {
  Future<List<Tcontact>> contactListFuture=databaseHelper.getContactList();
 contactListFuture.then((value) {
  setState(() {
    this.contactList=value;
    this.count=value.length;
  });
 });
});
  }
void deleteContact(Tcontact contact) async{
int result=await databaseHelper.deleteContact(contact.id);
if (result!=0) {
  Fluttertoast.showToast(msg:"contact removed succesfully");
  
}
}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      showList();
    },);
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: SafeArea(
        
        child: Container(
          child:Padding(
            padding: const EdgeInsets.all(12.0),
            
              child: Column(
                children: [
                 GestureDetector(
                            
                            onTap:() async{
                            bool result= await Navigator.push(

                              context, MaterialPageRoute(builder: ((context) => HomePage()
                             )));
                             if (result==true){
                              showList();
                             }
                            },
                            child: Container(
                            padding:EdgeInsets.all(15),
                            width: 350,
                            
                            
                            decoration: BoxDecoration(
                              color:Colors.purple,
                              border:Border.all(color: Colors.white) ,
                              borderRadius: BorderRadius.circular(20),
                              //color: Colors.white,
                            ),
                            
                            child:Center(
                              child: Text(
                              'Add Trusted Contacts',
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ) ,
                              ),
                            ),
                            
                          
                                           ),
                          ),

                          
                          Expanded(
                            child: ListView.builder(
                              //shrinkWrap: true,
                              itemCount:count ,
                              itemBuilder: (BuildContext context,int index){
                                return Card(
                                  child: ListTile(
                                    title: Text(contactList![index].name),
                                    trailing:IconButton(onPressed: () {
                                      deleteContact(contactList![index]);
                                    },
                                    icon: Icon(Icons.delete),
                                    color: Colors.red,) ,
                                  ),
                                );
                              }
                              

                              ),
                          ),
                          GestureDetector(
                            
                            onTap:() async{
                            bool result= await Navigator.push(

                              context, MaterialPageRoute(builder: ((context) => BottomPage()
                             )));
                             if (result==true){
                              showList();
                             }
                            },
                            child: Container(
                            padding:EdgeInsets.all(15),
                            width: 200,
                            
                            
                            decoration: BoxDecoration(
                              color:Colors.purple,
                              border:Border.all(color: Colors.white) ,
                              borderRadius: BorderRadius.circular(20),
                              //color: Colors.white,
                            ),
                            child:Center(
                              child: Text(
                              'Next',
                              style:TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ) ,
                              ),
                            ),
                            
                          
                                           ),
                          ),



                ],
                
              ),
            
          ),
        ),
      ),
    );
  }
}

