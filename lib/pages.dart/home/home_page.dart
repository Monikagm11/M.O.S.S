//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl_standalone.dart';

//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:moss_project/db.dart/dbservices.dart';
import 'package:moss_project/model.dart/contacts.dart';
import 'package:permission_handler/permission_handler.dart';  

class HomePage extends StatefulWidget {
  //const HomePage({super.key});
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts=[];
  List<Contact> contactsFiltered=[];
  DatabaseHelper _databaseHelper=DatabaseHelper();
  TextEditingController search_controller=TextEditingController();
  @override
  void initState(){
    super.initState();
    askPermission();
  }
  
  String flattenPhoneNumber(String phoneStr){
    return phoneStr.replaceAllMapped(RegExp(r'^(\+)|\D'), ( m) {
     return m[0] == "+" ? "+" : "";
    });
  }
  filterContact(){
    List<Contact> _contacts=[];
    _contacts.addAll(contacts);
    if (search_controller.text.isNotEmpty) {
      _contacts.retainWhere((element) {
        String searchTerm = search_controller.text.toLowerCase();
        String searchTermFlattren=flattenPhoneNumber(searchTerm);
        String contactName = element.displayName!.toLowerCase();
        bool nameMatch = contactName.contains(searchTerm);
        if (nameMatch==true) {
          
         return true;
          
        }
        if (searchTermFlattren.isEmpty) {
          return false;
        }
        var phone=element.phones!.firstWhere((p) {
          String phnFlattered =flattenPhoneNumber(p.value!);
          return phnFlattered.contains(searchTermFlattren);
        });
        return phone.value!=null;
      });
    }
    setState(() {
      contactsFiltered=_contacts;
    });
  }


  Future <void> askPermission() async{
    PermissionStatus permissionStatus=await getContactsPermissions();
    if (permissionStatus==PermissionStatus.granted) {
      getAllContacts();
      search_controller.addListener(() {
        filterContact();
      });
    } else {
      handInvaliedpermissions(permissionStatus);
    }
  }

  handInvaliedpermissions(PermissionStatus permissionStatus ){
    if (permissionStatus==permissionStatus.isDenied) {
      dialogueBox(BuildContext context,String text){
        showDialog(
        context: context,
         builder: (context) => AlertDialog(
          title:Text("Acess to the contacts denied by the user") ,
         ),);
      }
      
    } else if (permissionStatus==permissionStatus.isPermanentlyDenied) {
      dialogueBox(BuildContext context,String text){
        showDialog(
        context: context,
         builder: (context) => AlertDialog(
          title:Text("Maybe contact does not exist in this device") ,
         ),);
      }
      
    }
      
    

  }
   Future getContactsPermissions() async{
    PermissionStatus permission =await Permission.contacts.status;
    if(permission!=PermissionStatus.granted && permission!=PermissionStatus.permanentlyDenied){
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    }
    else{
      return permission;

    }

   }

    getAllContacts() async{
      List<Contact> _contacts = await ContactsService.getContacts();
      setState(() {
        contacts=_contacts;
      });

    }
  
  @override
  Widget build(BuildContext context) {
    bool isSearching=search_controller.text.isNotEmpty;
    bool listItemExit=(contactsFiltered.length>0|| contacts.length >0);
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Color.fromARGB(255, 143, 9, 167),
        elevation: 0,
        actions: [MaterialButton(
              onPressed: (){
              FirebaseAuth.instance.signOut();
            },
            color: Colors.purple,
            child:Text('Sign Out'),
            )],
        
        
      ) ,
      body:contacts.length==0
      ? Center(child: CircularProgressIndicator()):
      
       SafeArea(
         child: Column(
           children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: search_controller,
                autofocus: true,
                decoration: InputDecoration(
                  labelText: "Search Contacts",
                  prefixIcon: Icon(Icons.search),
       
                ),
              ),
            ),
            listItemExit==true?
             Expanded(
               child: ListView.builder(
                itemCount: isSearching==true ? contactsFiltered.length :contacts.length,
                itemBuilder: (BuildContext context,int index) 
                {
                  Contact contact=isSearching==true ?contactsFiltered[index]: contacts[index];
                  return ListTile(
                  title: Text(contact.displayName??""),
                  subtitle:Text(contact.phones!.first.value!) ,
                  leading:contact.avatar!=null && contact.avatar!.length>0?
                  CircleAvatar(
                    backgroundImage:MemoryImage(contact.avatar!) ,
                  ):CircleAvatar(
                    backgroundColor: Colors.purple,
                    child:Text(contact.initials()),
                  ) ,
                                onTap: () {
                                  if (contact.phones!.length > 0) {
                                    final String phoneNum =
                                        contact.phones!.elementAt(0).value!;
                                    final String name = contact.displayName!;
                                    _addContact(Tcontact(phoneNum, name));
                                  } else {
                                    Fluttertoast.showToast(
                                        msg:
                                            "Oops! phone number of this contact does not exist");
                                  }
                                },
             
                );
                },
                
                ),
             ) : Container(
              child:Text("Searching"),
             ),
           ],
         ),
       ),
        
          
        
        
        
    );
  }
  void _addContact(Tcontact newContact) async {
    int result = await _databaseHelper.insertContact(newContact);
    if (result != 0) {
      Fluttertoast.showToast(msg: "contact added successfully");
    } else {
      Fluttertoast.showToast(msg: "Failed to add contacts");
    }
    Navigator.of(context).pop(true);
  }
}